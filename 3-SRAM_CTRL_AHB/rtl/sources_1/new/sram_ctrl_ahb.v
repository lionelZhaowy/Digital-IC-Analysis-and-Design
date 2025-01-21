`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/25 19:57:32
// Design Name: 
// Module Name: sram_ctr_ahb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module sram_ctr_ahb(
    input hclk,
    input hresetn,
    input hwrite,
    input [1:0] htrans,
    input [2:0] hsize,
    input [31:0] haddr,
    input [2:0] hburst,
    input [31:0] hwdata,
    output reg hready,
    output reg [1:0] hresp,
    output [31:0] hrdata,
    output reg sram_scn, //低有效
    output reg sram_wen, //低有效
    output [11:0] sram_a,
    output [31:0] sram_d,
    input [31:0] sram_q
    );
    // parameter define
    // hsize == 3'b000;//8bit
    // hsize == 3'b001;//16bit
    // hsize == 3'b010;//32bit
    // hsize == 3'b011;//64bit
    // hsize == 3'b100;//128bit
    // hsize == 3'b101;//256bit
    // hsize == 3'b110;//512bit
    // hsize == 3'b111;//1024bit
    // htrans
    localparam IDLE  = 2'b00;
    localparam BUSY  = 2'b01;
    localparam NONSEQ = 2'b10;
    localparam SEQ = 2'b11;
    // hburst
    localparam SINGLE = 3'b000;//单一传输
    localparam INCR   = 3'b001;//未指定长度的增量突发
    localparam WRAP4  = 3'b010;//4拍回环突发
    localparam INCR4  = 3'b011;//4拍增量突发
    localparam WRAP8  = 3'b100;//8拍回环突发
    localparam INCR8  = 3'b101;//8拍增量突发
    localparam WRAP16 = 3'b110;//16拍回环突发
    localparam INCR16 = 3'b111;//16拍增量突发
    // hresp
    localparam OKAY  = 2'b00;
    localparam ERROR = 2'b01;
    localparam RETRY = 2'b10;
    localparam SPLIT = 2'b11;
    // FSM state
    localparam S0 = 3'b001;//地址相位
    localparam SW = 3'b010;//数据相位-写
    localparam SR = 3'b100;//数据相位-读

    // signal define
    reg [2:0] cstate, nstate, cstate_r;
    reg cnt_flag;
    reg [3:0] cnt;
    reg [2:0] hsize_r;
    reg [31:0] haddr_r;
    reg [2:0] hburst_r;

    // define cnt max by hburst
    always @(*) begin
        case (hburst)
            SINGLE: cnt_flag = (cnt==4'd0)?1'b1:1'b0;
            INCR  : cnt_flag = (cnt==4'd0)?1'b1:1'b0;
            WRAP4 : cnt_flag = (cnt==4'd3)?1'b1:1'b0;
            INCR4 : cnt_flag = (cnt==4'd3)?1'b1:1'b0;
            WRAP8 : cnt_flag = (cnt==4'd7)?1'b1:1'b0;
            INCR8 : cnt_flag = (cnt==4'd7)?1'b1:1'b0;
            WRAP16: cnt_flag = (cnt==4'd15)?1'b1:1'b0;
            INCR16: cnt_flag = (cnt==4'd15)?1'b1:1'b0;
            default:cnt_flag = (cnt==4'd0)?1'b1:1'b0;
        endcase
    end

    // FSM1
    always @(posedge hclk or negedge hresetn) begin
        if(!hresetn)begin
            cstate <= S0;
            cstate_r <= S0;
            hsize_r <= 3'd0;
            haddr_r <= 32'd0;
            hburst_r <= 3'd0;
        end
        else begin
            cstate <= nstate;
            cstate_r <= cstate;
            hsize_r <= hsize;
            haddr_r <= haddr;
            hburst_r <= hburst;
        end
    end

    // FSM2
    always @(*) begin
        case (cstate)
            S0: begin
                if(hwrite) begin
                    nstate = SW;
                end
                else begin
                    nstate = SR;
                end
            end
            SW: begin
                if(cnt_flag) begin
                    nstate = S0;
                end
                else begin
                    nstate = SW;
                end
            end 
            SR: begin
                if(cnt_flag) begin
                    nstate = S0;
                end
                else begin
                    nstate = SR;
                end
            end 
            default: nstate = S0;
        endcase
    end

    // FSM3
    always @(posedge hclk or negedge hresetn) begin
        if(!hresetn)begin
            hready <= 1'b0;
            hresp <= RETRY;
            sram_scn <= 1'b1;
            sram_wen <= 1'b0;
        end
        else begin
            hready <= 1'b1;
            hresp <= OKAY;

            case (nstate)
                S0: begin
                    // SRAM控制
                    sram_scn <= 1'b1;
                    sram_wen <= 1'b0;
                end
                SW: begin
                    // SRAM控制
                    sram_scn <= 1'b0;
                    sram_wen <= 1'b0;
                end
                SR: begin
                    // SRAM控制
                    sram_scn <= 1'b0;
                    sram_wen <= 1'b1;
                end
                default: begin
                    // SRAM控制
                    sram_scn <= 1'b1;
                    sram_wen <= 1'b0;
                end
            endcase
        end
    end

    always @(posedge hclk or negedge hresetn) begin
        if(!hresetn)begin
            cnt <= 4'd0;
        end
        else begin
            case (cstate)
                S0: begin
                    cnt <= 4'd0;
                end
                SW: begin
                    if(htrans==BUSY) begin
                        cnt <= cnt;
                    end
                    else begin
                        cnt <= cnt + 4'd1;
                    end
                end
                SR: begin
                    if(htrans==BUSY) begin
                        cnt <= cnt;
                    end
                    else begin
                        cnt <= cnt + 4'd1;
                    end
                end
                default: begin
                    cnt <= 4'd0;
                end
            endcase
        end
    end

    assign hrdata = (cstate_r==SR)?sram_q:32'd0;
    assign sram_d = (cstate==SW)?hwdata:32'd0;
    assign sram_a = ((cstate==SW)||(cstate==SR))?haddr_r[13:2]:12'd0;

endmodule
