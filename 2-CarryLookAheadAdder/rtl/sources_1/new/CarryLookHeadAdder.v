`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/22 10:08:14
// Design Name: 
// Module Name: CarryLookHeadAdder
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


module CarryLookHeadAdder(
    input [31:0]A,
    input [31:0]B,
    output [32:0]Sum
    );

    // 声明内部信号
    wire c16;

    // 16位超前进位加法器实例
    Adder16  Adder16_inst0 (
        .a(A[15:0]),
        .b(B[15:0]),
        .cin(1'b0),
        .s(Sum[15:0]),
        .cout(c16)
    );
    Adder16  Adder16_inst1 (
        .a(A[31:16]),
        .b(B[31:16]),
        .cin(c16),
        .s(Sum[31:16]),
        .cout(Sum[32])
    );

endmodule
