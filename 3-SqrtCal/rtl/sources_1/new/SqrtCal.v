`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/24 15:19:04
// Design Name: 
// Module Name: SqrtCal
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


module SqrtCal(
    input clk,
    input rst_n,
    input vld_in,
    input [31:0] x,
    output reg vld_out,
    output reg [15:0] y
    );
    // parameter define
    localparam IDLE = 3'b001;
    localparam CALC = 3'b010;
    localparam DONE = 3'b100;

    // signal define
    reg [31:0] x_r;
    reg [2:0] cstate, nstate;
    reg calc_ena;
    wire calc_finished;//end calculate
    wire [15:0] div_tmp;//temp divide data
    wire [16:0] addey_tmp;//output from adder
    wire [15:0] y_tmp;//temp y

    // FSM1
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)begin
            cstate <= IDLE;
        end
        else begin
            cstate <= nstate;
        end
    end

    // FSM2
    always @(*) begin
        case(cstate)
            IDLE: begin
                if(vld_in) nstate = CALC;
                else nstate = IDLE;
            end
            CALC: begin
                if(calc_finished) nstate = DONE;
                else nstate = CALC;
            end
            DONE: begin
                nstate = IDLE;
            end
            default: nstate = IDLE;
        endcase
    end

    // FSM3
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)begin
            vld_out <= 1'b0;
            calc_ena <= 1'b0;
        end
        else begin
            case (nstate)
                IDLE: begin
                    vld_out <= 1'b0;
                    calc_ena <= 1'b0;
                end
                CALC: begin
                    vld_out <= 1'b0;
                    calc_ena <= 1'b1;
                end
                DONE: begin
                    vld_out <= 1'b1;
                    calc_ena <= 1'b0;
                end
                default: begin
                    vld_out <= 1'b0;
                    calc_ena <= 1'b0;
                end
            endcase
        end
    end

    // get input data x
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)begin
            x_r <= 32'd0;
        end
        else if(vld_in)begin
            x_r <= x;
        end
        else begin
            x_r <= x_r;
        end
    end

    assign calc_finished = (y_tmp==y) || ((y_tmp+1'b1)==y);
    assign div_tmp = x_r/y;
    assign addey_tmp = {1'b0, div_tmp} + {1'b0, y};
    assign y_tmp = addey_tmp[16:1];

    always@(posedge clk,negedge rst_n) begin
        if(!rst_n) begin
            y <= 8'd1;
        end
        else if(calc_ena) begin
            y <= y_tmp;
        end
    end

endmodule
