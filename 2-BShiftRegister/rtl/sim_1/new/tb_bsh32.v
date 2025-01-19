`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/23 15:43:56
// Design Name: 
// Module Name: tb_bsh32
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


module tb_bsh32();
    // Parameters

    //Ports
    reg [31:0] data_in;
    reg dir;
    reg [4:0] sh;
    wire [31:0] data_out;

    bsh_32  bsh_32_inst (
        .data_in(data_in),
        .dir(dir),
        .sh(sh),
        .data_out(data_out)
    );

    initial begin
        data_in = 32'b00011000101000000000000000000000;
        dir = 1'b0;
        sh = 5'd10;
        #100;
        data_in = 32'b00000000111111110000000000000011;
        dir = 1'b1;
        sh = 5'd20;
        #100;
        $stop;
    end

    //always #5  clk = ! clk ;

endmodule
