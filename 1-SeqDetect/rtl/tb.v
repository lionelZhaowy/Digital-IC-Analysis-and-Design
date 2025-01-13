`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/29 18:09:50
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



module seq_detector_tb;
    // Parameters
    parameter NUM_BIT = 18;

    //Ports
    reg clk;
    reg rst_n;
    reg din_vld;
    reg din;
    wire result;

    reg [NUM_BIT-1:0]test_vector;
    integer i;

    seq_detector  seq_detector_inst (
        .clk(clk),
        .rst_n(rst_n),
        .din_vld(din_vld),
        .din(din),
        .result(result)
    );

    initial begin
        test_vector = 18'b001110001101110000;
        clk = 1'b0;
        rst_n = 1'b0;
        din_vld = 1'b1;
        din = 1'b0;
        #55;
        rst_n = 1'b1;
        for (i=0; i <= NUM_BIT-1; i=i+1)begin
            din = test_vector[NUM_BIT-1-i];
            #10;
        end
        $stop;
    end

    always #5  clk = ! clk ;

endmodule