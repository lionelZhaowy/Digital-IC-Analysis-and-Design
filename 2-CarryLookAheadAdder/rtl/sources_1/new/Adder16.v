`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/22 10:37:56
// Design Name: 
// Module Name: Adder16
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


module Adder16(
    input [15:0]a,
    input [15:0]b,
    input cin,
    output [15:0]s,
    output cout
    );
    // 声明内部信号
    wire c4, c8, c12, c16;
    wire [15:0] p, g;
   
    // 4位加法器实例
    Adder4  Adder4_inst0 (
        .a(a[3:0]),
        .b(b[3:0]),
        .cin(cin),
        .s(s[3:0]),
        // .cout(),
        .p(p[3:0]),
        .g(g[3:0])
    );
    Adder4  Adder4_inst1 (
        .a(a[7:4]),
        .b(b[7:4]),
        .cin(c4),
        .s(s[7:4]),
        // .cout(),
        .p(p[7:4]),
        .g(g[7:4])
    );
    Adder4  Adder4_inst2 (
        .a(a[11:8]),
        .b(b[11:8]),
        .cin(c8),
        .s(s[11:8]),
        // .cout(),
        .p(p[11:8]),
        .g(g[11:8])
    );
    Adder4  Adder4_inst3 (
        .a(a[15:12]),
        .b(b[15:12]),
        .cin(c12),
        .s(s[15:12]),
        // .cout(),
        .p(p[15:12]),
        .g(g[15:12])
    );

    // 进位链信号产生实例
    LookHeadCarryer4  LookHeadCarryer4_inst (
        .p(p),
        .g(g),
        .cin(cin),
        .c4(c4),
        .c8(c8),
        .c12(c12),
        .c16(c16)
    );

    assign cout = c16;

endmodule
