`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/21 22:29:21
// Design Name: 
// Module Name: clk_div_1Hz
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


module clk_div_1Hz(
    input Clk,
    input rst_n,
    output reg clk_1Hz
    );
    localparam CNT_MAX = 5000000;
    // localparam CNT_MAX = 250000;
    // 内部信号
    reg [22:0] cnt;
    wire cnt_flag;

    assign cnt_flag = (cnt == CNT_MAX-1)?1'b1:1'b0;

    // 计数器控制
    always @(posedge Clk or negedge rst_n) begin
        if(!rst_n)begin
            cnt <= 23'd0;
        end
        else if(cnt_flag)begin
            cnt <= 23'd0;
        end
        else begin
            cnt <= cnt + 23'd1;
        end
    end

    // 分频后时钟
    always @(posedge Clk or negedge rst_n) begin
        if(!rst_n)begin
            clk_1Hz <= 1'b0;
        end
        else if(cnt_flag)begin
            clk_1Hz <= ~clk_1Hz;
        end
        else begin
            clk_1Hz <= clk_1Hz;
        end
    end

endmodule
