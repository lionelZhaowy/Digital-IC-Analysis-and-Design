`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/22 14:19:09
// Design Name: 
// Module Name: tb_CarryLookHeadAdder
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


module tb_CarryLookHeadAdder();
    //Ports
    reg [31:0] A;
    reg [31:0] B;
    wire [32:0] Sum;
    wire [32:0] Sum_expect;
    wire flag;
    integer i;

    CarryLookHeadAdder  CarryLookHeadAdder_inst (
        .A(A),
        .B(B),
        .Sum(Sum)
    );
    assign Sum_expect = A+B;
    assign flag = (Sum==Sum_expect)?1'b1:1'b0;

    initial begin
        i = 0;
        A = $signed(32'd65535);
        B = $signed(32'd65535);
        #100;
        A = $signed(32'd1);
        B = $signed(-32'd65535);
        #100;
        A = $signed(-32'd1);
        B = $signed(-32'd65535);
        for(i=0; i<10; i=i+1)begin
            #100;
            A = $random;
            B = $random;
        end
        #100;
        $stop;
    end

    //always #5  clk = ! clk ;

endmodule
