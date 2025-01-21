`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/25 21:36:17
// Design Name: 
// Module Name: AHB_SRAM_top
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


module AHB_SRAM_top(
    input hclk,
    input hresetn,
    input hwrite,
    input [1:0] htrans,
    input [2:0] hsize,
    input [31:0] haddr, // 0x00000000 – 0x00003FFC
    input [2:0] hburst,
    input [31:0] hwdata,
    output hready,
    output [1:0] hresp,
    output [31:0] hrdata
    );
    // signal define
    wire sram_scn, sram_wen;
    wire [11:0] sram_a;
    wire [31:0] sram_d;
    wire [31:0] sram_q;

    // module instance
    sram_ctr_ahb  sram_ctr_ahb_inst (
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
        .hrdata(hrdata),
        .sram_scn(sram_scn),
        .sram_wen(sram_wen),
        .sram_a(sram_a),
        .sram_d(sram_d),
        .sram_q(sram_q)
    );
    
    SRAM_4096_32 SRAM (
        .clka(hclk),    // input wire clka
        .ena(!sram_scn),// input wire ena
        .wea(!sram_wen),// input wire [0 : 0] wea
        .addra(sram_a), // input wire [11 : 0] addra
        .dina(sram_d),  // input wire [31 : 0] dina
        .douta(sram_q)  // output wire [31 : 0] douta
    );

endmodule
