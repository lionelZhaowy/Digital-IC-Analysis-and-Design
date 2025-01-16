`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/26 13:24:22
// Design Name: 
// Module Name: Timer
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


module Timer(
    input   clk,
    input   rst_n,
    input   en,
    input   Clear,
    output  reg [3:0] hr_h,
    output  reg [3:0] hr_l,
    output  reg [3:0] min_h,
    output  reg [3:0] min_l,
    output  reg [3:0] sec_h,
    output  reg [3:0] sec_l
    );
    // 内部信号
    wire sec_60_flag, min_60_flag, hur_12_flag;//计数满标志位
    wire sec_l_flag, min_l_flag, hur_l_flag;

    // 记满信号
    assign sec_60_flag = ({sec_h, sec_l}==8'h59)?1'b1:1'b0;
    assign min_60_flag = ({min_h, min_l}==8'h59)?1'b1:1'b0;
    assign hur_12_flag = ({hr_h , hr_l }==8'h11)?1'b1:1'b0;
    // assign sec_60_flag = (sec_h==4'h5) && (sec_l==4'h9);
    // assign min_60_flag = (min_h==4'h5) && (min_l==4'h9);
    // assign hur_12_flag = (hr_h ==4'h1) && (hr_l ==4'h1);
    assign sec_l_flag = (sec_l==4'h9)?1'b1:1'b0;
    assign min_l_flag = (min_l==4'h9)?1'b1:1'b0;
    assign hur_l_flag = (hr_l ==4'h9)?1'b1:1'b0;

    // BCD码计数器控制
    // 秒
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n || Clear)begin
            sec_l <= 4'd0;
        end
        else if(en) begin
            if(sec_l_flag)begin
                sec_l <= 4'd0;
            end
            else begin
                sec_l <= sec_l + 4'd1;
            end
        end
        else begin
            sec_l <= sec_l;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n || Clear)begin
            sec_h <= 4'd0;
        end
        else if(en)begin
            if(sec_60_flag)begin
                sec_h <= 4'd0;
            end
            else if(sec_l_flag)begin
                sec_h <= sec_h + 4'd1;
            end
            else begin
                sec_h <= sec_h;
            end
        end
        else begin
            sec_h <= sec_h;
        end
    end

    // 分
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n || Clear)begin
            min_l <= 4'd0;
        end
        else if(en) begin
            if(min_l_flag&&sec_60_flag)begin
                min_l <= 4'd0;
            end
            else if(sec_60_flag)begin
                min_l <= min_l + 4'd1;
            end
            else begin
                min_l <= min_l;
            end
        end
        else begin
            min_l <= min_l;
        end
    end
    
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n || Clear)begin
            min_h <= 4'd0;
        end
        else if(en)begin
            if(min_60_flag&&sec_60_flag)begin
                min_h <= 4'd0;
            end
            else if(min_l_flag&&sec_60_flag)begin
                min_h <= min_h + 4'd1;
            end
            else begin
                min_h <= min_h;
            end
        end
        else begin
            min_h <= min_h;
        end
    end

    // 时
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n || Clear)begin
            hr_l <= 4'd0;
        end
        else if(en)begin
            if((hur_12_flag&&min_60_flag&&sec_60_flag) || (hur_l_flag&&min_60_flag&&sec_60_flag))begin
                hr_l <= 4'd0;
            end
            else if(min_60_flag&&sec_60_flag)begin
                hr_l <= hr_l + 4'd1;
            end
            else begin
                hr_l <= hr_l;
            end
        end
        else begin
            hr_l <= hr_l;
        end
    end
    
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n || Clear)begin
            hr_h <= 4'd0;
        end
        else if(en)begin
            if(hur_12_flag&&min_60_flag&&sec_60_flag)begin
                hr_h <= 4'd0;
            end
            else if(hur_l_flag&&min_60_flag&&sec_60_flag)begin
                hr_h <= hr_h + 4'd1;
            end
            else begin
                hr_h <= hr_h;
            end
        end
        else begin
            hr_h <= hr_h;
        end
    end

endmodule
