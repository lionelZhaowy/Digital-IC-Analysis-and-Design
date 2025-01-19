`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/23 11:53:45
// Design Name: 
// Module Name: tb_mul_tc_16_16
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


module tb_mul_tc_16_16();

    // Parameters

    //Ports
    reg [15:0] a;
    reg [15:0] b;
    wire [31:0] product;
    reg [31:0] expected_product;  
    wire right_flag;
    integer i;

    assign right_flag = (expected_product==product)?1'b1:1'b0;

    mul_tc_16_16  mul_tc_16_16_inst (
        .a(a),
        .b(b),
        .product(product)
    );

    initial begin
        i = 0;
        a = 16'b0110000010000000;
        b = 16'b1000000000000001;
        expected_product = 32'b11001111110000000110000010000000;
        for (i=0; i<10; i=i+1)begin
            #100;
            a = $random & 16'hFFFF;  
            b = $random & 16'hFFFF; 
            expected_product = $signed(a)*$signed(b);
        end
        #100;
        $stop;
    end

    //always #5  clk = ! clk ;

endmodule
