`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/29 18:28:02
// Design Name: 
// Module Name: bin_in2BCDcode
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


module bin_in2BCDcode(
    input clk,
    input rst_n,
    input [7:0]bin_in,
    output reg [9:0]bcd_out
);
    // signals
    wire [3:0] t1, t2, t3, t4, t5, t6, t7;

    // instances
    add3_g4 adder1(
        .clk(clk),
        .rst_n(rst_n),
        .in	({1'b0, bin_in[7:5]}),
        .out(t1)
    );
    add3_g4 adder2(
        .clk(clk),
        .rst_n(rst_n),
        .in	({t1[2:0], bin_in[4]}),
        .out(t2)
    );
    add3_g4 adder3(
        .clk(clk),
        .rst_n(rst_n),
        .in({t2[2:0], bin_in[3]}),
        .out(t3)
    );
    add3_g4 adder4(
        .clk(clk),
        .rst_n(rst_n),
        .in({1'b0, t1[3], t2[3], t3[3]}),
        .out(t4)
    );
    add3_g4 adder5(
        .clk(clk),
        .rst_n(rst_n),
        .in({t3[2:0], bin_in[2]}),
        .out(t5)
    );
    add3_g4 adder6(
        .clk(clk),
        .rst_n(rst_n),
        .in({t4[2:0], t5[3]}),
        .out(t6)
    );
    add3_g4 adder7(
        .clk(clk),
        .rst_n(rst_n),
        .in({t5[2:0], bin_in[1]}),
        .out(t7)
    );

    // output
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)begin
            bcd_out <= 10'd0;
        end
        else begin
            bcd_out <= {2'b0, t4[3], t6[3:0], t7[3:0], bin_in[0]};
        end
    end

endmodule


module add3_g4(
    input       clk,
    input       rst_n, 
	input		[3:0]	in,
	output reg	[3:0]	out
);
    //利用查找表实现+3操作
    always @ (posedge clk or negedge rst_n) begin
        if(!rst_n)begin
            out <= 4'd0;
        end
        else begin
            case (in) 
                4'b0101 : out <= 4'b1000;
                4'b0110 : out <= 4'b1001;
                4'b0111 : out <= 4'b1010;
                4'b1000 : out <= 4'b1011;
                4'b1001 : out <= 4'b1100;
                default : out <= in;
            endcase
        end
    end

endmodule 
