`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/29 16:07:36
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



module fst1_sel_tb;

    // Parameters

    // Ports
    reg [31:0] data_in;
    reg clk;
    reg rstn;
    wire [5:0] pos_out;

    fst1_sel  fst1_sel_inst (
        .clk(clk),
        .rstn(rstn),
        .data_in(data_in),
        .pos_out(pos_out)
    );

    // signals
    initial begin
        clk = 1'b0;
        rstn = 1'b0;
        #100;
        rstn = 1'b1;
        data_in = 32'b00011000_10000000_00000000_00000000;
        #100;
        data_in = 32'b00000000_11111111_00000000_00000000;
        #100;
        data_in = 32'b00000000_00000000_00000000_00001010;
        #100;
        $finish;
    end

    always #5 clk = ~clk;
    
endmodule