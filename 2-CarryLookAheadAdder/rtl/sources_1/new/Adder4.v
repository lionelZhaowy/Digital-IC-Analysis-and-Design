`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/22 10:37:56
// Design Name: 
// Module Name: Adder4
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


module Adder4(
    input [3:0]a,
    input [3:0]b,
    input cin,
    output [3:0]s,
    // output cout,
    output [3:0]p,
    output [3:0]g
    );
    // 声明内部信号
    wire c0, c1, c2, c3;
    wire p0, p1, p2, p3;
    wire g0, g1, g2, g3;

    // 进位产生信号
    assign g0 = a[0] & b[0];
    assign g1 = a[1] & b[1];
    assign g2 = a[2] & b[2];
    assign g3 = a[3] & b[3];

    // 进位传递信号
    assign p0 = a[0] ^ b[0];
    assign p1 = a[1] ^ b[1];
    assign p2 = a[2] ^ b[2];
    assign p3 = a[3] ^ b[3];

    // 进位信号
    assign c0 = cin;
    assign c1 = g0 | p0&c0;
    assign c2 = g1 | p1&g0 | p1&p0&c0;
    assign c3 = g2 | p2&g1 | p2&p1&g0 | p2&p1&p0&c0;

    // 和信号
    assign s[0] = p0 ^ c0;
    assign s[1] = p1 ^ c1;
    assign s[2] = p2 ^ c2;
    assign s[3] = p3 ^ c3;

    // 输出进位产生信号和传播信号
    assign p = {p3,p2,p1,p0};
    assign g = {g3,g2,g1,g0};

endmodule
