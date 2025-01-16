`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/21 21:32:46
// Design Name: 
// Module Name: counter12
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


module counter#(
    parameter H_MAX = 5,
    parameter L_MAX = 9
)(
    input   clk,
    input   rst_n,
    input   clear,
    output  reg [3:0] H,
    output  reg [3:0] L,
    output  ena_out
    );
    // 内部信号
    wire L_flag, H_flag;

    assign L_flag = (L==4'd9);
    assign H_flag = ((H==H_MAX)&&(L==L_MAX));

    // 低位进位
    always @(posedge clk or negedge rst_n or posedge clear) begin
        if(!rst_n) begin
            L <= 4'd0;
        end
        else if(L_flag||clear) begin
            L <= 4'd0;
        end
        else begin
            L <= L + 4'd1;
        end
    end

    // 高位进位
    always @(posedge clk or negedge rst_n or posedge clear) begin
        if(!rst_n) begin
            H <= 4'd0;
        end
        else if(H_flag||clear) begin
            H <= 4'd0;
        end
        else if(L_flag) begin
            H <= H + 4'd1;
        end
        else begin
            H <= H;
        end
    end

    assign ena_out = H_flag;

endmodule
