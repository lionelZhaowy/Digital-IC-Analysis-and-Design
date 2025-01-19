`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/23 15:25:31
// Design Name: 
// Module Name: shift_1
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


module shift_2(
    input [31:0]data_in,
    input ena,
    input dir,
    output reg [31:0]data_out
    );
    always @(*) begin
        if(ena)begin
            if(dir)begin
                data_out = {data_in[1:0], data_in[31:2]};
            end
            else begin
                data_out = {data_in[29:0], data_in[31:30]};
            end
        end
        else begin
            data_out = data_in;
        end
    end
endmodule
