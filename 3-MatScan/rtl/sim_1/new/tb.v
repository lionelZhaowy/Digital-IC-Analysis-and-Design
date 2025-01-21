`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/25 16:55:06
// Design Name: 
// Module Name: tb
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



module mat_scan_tb;

    // Parameters

    //Ports
    reg clk;
    reg rst_n;
    reg vld_in;
    reg [9:0] din;
    wire vld_out;
    wire [9:0] dout;
    wire [9:0] dout_sim;
    wire [9:0] input_data [63:0];
    wire [9:0] output_data [63:0];
    wire res;

    assign {input_data[0 ],input_data[1 ],input_data[2 ],input_data[3 ],input_data[4 ],input_data[5 ],input_data[6 ],input_data[7 ],
            input_data[8 ],input_data[9 ],input_data[10],input_data[11],input_data[12],input_data[13],input_data[14],input_data[15],
            input_data[16],input_data[17],input_data[18],input_data[19],input_data[20],input_data[21],input_data[22],input_data[23],
            input_data[24],input_data[25],input_data[26],input_data[27],input_data[28],input_data[29],input_data[30],input_data[31],
            input_data[32],input_data[33],input_data[34],input_data[35],input_data[36],input_data[37],input_data[38],input_data[39],
            input_data[40],input_data[41],input_data[42],input_data[43],input_data[44],input_data[45],input_data[46],input_data[47],
            input_data[48],input_data[49],input_data[50],input_data[51],input_data[52],input_data[53],input_data[54],input_data[55],
            input_data[56],input_data[57],input_data[58],input_data[59],input_data[60],input_data[61],input_data[62],input_data[63]
        }= {10'd0 ,10'd1 ,10'd2 ,10'd3 ,10'd4 ,10'd5 ,10'd6 ,10'd7 ,
            10'd8 ,10'd9 ,10'd10,10'd11,10'd12,10'd13,10'd14,10'd15,
            10'd16,10'd17,10'd18,10'd19,10'd20,10'd21,10'd22,10'd23,
            10'd24,10'd25,10'd26,10'd27,10'd28,10'd29,10'd30,10'd31,
            10'd32,10'd33,10'd34,10'd35,10'd36,10'd37,10'd38,10'd39,
            10'd40,10'd41,10'd42,10'd43,10'd44,10'd45,10'd46,10'd47,
            10'd48,10'd49,10'd50,10'd51,10'd52,10'd53,10'd54,10'd55,
            10'd56,10'd57,10'd58,10'd59,10'd60,10'd61,10'd62,10'd63};

        assign {output_data[0 ],output_data[1 ],output_data[2 ],output_data[3 ],output_data[4 ],output_data[5 ],output_data[6 ],output_data[7 ],
                output_data[8 ],output_data[9 ],output_data[10],output_data[11],output_data[12],output_data[13],output_data[14],output_data[15],
                output_data[16],output_data[17],output_data[18],output_data[19],output_data[20],output_data[21],output_data[22],output_data[23],
                output_data[24],output_data[25],output_data[26],output_data[27],output_data[28],output_data[29],output_data[30],output_data[31],
                output_data[32],output_data[33],output_data[34],output_data[35],output_data[36],output_data[37],output_data[38],output_data[39],
                output_data[40],output_data[41],output_data[42],output_data[43],output_data[44],output_data[45],output_data[46],output_data[47],
                output_data[48],output_data[49],output_data[50],output_data[51],output_data[52],output_data[53],output_data[54],output_data[55],
                output_data[56],output_data[57],output_data[58],output_data[59],output_data[60],output_data[61],output_data[62],output_data[63]
        }= {10'd0 ,10'd1 ,10'd8 ,10'd16,10'd9 ,10'd2 ,10'd3 ,10'd10,
            10'd17,10'd24,10'd32,10'd25,10'd18,10'd11,10'd4 ,10'd5 ,
            10'd12,10'd19,10'd26,10'd33,10'd40,10'd48,10'd41,10'd34,
            10'd27,10'd20,10'd13,10'd6 ,10'd7 ,10'd14,10'd21,10'd28,
            10'd35,10'd42,10'd49,10'd56,10'd57,10'd50,10'd43,10'd36,
            10'd29,10'd22,10'd15,10'd23,10'd30,10'd37,10'd44,10'd51,
            10'd58,10'd59,10'd52,10'd45,10'd38,10'd31,10'd39,10'd46,
            10'd53,10'd60,10'd61,10'd54,10'd47,10'd55,10'd62,10'd63};

    integer i,j;

    mat_scan  mat_scan_inst (
        .clk(clk),
        .rst_n(rst_n),
        .vld_in(vld_in),
        .din(din),
        .vld_out(vld_out),
        .dout(dout)
    );

    initial begin
        i = 0;
        clk = 0;
        rst_n =0;
        vld_in = 0;
        din = 0;
        #100;
        rst_n =1;
        @(posedge clk)begin
            din = input_data[i];
            vld_in =1;
            for (i=1; i<64; i=i+1)begin
                @(posedge clk)begin
                    din = input_data[i];
                end
            end
            @(posedge clk)vld_in =0;
        end

        
    end

    initial begin
        @(posedge vld_out) begin
            for (j=0; j<64; j=j+1)begin
                @(posedge clk)begin
                end
            end
        end
        #100 $stop;
    end

    assign res = (dout_sim==dout)?1:0;
    assign dout_sim = output_data[j];
    always #5  clk <= ! clk ;

endmodule
