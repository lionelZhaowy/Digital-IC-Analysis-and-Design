`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// ComPany: 
// Engineer: 
// 
// Create Date: 2024/10/29 12:20:44
// Design Name: 
// Module Name: fst1_sel
// Project Name: 
// Target Devices: 
// Tool Versions: 
// DescriPtion: 
// 
// DePendencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fst1_sel(
	input clk,
	input rstn,
    input 	[31:0]	data_in,
    output 	reg [5:0]	pos_out
);
    // signal defination
    reg	 [31:0]	data_in_r;
    wire [4:0]  data_chk;
    wire [15:0] Part_1;	
    wire [7:0]  Part_2;
    wire [3:0]  Part_3;
    wire [1:0]  Part_4;

	// 寄存输入
	always @(posedge clk) begin
		data_in_r <= data_in;
	end
    
    // 二分法逐步确定前导1位置
	assign Part_1 = (data_chk[4]) ? data_in_r[31:16] : data_in_r[15:0];
	assign Part_2 = (data_chk[3]) ? Part_1[15:8] : Part_1[7:0];
	assign Part_3 = (data_chk[2]) ? Part_2[7:4] : Part_2[3:0];
	assign Part_4 = (data_chk[1]) ? Part_3[3:2] : Part_3[1:0];

	assign data_chk = {|data_in_r[31:16],|Part_1[15:8],|Part_2[7:4],|Part_3[3:2],|Part_4[1]};

    // 产生输出二进制编码
	always @(posedge clk or negedge rstn) begin
		if (!rstn)begin
			pos_out <= 6'd0;
		end
		else begin
			if(|data_in_r)begin
				pos_out <= {1'b0, ~data_chk};
			end
			else begin
				pos_out <= 6'd32;
			end
		end
	end

endmodule

// module fst1_sel(
// 	input clk,
// 	input rstn,
//     input 	[31:0]	data_in_r,
//     output 	reg [5:0]	pos_out
// );
//     // signal defination
//     reg [4:0]  data_chk;
//     reg [15:0] Part_1;	
//     reg [7:0]  Part_2;
//     reg [3:0]  Part_3;
//     reg [1:0]  Part_4;
    
//     // 二分法逐步确定前导1位置
// 	always @(posedge clk or negedge rstn) begin
// 		if (!rstn)begin
// 			Part_1 <= 16'd0;
// 			Part_2 <= 8'd0;
// 			Part_3 <= 4'd0;
// 			Part_4 <= 2'd0;
// 		end
// 		else begin
// 			Part_1 <= (data_chk[4]) ? data_in_r[31:16] : data_in_r[15:0];
// 			Part_2 <= (data_chk[3]) ? Part_1[15:8] : Part_1[7:0];
// 			Part_3 <= (data_chk[2]) ? Part_2[7:4] : Part_2[3:0];
// 			Part_4 <= (data_chk[1]) ? Part_3[3:2] : Part_3[1:0];
// 		end
// 	end

// 	always @(posedge clk or negedge rstn) begin
// 		if (!rstn)begin
// 			data_chk <= 5'd0;
// 		end
// 		else begin
// 			data_chk[4] <= |data_in_r[31:16];
// 			data_chk[3] <= |Part_1[15:8];
// 			data_chk[2] <= |Part_2[7:4];
// 			data_chk[1] <= |Part_3[3:2];
// 			data_chk[0] <= |Part_4[1]; 
// 		end
// 	end

//     // 产生输出二进制编码
// 	always @(posedge clk or negedge rstn) begin
// 		if (!rstn)begin
// 			pos_out <= 6'd0;
// 		end
// 		else begin
// 			if(|data_in_r)begin
// 				pos_out <= {1'b0, ~data_chk};
// 			end
// 			else begin
// 				pos_out <= 6'd32;
// 			end
// 		end
// 	end

// endmodule
