`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/23 09:25:13
// Design Name: 
// Module Name: WallaceTreeAdder
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


module WallaceTreeAdder(
    input [31:0] partial_in0,
    input [31:0] partial_in1,
    input [31:0] partial_in2,
    input [31:0] partial_in3,
    input [31:0] partial_in4,
    input [31:0] partial_in5,
    input [31:0] partial_in6,
    input [31:0] partial_in7,
    output [31:0] product_out
    );
    localparam CSA_WIDTH = 32; 

    // 声明内部信号
    wire [31:0] partial_shift_0;
    wire [31:0] partial_shift_1;
    wire [31:0] partial_shift_2;
    wire [31:0] partial_shift_3;
    wire [31:0] partial_shift_4;
    wire [31:0] partial_shift_5;
    wire [31:0] partial_shift_6;
    wire [31:0] partial_shift_7;
    wire [31:0] S_L0_0, C_L0_0;
    wire [31:0] S_L0_1, C_L0_1;
    wire [31:0] S_L1_0, C_L1_0;
    wire [31:0] S_L1_1, C_L1_1;
    wire [31:0] S_L2_0, C_L2_0;
    wire [31:0] S_L3_0, C_L3_0;
    wire [32:0] Sum;
    

    // 输入部分积位移
    assign partial_shift_0 = partial_in0;
    assign partial_shift_1 = partial_in1 << 2;
    assign partial_shift_2 = partial_in2 << 4;
    assign partial_shift_3 = partial_in3 << 6;
    assign partial_shift_4 = partial_in4 << 8;
    assign partial_shift_5 = partial_in5 << 10;
    assign partial_shift_6 = partial_in6 << 12;
    assign partial_shift_7 = partial_in7 << 14;


    // CarrySerialAdder实例
    // Level 0
    CarrySerialAdder # (
        .WIDTH(CSA_WIDTH)
    )CarrySerialAdder_l0_0 (
        .op1(partial_shift_0),
        .op2(partial_shift_1),
        .op3(partial_shift_2),
        .S(S_L0_0),
        .C(C_L0_0)
    );

    CarrySerialAdder # (
        .WIDTH(CSA_WIDTH)
    )CarrySerialAdder_l0_1 (
        .op1(partial_shift_3),
        .op2(partial_shift_4),
        .op3(partial_shift_5),
        .S(S_L0_1),
        .C(C_L0_1)
    );

    // Level 1
    CarrySerialAdder # (
        .WIDTH(CSA_WIDTH)
    )CarrySerialAdder_l1_0 (
        .op1(S_L0_0),
        .op2({C_L0_0[30:0], 1'b0}),
        .op3(S_L0_1),
        .S(S_L1_0),
        .C(C_L1_0)
    );

    CarrySerialAdder # (
        .WIDTH(CSA_WIDTH)
    )CarrySerialAdder_l1_1 (
        .op1({C_L0_1[30:0], 1'b0}),
        .op2(partial_shift_6),
        .op3(partial_shift_7),
        .S(S_L1_1),
        .C(C_L1_1)
    );

    // Level 2
    CarrySerialAdder # (
        .WIDTH(CSA_WIDTH)
    )CarrySerialAdder_l2_0 (
        .op1(S_L1_0),
        .op2({C_L1_0[30:0], 1'b0}),
        .op3(S_L1_1),
        .S(S_L2_0),
        .C(C_L2_0)
    );

    // Level 3
    CarrySerialAdder # (
        .WIDTH(CSA_WIDTH)
    )CarrySerialAdder_l3_0 (
        .op1({C_L1_1[30:0], 1'b0}),
        .op2(S_L2_0),
        .op3({C_L2_0[30:0], 1'b0}),
        .S(S_L3_0),
        .C(C_L3_0)
    );

    // CarryLookHeadAdder实例
    CarryLookHeadAdder  CarryLookHeadAdder_inst (
        .A(S_L3_0),
        .B({C_L3_0[30:0], 1'b0}),
        .Sum(Sum)
    );

    // 产生输出
    assign product_out = Sum[31:0];

endmodule
