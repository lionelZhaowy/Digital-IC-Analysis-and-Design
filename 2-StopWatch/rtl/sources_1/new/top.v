`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/23 20:40:36
// Design Name: 
// Module Name: top
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


module top(
    input clk,
    input rst_n,
    input Clear,
    input start_stop,
    output [5:0] sm_bit,
    output [7:0] sm_seg,
    output Clear_filtered,
    output start_stop_filtered,
    output start_stop_flag
    );
    parameter CLK_FREQ = 10000000;//输入时钟周期20ns 50MHz
    parameter SHAKE_FREQ = 100;//消抖时长10ms
    // 声明内部信号
    wire clk_10MHz;
    wire [3:0] hr_h;
    wire [3:0] hr_l;
    wire [3:0] min_h;
    wire [3:0] min_l;
    wire [3:0] sec_h;
    wire [3:0] sec_l;

    // assign Clear_filtered = !Clear;
    // assign start_stop_filtered = !start_stop;

    // 模块实例化
    clk_wiz_0 PLL(
        // Clock out ports
        .clk_out1(clk_10MHz),     // output clk_out1
        // Status and control signals
        .resetn(rst_n), // input resetn
        // Clock in ports
        .clk_in1(clk)// input clk_in1
    );

    KeyFilter # (
        .CLK_FREQ(CLK_FREQ),
        .SHAKE_FREQ(SHAKE_FREQ)
    )
    KeyFilter_inst0 (
        .clk(clk_10MHz),
        .rst_n(rst_n),
        .key_in(Clear),
        .key_out(Clear_filtered)
    );

    KeyFilter # (
        .CLK_FREQ(CLK_FREQ),
        .SHAKE_FREQ(SHAKE_FREQ)
    )
    KeyFilter_inst1 (
        .clk(clk_10MHz),
        .rst_n(rst_n),
        .key_in(start_stop),
        .key_out(start_stop_filtered)
    );

    
    stop_watch  stop_watch_inst (
        .Clk(clk_10MHz),
        .rst_n(rst_n),
        .Clear(Clear_filtered),
        .start_stop(start_stop_filtered),
        .hr_h(hr_h),
        .hr_l(hr_l),
        .min_h(min_h),
        .min_l(min_l),
        .sec_h(sec_h),
        .sec_l(sec_l),
        .start_stop_flag(start_stop_flag)
    );

    DigtalTubeDriver  DigtalTubeDriver_inst (
        .clk(clk_10MHz),
        .rst_n(rst_n),
        .hr_h(hr_h),
        .hr_l(hr_l),
        .min_h(min_h),
        .min_l(min_l),
        .sec_h(sec_h),
        .sec_l(sec_l),
        .sm_bit(sm_bit),
        .sm_seg(sm_seg)
    );
endmodule
