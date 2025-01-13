`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/29 17:46:09
// Design Name: 
// Module Name: seq_detector
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


module seq_detector(
    input clk,
    input rst_n,
    input din_vld,
    input din,
    output reg result
    );
    // parameters
    localparam IDLE = 11'b00000000001;
    localparam S1_1 = 11'b00000000010;
    localparam S1_2 = 11'b00000000100;
    localparam S1_3 = 11'b00000001000;
    localparam S1_4 = 11'b00000010000;
    localparam S1_5 = 11'b00000100000;
    localparam S2_2 = 11'b00001000000;
    localparam S2_3 = 11'b00010000000;
    localparam S2_4 = 11'b00100000000;
    localparam S2_5 = 11'b01000000000;
    localparam TRAG = 11'b10000000000;

    // signal defination
    reg [10:0]nstate, cstate;

    // FSM1
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)begin
            cstate <= IDLE;
        end
        else if(din_vld)begin
            cstate <= nstate;
        end
        else begin
            cstate <= cstate;
        end
    end

    // FSM2
    always @(*) begin
        case(cstate)
            IDLE:begin
                if(din) begin
                    nstate = S1_1;
                end
                else begin
                    nstate = IDLE;
                end
            end
            S1_1:begin
                if(din) begin
                    nstate = S2_2;
                end
                else begin
                    nstate = S1_2;
                end
            end
            S1_2:begin
                if(din) begin
                    nstate = S1_3;
                end
                else begin
                    nstate = IDLE;
                end
            end
            S1_3:begin
                if(din) begin
                    nstate = S1_4;
                end
                else begin
                    nstate = S1_2;
                end
            end
            S1_4:begin
                if(din) begin
                    nstate = S1_5;
                end
                else begin
                    nstate = S1_2;
                end
            end
            S1_5:begin
                if(din) begin
                    nstate = S2_3;
                end
                else begin
                    nstate = TRAG;
                end
            end
            S2_2:begin
                if(din) begin
                    nstate = S2_3;
                end
                else begin
                    nstate = IDLE;
                end
            end
            S2_3:begin
                if(din)begin
                    nstate = S2_3;
                end
                else begin
                    nstate = S2_4;
                end
            end
            S2_4:begin
                if(din) begin
                    nstate = S1_3;
                end
                else begin
                    nstate = S2_5;
                end
            end
            S2_5:begin
                if(din) begin
                    nstate = IDLE;
                end
                else begin
                    nstate = TRAG;
                end
            end
            TRAG:begin
                if(din) begin
                    nstate = S1_3;
                end
                else begin
                    nstate = S2_5;
                end
            end
            default: nstate = IDLE;
        endcase
    end

    // FSM3
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)begin
            result <= 1'b0;
        end
        else if(nstate == TRAG)begin
            result <= 1'b1;
        end
        else begin
            result <= 1'b0;
        end
    end

endmodule
