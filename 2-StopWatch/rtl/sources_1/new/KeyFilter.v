`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/23 20:45:43
// Design Name: 
// Module Name: KeyFilter
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


module KeyFilter#(
    parameter CLK_FREQ = 50000000,//输入时钟周期20ns 50MHz
    parameter SHAKE_FREQ = 100//消抖时长10ms
)(
    input clk,
    input rst_n,
    input key_in,
    output reg key_out
    );
    //参数定义
    localparam CNT_MAX = CLK_FREQ/SHAKE_FREQ-1;
    localparam cnt_width = 19;
    //状态编码
    localparam HIGH= 4'b0001;
    localparam H2L = 4'b0010;
    localparam L2H = 4'b0100;
    localparam LOW = 4'b1000;

    //声明状态寄存器
    reg [3:0]cstate,nstate = LOW;
    //声明内部寄存器和信号线
    reg key_in_d0,key_in_d1 = 0;//缓冲寄存器
    reg [cnt_width-1:0]clk_cnt = 0;//计数器
    wire cnt_en;//计数器计数使能信号
    wire cnt_flag;//计数器记满标志

    //打两拍将异步信号同步化 降低亚稳态的危害
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)begin
            key_in_d0 <= 1'b0;
            key_in_d1 <= 1'b0;
        end
        else begin
            key_in_d0 <= key_in;
            key_in_d1 <= key_in_d0;
        end
    end

    //延时计数器控制逻辑
    assign cnt_en = (cstate == H2L||cstate == L2H)?1'b1:1'b0;
    assign cnt_flag = (clk_cnt == CNT_MAX)?1'b1:1'b0;
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)
            clk_cnt <= 0;
        else if(cnt_flag)
            clk_cnt <= 0;
        else if(cnt_en)
            clk_cnt <= clk_cnt + 1;
        else
            clk_cnt <= clk_cnt;
    end
    
    //状态转移同步逻辑
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)
            cstate <= HIGH;//设未按下为0
        else
            cstate <= nstate;
    end

    //产生下一个状态组合逻辑
    always @(*) begin
        case (cstate)
            HIGH:begin
                if(key_in_d1)
                    nstate = HIGH;
                else
                    nstate = H2L;
            end
            H2L :begin
                if(key_in_d1)
                    nstate = HIGH;
                else begin
                    if(cnt_flag)
                        nstate = LOW;
                    else
                        nstate = H2L;
                end
            end
            LOW :begin
                if(key_in_d1)
                    nstate = L2H;
                else
                    nstate = LOW;
            end
            L2H :begin
                if(key_in_d1)
                    if(cnt_flag)
                        nstate = HIGH;
                    else
                        nstate = L2H;
                else begin
                    nstate = LOW;
                end
            end
            default:begin
                nstate = HIGH;
            end
        endcase
    end
    // always @(*) begin
    //     case (cstate)
    //         HIGH:nstate = key_in_d1?HIGH:H2L;
    //         H2L :nstate = key_in_d1?HIGH:(cnt_flag?LOW:H2L);
    //         LOW :nstate = key_in_d1?L2H:LOW;
    //         L2H :nstate = key_in_d1?(cnt_flag?HIGH:L2H):LOW;
    //         default:nstate = LOW;
    //     endcase
    // end

    //产生输出逻辑
    always @(*) begin
        case(cstate)
            HIGH:key_out = 1'b0;
            H2L :key_out = 1'b0;
            LOW :key_out = 1'b1;
            L2H :key_out = 1'b1;
            default:key_out = 1'b1;
        endcase
    end
endmodule
