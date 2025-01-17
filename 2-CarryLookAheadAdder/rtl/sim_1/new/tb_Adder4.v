`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/22 13:43:55
// Design Name: 
// Module Name: tb_Adder4
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


module tb_Adder4();

    reg [3:0] a;
    reg [3:0] b;
    reg cin;
    wire [3:0] c;
    wire cout;
    wire [3:0] p;
    wire [3:0] g;

    Adder4  Adder4_inst (
        .a(a),
        .b(b),
        .cin(cin),
        .c(c),
        .cout(cout),
        .p(p),
        .g(g)
    );

    initial begin
        a = 4'd5;
        b = 4'd3;
        cin = 1'b0;
        #100;
        a = 4'd15;
        b = 4'd3;
        cin = 1'b0;
        #100;
        a = 4'd5;
        b = 4'd13;
        cin = 1'b0;
        #100;
        $stop;
    end

    // always #5  clk = ! clk ;

endmodule
