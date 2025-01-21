`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/25 14:33:01
// Design Name: 
// Module Name: mat_scan
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


module mat_scan(
    input clk,
    input rst_n,
    input vld_in,
    input [9:0] din,
    output vld_out,
    output [9:0] dout
    );
    // FSM state parameter
    localparam W0 = 3'b001;
    localparam W1 = 3'b010;
    localparam W2 = 3'b100;

    // signal define
    reg [2:0] cstate;
    reg [2:0] nstate;
    reg [9:0] data_reg [31:0];
    wire [4:0] write_addr, read_addr;
    reg [4:0] cnt_w;
    reg [5:0] cnt_r;
    reg read_ena;
    wire [4:0] read_map [63:0];

    // FSM1
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)
            cstate <= W0;
        else
            cstate <= nstate;
    end

    // FSM2
    always @(*) begin
        case (cstate)
            W0: begin
                if(vld_in)
                    nstate = W1;
                else
                    nstate = W0;
            end
            W1: begin
                if(&cnt_w)
                    nstate = W2;
                else
                    nstate = W1;
            end
            W2: begin
                if(&cnt_w)
                    nstate = W0;
                else
                    nstate = W2;
            end
            default: nstate = W0;
        endcase
    end

    // FSM3
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)begin
            cnt_w <= 5'd0;
        end
        else begin
            case (nstate)
                W1: begin
                    cnt_w <= cnt_w + 5'd1;
                end
                W2: begin
                    cnt_w <= cnt_w + 5'd1;
                end
                default: begin
                    cnt_w <= 5'd0;
                end
            endcase
        end
    end
    assign write_addr = (cstate==W1)?cnt_w:((cstate==W2)?read_map[cnt_w]:5'd0);

    // map 1-63 address to zigzag address
    assign {read_map[0 ],read_map[1 ],read_map[2 ],read_map[3 ],read_map[4 ],read_map[5 ],read_map[6 ],read_map[7 ],
            read_map[8 ],read_map[9 ],read_map[10],read_map[11],read_map[12],read_map[13],read_map[14],read_map[15],
            read_map[16],read_map[17],read_map[18],read_map[19],read_map[20],read_map[21],read_map[22],read_map[23],
            read_map[24],read_map[25],read_map[26],read_map[27],read_map[28],read_map[29],read_map[30],read_map[31],
            read_map[32],read_map[33],read_map[34],read_map[35],read_map[36],read_map[37],read_map[38],read_map[39],
            read_map[40],read_map[41],read_map[42],read_map[43],read_map[44],read_map[45],read_map[46],read_map[47],
            read_map[48],read_map[49],read_map[50],read_map[51],read_map[52],read_map[53],read_map[54],read_map[55],
            read_map[56],read_map[57],read_map[58],read_map[59],read_map[60],read_map[61],read_map[62],read_map[63]
        }= {5'd0 ,5'd1 ,5'd8 ,5'd16,5'd9 ,5'd2 ,5'd3 ,5'd10,
            5'd17,5'd24,5'd0 ,5'd25,5'd18,5'd11,5'd4 ,5'd5 ,
            5'd12,5'd19,5'd26,5'd1 ,5'd17,5'd12,5'd24,5'd8,
            5'd27,5'd20,5'd13,5'd6 ,5'd7 ,5'd14,5'd21,5'd28,
            5'd16,5'd0 ,5'd19,5'd27,5'd20,5'd26,5'd25,5'd9,
            5'd29,5'd22,5'd15,5'd23,5'd30,5'd2 ,5'd18,5'd1 ,
            5'd13,5'd6 ,5'd17,5'd11,5'd3 ,5'd31,5'd10,5'd4 ,
            5'd12,5'd7 ,5'd14,5'd24,5'd5 ,5'd8 ,5'd21,5'd28};

    // writer data into data_reg
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)begin
            {data_reg[0 ],data_reg[1 ],data_reg[2 ],data_reg[3 ],data_reg[4 ],data_reg[5 ],data_reg[6 ],data_reg[7 ],
             data_reg[8 ],data_reg[9 ],data_reg[10],data_reg[11],data_reg[12],data_reg[13],data_reg[14],data_reg[15],
             data_reg[16],data_reg[17],data_reg[18],data_reg[19],data_reg[20],data_reg[21],data_reg[22],data_reg[23],
             data_reg[24],data_reg[25],data_reg[26],data_reg[27],data_reg[28],data_reg[29],data_reg[30],data_reg[31]} <= 320'd0;
        end
        else if(vld_in)begin
            data_reg[write_addr] <= din;
        end
        else begin
            {data_reg[0 ],data_reg[1 ],data_reg[2 ],data_reg[3 ],data_reg[4 ],data_reg[5 ],data_reg[6 ],data_reg[7 ],
             data_reg[8 ],data_reg[9 ],data_reg[10],data_reg[11],data_reg[12],data_reg[13],data_reg[14],data_reg[15],
             data_reg[16],data_reg[17],data_reg[18],data_reg[19],data_reg[20],data_reg[21],data_reg[22],data_reg[23],
             data_reg[24],data_reg[25],data_reg[26],data_reg[27],data_reg[28],data_reg[29],data_reg[30],data_reg[31]} <= 
             {data_reg[0 ],data_reg[1 ],data_reg[2 ],data_reg[3 ],data_reg[4 ],data_reg[5 ],data_reg[6 ],data_reg[7 ],
             data_reg[8 ],data_reg[9 ],data_reg[10],data_reg[11],data_reg[12],data_reg[13],data_reg[14],data_reg[15],
             data_reg[16],data_reg[17],data_reg[18],data_reg[19],data_reg[20],data_reg[21],data_reg[22],data_reg[23],
             data_reg[24],data_reg[25],data_reg[26],data_reg[27],data_reg[28],data_reg[29],data_reg[30],data_reg[31]};
        end
    end

    // read out data from data_reg
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)
            read_ena <= 1'b0;
        else if((cnt_w==5'd27)&&(nstate==W1))
            read_ena <= 1'b1;
        else if(cnt_r == 6'd63)
            read_ena <= 1'b0;
        else
            read_ena <= read_ena;
    end

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            cnt_r <= 6'd0;
        end
        else if(read_ena) begin
            cnt_r <= cnt_r + 6'd1;
        end
        else if(cnt_r == 6'd64) begin
            cnt_r <= 6'd0;
        end
        else begin
            cnt_r <= 6'd0;
        end
    end
    assign read_addr = read_ena?read_map[cnt_r]:5'd0;
    assign vld_out = read_ena;
    assign dout = data_reg[read_addr];

endmodule
