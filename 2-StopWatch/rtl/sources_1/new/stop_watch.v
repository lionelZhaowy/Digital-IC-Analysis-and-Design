`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/21 21:32:46
// Design Name: 
// Module Name: stop_watch
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


module stop_watch(
    input   Clk,
    input   rst_n,
    input   Clear,
    input   start_stop,
    output  [3:0]   hr_h,
    output  [3:0]   hr_l,
    output  [3:0]   min_h,
    output  [3:0]   min_l,
    output  [3:0]   sec_h,
    output  [3:0]   sec_l,
    output  start_stop_flag
    );
    // 内部信号
    // wire start_stop_flag;
    wire clk_1Hz;

    // start_stop信号上升沿检测
    posedge_detector  posedge_detector_inst (
        .Clk(Clk),
        .rst_n(rst_n),
        .din(start_stop),
        .dout(start_stop_flag)
    );

    // 时钟分频: 10MHz --> 1Hz
    clk_div_1Hz  clk_div_1Hz_inst (
        .Clk(Clk),
        .rst_n(rst_n),
        .clk_1Hz(clk_1Hz)
    );

    // Timer
    Timer  Timer_inst (
        .clk(clk_1Hz),
        .rst_n(rst_n),
        .en(start_stop_flag),
        .Clear(Clear),
        .hr_h(hr_h),
        .hr_l(hr_l),
        .min_h(min_h),
        .min_l(min_l),
        .sec_h(sec_h),
        .sec_l(sec_l)
    );
    
endmodule
