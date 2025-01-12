`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/29 21:58:11
// Design Name: 
// Module Name: tb
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


module bin_in2BCDcode_tb;

    // Parameters

    //Ports
    reg clk;
    reg rst_n;
    reg [7:0] bin_in;
    wire [9:0] bcd_out;

    bin_in2BCDcode  bin_in2BCDcode_inst (
        .clk(clk),
        .rst_n(rst_n),
        .bin_in(bin_in),
        .bcd_out(bcd_out)
    );

    initial begin
        clk = 1'b0;
        rst_n = 1'b0;
        bin_in = 8'd0;
        #105;
        rst_n = 1'b1;
        bin_in = 8'b10100101;
        #100;
        bin_in = 8'b11110000;
        #100;
        $finish;
    end

    always #5  clk = ! clk ;

endmodule
