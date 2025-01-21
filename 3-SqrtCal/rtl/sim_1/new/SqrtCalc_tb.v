`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/24 19:54:26
// Design Name: 
// Module Name: SqrtCalc_tb
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



module SqrtCal_tb;

    // Parameters

    //Ports
    reg clk;
    reg rst_n;
    reg vld_in;
    reg [31:0] x;
    wire vld_out;
    wire [15:0] y;

    SqrtCal  SqrtCal_inst (
        .clk(clk),
        .rst_n(rst_n),
        .vld_in(vld_in),
        .x(x),
        .vld_out(vld_out),
        .y(y)
    );

    initial begin
        clk = 0;
        rst_n = 0;
        vld_in = 0;
        x = 0;
        #100;
        rst_n = 1;
        // 第1个激励
        #100;
        x = 32'd256;
        vld_in = 1;
        #10 vld_in = 0;
        // 第2个激励
        @(posedge vld_out)begin
            #100;
            x = 32'd255;
            vld_in = 1;
            #10 vld_in = 0;
        end
        // 第3个激励
        @(posedge vld_out)begin
            #100;
            x = 32'd2147483648;
            vld_in = 1;
            #10 vld_in = 0;
        end
        // 第4个激励
        @(posedge vld_out)begin
            #100;
            x = 32'd4294967295;
            vld_in = 1;
            #10 vld_in = 0;
        end
        #500
        $stop;
    end

    always #5  clk <= ! clk ;

endmodule
