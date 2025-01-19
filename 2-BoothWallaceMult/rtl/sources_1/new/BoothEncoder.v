`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/23 09:25:13
// Design Name: 
// Module Name: BoothEncoder
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


module BoothEncoder(
    input [2:0] code,
    output zero,// 部分积为零
    output one, // 被乘数不变s
    output two, // 被乘数左移
    output neg1,// 被乘数取反+1
    output neg2 // 被乘数左移取反+1
    );
    assign zero = (code[2]&&code[1]&&code[0]) || ((!code[2])&&(!code[1])&&(!code[0]));
    assign one = ((!code[2])&&(!code[1])&&code[0]) || ((!code[2])&&code[1]&&(!code[0]));
    assign two = (!code[2])&&code[1]&&code[0];
    assign neg1 = (code[2]&&(!code[1])&&code[0]) || (code[2]&&code[1]&&(!code[0]));
    assign neg2 = code[2]&&(!code[1])&&(!code[0]);
endmodule
