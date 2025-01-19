`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/23 11:10:04
// Design Name: 
// Module Name: CarrySerialAdder
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


module CarrySerialAdder#(
    parameter WIDTH = 32
)(
    input [WIDTH-1:0]op1,
    input [WIDTH-1:0]op2,
    input [WIDTH-1:0]op3,
    output [WIDTH-1:0]S,
    output [WIDTH-1:0]C
    );
    
    genvar i;
    generate
        for (i = 0; i<WIDTH ;i=i+1) begin
            FullAdder  FullAdder_inst (
                .A(op1[i]),
                .B(op2[i]),
                .Cin(op3[i]),
                .S(S[i]),
                .Cout(C[i])
            );
        end
    endgenerate

endmodule
