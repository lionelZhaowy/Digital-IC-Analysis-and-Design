`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/25 10:22:50
// Design Name: 
// Module Name: sort_32_u8
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


module sort_32_u8(
    input clk,
    input rst_n,
    input vld_in,
    input [7:0] din_0,
    input [7:0] din_1,
    input [7:0] din_2,
    input [7:0] din_3,
    input [7:0] din_4,
    input [7:0] din_5,
    input [7:0] din_6,
    input [7:0] din_7,
    input [7:0] din_8,
    input [7:0] din_9,
    input [7:0] din_10,
    input [7:0] din_11,
    input [7:0] din_12,
    input [7:0] din_13,
    input [7:0] din_14,
    input [7:0] din_15,
    input [7:0] din_16,
    input [7:0] din_17,
    input [7:0] din_18,
    input [7:0] din_19,
    input [7:0] din_20,
    input [7:0] din_21,
    input [7:0] din_22,
    input [7:0] din_23,
    input [7:0] din_24,
    input [7:0] din_25,
    input [7:0] din_26,
    input [7:0] din_27,
    input [7:0] din_28,
    input [7:0] din_29,
    input [7:0] din_30,
    input [7:0] din_31,
    output reg vld_out,
    output [7:0] dout_0,
    output [7:0] dout_1,
    output [7:0] dout_2,
    output [7:0] dout_3,
    output [7:0] dout_4,
    output [7:0] dout_5,
    output [7:0] dout_6,
    output [7:0] dout_7,
    output [7:0] dout_8,
    output [7:0] dout_9,
    output [7:0] dout_10,
    output [7:0] dout_11,
    output [7:0] dout_12,
    output [7:0] dout_13,
    output [7:0] dout_14,
    output [7:0] dout_15,
    output [7:0] dout_16,
    output [7:0] dout_17,
    output [7:0] dout_18,
    output [7:0] dout_19,
    output [7:0] dout_20,
    output [7:0] dout_21,
    output [7:0] dout_22,
    output [7:0] dout_23,
    output [7:0] dout_24,
    output [7:0] dout_25,
    output [7:0] dout_26,
    output [7:0] dout_27,
    output [7:0] dout_28,
    output [7:0] dout_29,
    output [7:0] dout_30,
    output [7:0] dout_31
    );
    // signal wire
    wire [7:0] din [31:0]; // 存放输入数据
    reg [7:0] din_pipe1 [31:0]; // 寄存输入数据
    reg [7:0] din_pipe2 [31:0]; // 寄存输入数据
    reg [5:0] flag_pipe1 [31:0][31:0]; // 2D表格，统计比较分值
    reg valid_pipe1 [31:0][31:0]; // 和后续valid_sum1_pipe1、valid_sum_pipe1判断第一阶段是否完成
    wire valid_sum1_pipe1 [31:0];
    wire valid_sum_pipe1;
    reg [4:0] flag_sum_pipe2  [31:0]; // 累积得分和
    reg valid_pipe2 [31:0]; // 和后续valid_sum_pipe2判断第二阶段是否完成
    wire valid_sum_pipe2;
    reg [7:0] din_pipe3 [31:0]; // 重排后的输出数据
    genvar i,j;

    // input data assign
    assign {din[31],din[30],din[29],din[28],din[27],din[26],din[25],din[24],
            din[23],din[22],din[21],din[20],din[19],din[18],din[17],din[16],
            din[15],din[14],din[13],din[12],din[11],din[10],din[9],din[8],
            din[7],din[6],din[5],din[4],din[3],din[2],din[1],din[0]
        } = {din_31,din_30,din_29,din_28,din_27,din_26,din_25,din_24,
            din_23,din_22,din_21,din_20,din_19,din_18,din_17,din_16,
            din_15,din_14,din_13,din_12,din_11,din_10,din_9,din_8,
            din_7,din_6,din_5,din_4,din_3,din_2,din_1,din_0};

    // compare parallel
    generate
        for (j = 0; j<32; j=j+1) begin
            assign valid_sum1_pipe1[j] = &{valid_pipe1[j][0],valid_pipe1[j][1],valid_pipe1[j][2],valid_pipe1[j][3],valid_pipe1[j][4],valid_pipe1[j][5],valid_pipe1[j][6],valid_pipe1[j][7],
                                           valid_pipe1[j][8],valid_pipe1[j][9],valid_pipe1[j][10],valid_pipe1[j][11],valid_pipe1[j][12],valid_pipe1[j][13],valid_pipe1[j][14],valid_pipe1[j][15],
                                           valid_pipe1[j][16],valid_pipe1[j][17],valid_pipe1[j][18],valid_pipe1[j][19],valid_pipe1[j][20],valid_pipe1[j][21],valid_pipe1[j][22],valid_pipe1[j][23],
                                           valid_pipe1[j][24],valid_pipe1[j][25],valid_pipe1[j][26],valid_pipe1[j][27],valid_pipe1[j][28],valid_pipe1[j][29],valid_pipe1[j][30],valid_pipe1[j][31]};
        end
    endgenerate

    assign valid_sum_pipe1 = &{valid_sum1_pipe1[0],valid_sum1_pipe1[1],valid_sum1_pipe1[2],valid_sum1_pipe1[3],valid_sum1_pipe1[4],valid_sum1_pipe1[5],valid_sum1_pipe1[6],valid_sum1_pipe1[7],
                               valid_sum1_pipe1[8],valid_sum1_pipe1[9],valid_sum1_pipe1[10],valid_sum1_pipe1[11],valid_sum1_pipe1[12],valid_sum1_pipe1[13],valid_sum1_pipe1[14],valid_sum1_pipe1[15],
                               valid_sum1_pipe1[16],valid_sum1_pipe1[17],valid_sum1_pipe1[18],valid_sum1_pipe1[19],valid_sum1_pipe1[20],valid_sum1_pipe1[21],valid_sum1_pipe1[22],valid_sum1_pipe1[23],
                               valid_sum1_pipe1[24],valid_sum1_pipe1[25],valid_sum1_pipe1[26],valid_sum1_pipe1[27],valid_sum1_pipe1[28],valid_sum1_pipe1[29],valid_sum1_pipe1[30],valid_sum1_pipe1[31]};

    generate
        for (j = 0; j<32; j=j+1) begin:loop_j
            for(i = 0; i<32; i=i+1) begin:loop_i
                always@(posedge	clk or negedge rst_n) begin
                    if(!rst_n) begin
                        valid_pipe1[j][i] <= 0;
                        flag_pipe1[j][i]  <= 0;	
                    end
                    else if(vld_in) begin
                        if(din[j] < din[i]) begin
                            flag_pipe1[j][i] <= 0;
                        end
                        else if(din[j] == din[i]) begin
                            if(j >= i) begin
                                flag_pipe1[j][i] <= 0;
                            end
                            else begin
                                flag_pipe1[j][i] <= 1;
                            end
                        end
                        else begin
                            flag_pipe1[j][i] <= 1;
                        end
                        valid_pipe1[j][i] <= vld_in;
                    end
                    else begin
                        flag_pipe1[j][i] <= 0;
                        valid_pipe1[j][i] <= 0;
                    end
                end
            end

            always @(posedge clk or negedge rst_n) begin
                if (!rst_n) begin
                    din_pipe1[j] <= 0;
                end
                else if (vld_in) begin
                    din_pipe1[j] <= din[j];
                end
                else begin
                    din_pipe1[j] <= 0;
                end
            end
        end
    endgenerate

    // score
    assign valid_sum_pipe2 = &{&valid_pipe2[0 ],&valid_pipe2[1 ],&valid_pipe2[2 ],&valid_pipe2[3 ],&valid_pipe2[4 ],&valid_pipe2[5 ],&valid_pipe2[6 ],&valid_pipe2[7 ],
                               &valid_pipe2[8 ],&valid_pipe2[9 ],&valid_pipe2[10],&valid_pipe2[11],&valid_pipe2[12],&valid_pipe2[13],&valid_pipe2[14],&valid_pipe2[15],
                               &valid_pipe2[16],&valid_pipe2[17],&valid_pipe2[18],&valid_pipe2[19],&valid_pipe2[20],&valid_pipe2[21],&valid_pipe2[22],&valid_pipe2[23],
                               &valid_pipe2[24],&valid_pipe2[25],&valid_pipe2[26],&valid_pipe2[27],&valid_pipe2[28],&valid_pipe2[29],&valid_pipe2[30],&valid_pipe2[31]} == 1'b1;
    
    generate
        for (j = 0; j<32; j=j+1) begin
            always @(posedge clk or negedge rst_n) begin
                if (!rst_n) begin
                    valid_pipe2[j] <= 0;
                    flag_sum_pipe2[j] <= 0;
                    din_pipe2[j] <= 0;
                end
                else if (valid_sum_pipe1) begin
                    valid_pipe2[j] <= valid_sum_pipe1;
                    flag_sum_pipe2[j] <= flag_pipe1[j][0 ] + flag_pipe1[j][1 ] + flag_pipe1[j][2 ] + flag_pipe1[j][3 ] + flag_pipe1[j][4 ] + flag_pipe1[j][5 ] + flag_pipe1[j][6 ] + flag_pipe1[j][7 ] + 
                                         flag_pipe1[j][8 ] + flag_pipe1[j][9 ] + flag_pipe1[j][10] + flag_pipe1[j][11] + flag_pipe1[j][12] + flag_pipe1[j][13] + flag_pipe1[j][14] + flag_pipe1[j][15] + 
                                         flag_pipe1[j][16] + flag_pipe1[j][17] + flag_pipe1[j][18] + flag_pipe1[j][19] + flag_pipe1[j][20] + flag_pipe1[j][21] + flag_pipe1[j][22] + flag_pipe1[j][23] + 
                                         flag_pipe1[j][24] + flag_pipe1[j][25] + flag_pipe1[j][26] + flag_pipe1[j][27] + flag_pipe1[j][28] + flag_pipe1[j][29] + flag_pipe1[j][30] + flag_pipe1[j][31] ;
                    din_pipe2[j] <= din_pipe1[j];
                end 
                else begin
                    valid_pipe2[j] <= 0;
                    flag_sum_pipe2[j] <= 0;
                    din_pipe2[j] <= 0;
                end
            end
        end
    endgenerate

    // pipeline output
    generate
        always @(posedge clk or negedge rst_n) begin
            if (!rst_n) begin
                vld_out <= 0;
                {din_pipe3[0 ],din_pipe3[1 ],din_pipe3[2 ],din_pipe3[3 ],din_pipe3[4 ],din_pipe3[5 ],din_pipe3[6 ],din_pipe3[7 ],
                 din_pipe3[8 ],din_pipe3[9 ],din_pipe3[10],din_pipe3[11],din_pipe3[12],din_pipe3[13],din_pipe3[14],din_pipe3[15],
                 din_pipe3[16],din_pipe3[17],din_pipe3[18],din_pipe3[19],din_pipe3[20],din_pipe3[21],din_pipe3[22],din_pipe3[23],
                 din_pipe3[24],din_pipe3[25],din_pipe3[26],din_pipe3[27],din_pipe3[28],din_pipe3[29],din_pipe3[30],din_pipe3[31]} <= 0;
            end
            else if (valid_sum_pipe2) begin
                vld_out <= 1;
                {din_pipe3[flag_sum_pipe2[0 ]],din_pipe3[flag_sum_pipe2[1 ]],din_pipe3[flag_sum_pipe2[2 ]],din_pipe3[flag_sum_pipe2[3 ]],din_pipe3[flag_sum_pipe2[4 ]],din_pipe3[flag_sum_pipe2[5 ]],din_pipe3[flag_sum_pipe2[6 ]],din_pipe3[flag_sum_pipe2[7 ]],
                 din_pipe3[flag_sum_pipe2[8 ]],din_pipe3[flag_sum_pipe2[9 ]],din_pipe3[flag_sum_pipe2[10]],din_pipe3[flag_sum_pipe2[11]],din_pipe3[flag_sum_pipe2[12]],din_pipe3[flag_sum_pipe2[13]],din_pipe3[flag_sum_pipe2[14]],din_pipe3[flag_sum_pipe2[15]],
                 din_pipe3[flag_sum_pipe2[16]],din_pipe3[flag_sum_pipe2[17]],din_pipe3[flag_sum_pipe2[18]],din_pipe3[flag_sum_pipe2[19]],din_pipe3[flag_sum_pipe2[20]],din_pipe3[flag_sum_pipe2[21]],din_pipe3[flag_sum_pipe2[22]],din_pipe3[flag_sum_pipe2[23]],
                 din_pipe3[flag_sum_pipe2[24]],din_pipe3[flag_sum_pipe2[25]],din_pipe3[flag_sum_pipe2[26]],din_pipe3[flag_sum_pipe2[27]],din_pipe3[flag_sum_pipe2[28]],din_pipe3[flag_sum_pipe2[29]],din_pipe3[flag_sum_pipe2[30]],din_pipe3[flag_sum_pipe2[31]]
                } <= {din_pipe2[0 ],din_pipe2[1 ],din_pipe2[2 ],din_pipe2[3 ],din_pipe2[4 ],din_pipe2[5 ],din_pipe2[6 ],din_pipe2[7 ],
                      din_pipe2[8 ],din_pipe2[9 ],din_pipe2[10],din_pipe2[11],din_pipe2[12],din_pipe2[13],din_pipe2[14],din_pipe2[15],
                      din_pipe2[16],din_pipe2[17],din_pipe2[18],din_pipe2[19],din_pipe2[20],din_pipe2[21],din_pipe2[22],din_pipe2[23],
                      din_pipe2[24],din_pipe2[25],din_pipe2[26],din_pipe2[27],din_pipe2[28],din_pipe2[29],din_pipe2[30],din_pipe2[31]};
            end
            else begin
                vld_out <= 0;
                {din_pipe3[0 ],din_pipe3[1 ],din_pipe3[2 ],din_pipe3[3 ],din_pipe3[4 ],din_pipe3[5 ],din_pipe3[6 ],din_pipe3[7 ],
                 din_pipe3[8 ],din_pipe3[9 ],din_pipe3[10],din_pipe3[11],din_pipe3[12],din_pipe3[13],din_pipe3[14],din_pipe3[15],
                 din_pipe3[16],din_pipe3[17],din_pipe3[18],din_pipe3[19],din_pipe3[20],din_pipe3[21],din_pipe3[22],din_pipe3[23],
                 din_pipe3[24],din_pipe3[25],din_pipe3[26],din_pipe3[27],din_pipe3[28],din_pipe3[29],din_pipe3[30],din_pipe3[31]} <= 0;
            end
        end
    endgenerate

    assign {dout_0 ,dout_1 ,dout_2 ,dout_3 ,dout_4 ,dout_5 ,dout_6 ,dout_7 ,
            dout_8 ,dout_9 ,dout_10,dout_11,dout_12,dout_13,dout_14,dout_15,
            dout_16,dout_17,dout_18,dout_19,dout_20,dout_21,dout_22,dout_23,
            dout_24,dout_25,dout_26,dout_27,dout_28,dout_29,dout_30,dout_31
        }= {din_pipe3[0 ],din_pipe3[1 ],din_pipe3[2 ],din_pipe3[3 ],din_pipe3[4 ],din_pipe3[5 ],din_pipe3[6 ],din_pipe3[7 ],
            din_pipe3[8 ],din_pipe3[9 ],din_pipe3[10],din_pipe3[11],din_pipe3[12],din_pipe3[13],din_pipe3[14],din_pipe3[15],
            din_pipe3[16],din_pipe3[17],din_pipe3[18],din_pipe3[19],din_pipe3[20],din_pipe3[21],din_pipe3[22],din_pipe3[23],
            din_pipe3[24],din_pipe3[25],din_pipe3[26],din_pipe3[27],din_pipe3[28],din_pipe3[29] ,din_pipe3[30],din_pipe3[31]};

endmodule
