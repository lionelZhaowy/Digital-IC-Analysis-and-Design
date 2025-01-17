`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/22 11:10:26
// Design Name: 
// Module Name: LookHeadCarryer4
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


module LookHeadCarryer4(
    input [15:0]p,
    input [15:0]g,
    input cin,
    output c4,
    output c8,
    output c12,
    output c16
    );
    // 内部信号声明
    wire pm0, pm1, pm2, pm3;
    wire gm0, gm1, gm2, gm3;

    // 进位产生/传播信号
    assign pm0 = p[3]  & p[2]  & p[1]  & p[0];
    assign pm1 = p[7]  & p[6]  & p[5]  & p[4];
    assign pm2 = p[11] & p[10] & p[9]  & p[8];
    assign pm3 = p[15] & p[14] & p[13] & p[12];
    assign gm0 = g[3]  | p[3]&g[2]   | p[3]&p[2]&g[1]    | p[3]&p[2]&p[1]&g[0];
    assign gm1 = g[7]  | p[7]&g[6]   | p[7]&p[6]&g[5]    | p[7]&p[6]&p[5]&g[4];
    assign gm2 = g[11] | p[11]&g[10] | p[11]&p[10]&g[9]  | p[11]&p[10]&p[9]&g[8];
    assign gm3 = g[15] | p[15]&g[14] | p[15]&p[14]&g[13] | p[15]&p[14]&p[13]&g[12];

    // 进位信号
    assign c4  = gm0 | pm0 & cin;
    assign c8  = gm1 | pm1 & c4;
    assign c12 = gm2 | pm2 & c8;
    assign c16 = gm3 | pm3 & c12;

endmodule
