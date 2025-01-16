`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/25 21:18:26
// Design Name: 
// Module Name: tb_top
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


module tb_top();
    // Parameters

    //Ports
    reg clk;
    reg rst_n;
    reg Clear;
    reg start_stop;
    wire [5:0] sm_bit;
    wire [7:0] sm_seg;

    top  top_inst (
        .clk(clk),
        .rst_n(rst_n),
        .Clear(Clear),
        .start_stop(start_stop),
        .sm_bit(sm_bit),
        .sm_seg(sm_seg)
    );
    
    initial begin
        clk = 1'b0;
        rst_n = 1'b0;
        Clear = 1'b1;
        start_stop = 1'b1;
        #100;
        rst_n = 1'b1;
        #500;
        start_stop = 1'b0;
    end

    always #5  clk <= ! clk ;

endmodule
