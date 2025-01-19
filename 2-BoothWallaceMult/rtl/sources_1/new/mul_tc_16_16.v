`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/22 15:36:00
// Design Name: 
// Module Name: mul_tc_16_16
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


module mul_tc_16_16(
    input [15:0]a,
    input [15:0]b,
    output [31:0]product
    );
    // 声明内部信号
    wire [2:0]code_0, code_1, code_2, code_3, code_4, code_5, code_6, code_7;
    wire [31:0]partial_0, partial_1, partial_2, partial_3, partial_4, partial_5, partial_6, partial_7;
    wire zero_0, one_0, two_0, neg1_0, neg2_0;
    wire zero_1, one_1, two_1, neg1_1, neg2_1;
    wire zero_2, one_2, two_2, neg1_2, neg2_2;
    wire zero_3, one_3, two_3, neg1_3, neg2_3;
    wire zero_4, one_4, two_4, neg1_4, neg2_4;
    wire zero_5, one_5, two_5, neg1_5, neg2_5;
    wire zero_6, one_6, two_6, neg1_6, neg2_6;
    wire zero_7, one_7, two_7, neg1_7, neg2_7;

    // 产生编码
    assign code_0  = {b[1:0], 1'b0};
    assign code_1  = b[3:1];
    assign code_2  = b[5:3];
    assign code_3  = b[7:5];
    assign code_4  = b[9:7];
    assign code_5  = b[11:9];
    assign code_6  = b[13:11];
    assign code_7  = b[15:13];

    // Booth编码
    BoothEncoder  BoothEncoder_inst0 (
        .code(code_0),
        .zero(zero_0),
        .one(one_0),
        .two(two_0),
        .neg1(neg1_0),
        .neg2(neg2_0)
    );

    BoothEncoder  BoothEncoder_inst1 (
        .code(code_1),
        .zero(zero_1),
        .one(one_1),
        .two(two_1),
        .neg1(neg1_1),
        .neg2(neg2_1)
    );

    BoothEncoder  BoothEncoder_inst2 (
        .code(code_2),
        .zero(zero_2),
        .one(one_2),
        .two(two_2),
        .neg1(neg1_2),
        .neg2(neg2_2)
    );

    BoothEncoder  BoothEncoder_inst3 (
        .code(code_3),
        .zero(zero_3),
        .one(one_3),
        .two(two_3),
        .neg1(neg1_3),
        .neg2(neg2_3)
    );

    BoothEncoder  BoothEncoder_inst4 (
        .code(code_4),
        .zero(zero_4),
        .one(one_4),
        .two(two_4),
        .neg1(neg1_4),
        .neg2(neg2_4)
    );

    BoothEncoder  BoothEncoder_inst5 (
        .code(code_5),
        .zero(zero_5),
        .one(one_5),
        .two(two_5),
        .neg1(neg1_5),
        .neg2(neg2_5)
    );

    BoothEncoder  BoothEncoder_inst6 (
        .code(code_6),
        .zero(zero_6),
        .one(one_6),
        .two(two_6),
        .neg1(neg1_6),
        .neg2(neg2_6)
    );

    BoothEncoder  BoothEncoder_inst7 (
        .code(code_7),
        .zero(zero_7),
        .one(one_7),
        .two(two_7),
        .neg1(neg1_7),
        .neg2(neg2_7)
    );

    // 产生部分积
    PartialGen  PartialGen_inst0 (
        .A(a),
        .zero(zero_0),
        .one(one_0),
        .two(two_0),
        .neg1(neg1_0),
        .neg2(neg2_0),
        .partial(partial_0)
    );

    PartialGen  PartialGen_inst1 (
        .A(a),
        .zero(zero_1),
        .one(one_1),
        .two(two_1),
        .neg1(neg1_1),
        .neg2(neg2_1),
        .partial(partial_1)
    );

    PartialGen  PartialGen_inst2 (
        .A(a),
        .zero(zero_2),
        .one(one_2),
        .two(two_2),
        .neg1(neg1_2),
        .neg2(neg2_2),
        .partial(partial_2)
    );

    PartialGen  PartialGen_inst3 (
        .A(a),
        .zero(zero_3),
        .one(one_3),
        .two(two_3),
        .neg1(neg1_3),
        .neg2(neg2_3),
        .partial(partial_3)
    );

    PartialGen  PartialGen_inst4 (
        .A(a),
        .zero(zero_4),
        .one(one_4),
        .two(two_4),
        .neg1(neg1_4),
        .neg2(neg2_4),
        .partial(partial_4)
    );

    PartialGen  PartialGen_inst5 (
        .A(a),
        .zero(zero_5),
        .one(one_5),
        .two(two_5),
        .neg1(neg1_5),
        .neg2(neg2_5),
        .partial(partial_5)
    );

    PartialGen  PartialGen_inst6 (
        .A(a),
        .zero(zero_6),
        .one(one_6),
        .two(two_6),
        .neg1(neg1_6),
        .neg2(neg2_6),
        .partial(partial_6)
    );

    PartialGen  PartialGen_inst7 (
        .A(a),
        .zero(zero_7),
        .one(one_7),
        .two(two_7),
        .neg1(neg1_7),
        .neg2(neg2_7),
        .partial(partial_7)
    );

    // 部分积累加
    WallaceTreeAdder  WallaceTreeAdder_inst (
        .partial_in0(partial_0),
        .partial_in1(partial_1),
        .partial_in2(partial_2),
        .partial_in3(partial_3),
        .partial_in4(partial_4),
        .partial_in5(partial_5),
        .partial_in6(partial_6),
        .partial_in7(partial_7),
        .product_out(product)
    );


endmodule
