`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/23 10:12:53
// Design Name: 
// Module Name: partialGen
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


module PartialGen(
    input [15:0] A,
    input zero,// 部分积为零
    input one, // 被乘数不变s
    input two, // 被乘数左移
    input neg1,// 被乘数取反+1
    input neg2,// 被乘数左移取反+1
    output [31:0] partial
    );
    // 声明内部信号
    reg [31:0] partial_reg;

    // 产生逻辑
    always @(*) begin
        if(zero)begin
            partial_reg = 32'd0;
        end
        else if(one)begin
            partial_reg = {{16{A[15]}}, A};
        end
        else if(two)begin
            partial_reg = {{15{A[15]}}, A, 1'b0};
        end
        else if(neg1)begin
            partial_reg = ~{{16{A[15]}}, A} + 1'b1;
        end
        else if(neg2)begin
            partial_reg = ~{{15{A[15]}}, A, 1'b0} + 1'b1;
        end
        else begin
            partial_reg = 32'd0;
        end
    end

    // 输出
    assign partial = partial_reg;

endmodule
