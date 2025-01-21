`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/26 10:50:40
// Design Name: 
// Module Name: tb
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



module AHB_SRAM_top_tb;
    // Parameters
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

    // Ports
    reg hclk;
    reg hresetn;
    reg hwrite;
    reg [1:0] htrans;
    reg [2:0] hsize;
    reg [31:0] haddr;
    reg [2:0] hburst;
    reg [31:0] hwdata;
    wire hready;
    wire [1:0] hresp;
    wire [31:0] hrdata;

    AHB_SRAM_top  AHB_SRAM_top_inst (
        .hclk(hclk),
        .hresetn(hresetn),
        .hwrite(hwrite),
        .htrans(htrans),
        .hsize(hsize),
        .haddr(haddr),
        .hburst(hburst),
        .hwdata(hwdata),
        .hready(hready),
        .hresp(hresp),
        .hrdata(hrdata)
    );

    initial begin
        hclk = 0;
        hresetn = 0;
        hwrite = 0;
        htrans = IDLE;
        hsize = 3'b010;
        haddr = 32'h00000000;
        hburst = SINGLE;
        hwdata = 32'h00000000;
        #100;
        // // 激励1：单数据写入
        // @(posedge hclk)
        // hresetn = 1;
        // hwrite = 1;
        // haddr = 32'h00000004;
        // htrans = NONSEQ;
        // @(posedge hclk)
        // hwdata = $random;
        // // 激励2：单数据读出
        // @(posedge hclk)
        // hwrite = 0;
        // haddr = 32'h00000004;
        // htrans = NONSEQ;
        // @(posedge hclk);

        // 激励3：8拍增量突发写入
        @(posedge hclk)
        hresetn = 1;
        hwrite = 1;
        haddr = 32'h00000010;
        hburst = INCR16;
        htrans = SEQ;
        repeat(16)begin
            @(posedge hclk)
            hwdata = $random;
            haddr = haddr + 32'd4;
        end
        // @(posedge hclk) $stop;
        // 激励4：8拍增量突发读出
        @(posedge hclk)
        hwrite = 0;
        haddr = 32'h00000010;
        hburst = INCR8;
        htrans = SEQ;
        repeat(8)begin
            @(posedge hclk)
            haddr = haddr + 32'd4;
        end
        @(posedge hclk);
        @(posedge hclk) $stop;
    end

    always #5  hclk <= ! hclk ;

endmodule
