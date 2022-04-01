`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/31/2022 06:48:12 PM
// Design Name: 
// Module Name: calc
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


module calc(
    input clk,
    input [4:0] opcode,
    input [9:0] btn,
    input neg,
    input clr,
    output [3:0] an,
    output [7:0] seg
);

    localparam [4:0] s0 = 0, s1 = 1, s2 = 2, s3 = 3, s4 = 4, 
                    s5 = 5, s6 = 6, s7 = 7, s8 = 8, s9 = 9;
    
    logic [3:0] state = 0;
    logic [9:0] val1 = 0;
    logic [9:0] val2 = 0;
    logic [9:0] displayedNum = 0;
    logic [3:0] desiredDigit;
    logic [2:0] pressedOp = 0;
    logic [2:0] prevOp = 0;
    logic [26:0] counter_100M;
    logic [13:0] counter_100T;
    logic [3:0] counter_4;
    logic counter_en_2;
    logic negPressed;
    logic op;
    logic num; 
    logic num_filter_output;
    logic op_filter_output;
    logic neg_filter_output;
    
    btn_filter b (.btn(num), .clk(clk), .sig(num_filter_ouput));
    btn_filter o (.btn(op), .clk(clk), .sig(op_filter_output));
    btn_filter n (.btn(neg), .clk(clk), .sig(neg_filter_output));
    
    always @ (clr)begin
        val1 <= 0;
        val2 <= 0;
        negPressed <= 0;
        displayedNum <= 0;
        state <= s0;
    end
    
    always @ (posedge clk)begin
        if(btn != val1) num = 1;
        else num = 0;
    end
    
    always @ (posedge clk)begin
        case(state) 
            s0:begin
                if(num_filter_output) state<=s1;
                else if (op_filter_output) state<=s2;
                else if (neg_filter_output) state<=s3;
            end
            s1:state<=s0;
            s2:state<=s0;
            s3:state<=s0;
        endcase
    end
    
    always @ (posedge clk) begin
        case(state)
            s1:begin
                val1 <= btn;
                displayedNum <= btn;
            end
            s2:begin
                prevOp = pressedOp;
                pressedOp <= opcode;
            end
        endcase
    end
    
    function int eval(logic [31:0] val1, logic [31:0] val2, logic [2:0] prevOp);
        case(prevOp)
            3'b000: return val1;
            3'b001: return val2;
            3'b010: return val1+val2;
            3'b011: return val1-val2;
            3'b100: return val2/val1;
            3'b101: return val1*val2;
            default: return 0;
        endcase
    endfunction
        
endmodule
