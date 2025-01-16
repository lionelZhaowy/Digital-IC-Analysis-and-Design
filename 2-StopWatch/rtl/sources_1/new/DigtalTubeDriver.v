`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/23 20:21:18
// Design Name: 
// Module Name: DigtalTubeDriver
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


module DigtalTubeDriver(
    input clk,
    input rst_n,
    input [3:0] hr_h,
    input [3:0] hr_l,
    input [3:0] min_h,
    input [3:0] min_l,
    input [3:0] sec_h,
    input [3:0] sec_l,
    output reg [5:0] sm_bit,
    output reg [7:0] sm_seg
    );
    // 内部信号声明
    reg[18:0]count;//定义计数寄存器

    // 5ms扫描一轮
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)
            count<=0;
        //for sim
        else if(count == 19'd400000)
            count = 19'd0;
        else
            count = count + 1'b1;
    end	

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)begin
            sm_bit <= 6'd0;
            sm_seg <= 8'd0;
        end
        else begin
            case (count[13:11])
                3'd0: begin
                    sm_bit <= 6'b111110;
                    sm_seg <= bcd2dtube_code(sec_l);
                end
                3'd1: begin
                    sm_bit <= 6'b111101;
                    sm_seg <= bcd2dtube_code(sec_h);
                end
                3'd2: begin
                    sm_bit <= 6'b111011;
                    sm_seg <= bcd2dtube_code(min_l);
                end
                3'd3: begin
                    sm_bit <= 6'b110111;
                    sm_seg <= bcd2dtube_code(min_h);
                end
                3'd4: begin
                    sm_bit <= 6'b101111;
                    sm_seg <= bcd2dtube_code(hr_l);
                end
                3'd5: begin
                    sm_bit <= 6'b011111;
                    sm_seg <= bcd2dtube_code(hr_h);
                end
                default: begin
                    sm_bit <= 6'b111111; 
                    sm_seg <= 8'h00;
                end
            endcase
        end
    end

    // 共阴极数码管译码函数
    function  [7:0] bcd2dtube_code;
        input [3:0]disp_data;
        begin
            case(disp_data)
                4'h0:bcd2dtube_code = 8'b00111111; //显示0
                4'h1:bcd2dtube_code = 8'b00000110; //显示1
                4'h2:bcd2dtube_code = 8'b01011011; //显示2
                4'h3:bcd2dtube_code = 8'b01001111; //显示3
                4'h4:bcd2dtube_code = 8'b01100110; //显示4
                4'h5:bcd2dtube_code = 8'b01101101; //显示5
                4'h6:bcd2dtube_code = 8'b01111101; //显示6
                4'h7:bcd2dtube_code = 8'b00000111; //显示7
                4'h8:bcd2dtube_code = 8'b01111111; //显示8
                4'h9:bcd2dtube_code = 8'b01101111; //显示9
                default:bcd2dtube_code = 8'h00; //不显示
            endcase
        end
    endfunction
  
endmodule
