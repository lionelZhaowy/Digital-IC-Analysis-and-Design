`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/23 15:02:29
// Design Name: 
// Module Name: bsh_32
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


module bsh_32(
    input [31:0]data_in,
    input dir,
    input [4:0]sh,
    output [31:0]data_out
    );
    // 声明内部信号
    wire [31:0] data_sft1;
    wire [31:0] data_sft2;
    wire [31:0] data_sft4;
    wire [31:0] data_sft8;
    wire [31:0] data_sft16;

    // 移位器实例化
    shift_1  shift_1_inst (
        .data_in(data_in),
        .ena(sh[0]),
        .dir(dir),
        .data_out(data_sft1)
    );

    shift_2  shift_2_inst (
        .data_in(data_sft1),
        .ena(sh[1]),
        .dir(dir),
        .data_out(data_sft2)
    );

    shift_4  shift_4_inst (
        .data_in(data_sft2),
        .ena(sh[2]),
        .dir(dir),
        .data_out(data_sft4)
    );

    shift_8  shift_8_inst (
        .data_in(data_sft4),
        .ena(sh[3]),
        .dir(dir),
        .data_out(data_sft8)
    );

    shift_16  shift_16_inst (
        .data_in(data_sft8),
        .ena(sh[4]),
        .dir(dir),
        .data_out(data_sft16)
    );

    assign data_out = data_sft16;

endmodule
