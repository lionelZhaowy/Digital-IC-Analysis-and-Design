`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/21 21:40:14
// Design Name: 
// Module Name: posedge_detector
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


module posedge_detector(
    input   Clk,
    input   rst_n,
    input   din,
    output  reg dout
    );
    // 内部信号
    reg din_reg1, din_reg2;
    wire pos_flag;

    // din信号上升沿检测
    always @(posedge Clk or negedge rst_n) begin
        if(!rst_n)begin
            din_reg1 <= 1'b0;
            din_reg2 <= 1'b0;
        end
        else begin
            din_reg1 <= din;
            din_reg2 <= din_reg1;
        end
    end

    always @(posedge Clk or negedge rst_n) begin
        if(!rst_n)begin
            dout <= 1'b0;
        end
        else if(pos_flag)begin
            dout <= ~dout;
        end
        else begin
            dout <= dout;
        end
    end

    assign pos_flag = (~din_reg2) && din_reg1;

endmodule
