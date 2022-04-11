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
    //input neg,
    input clr,
    //output reg [3:0] state,
    //output reg [3:0] nextstate,
    // output reg [9:0] displayedNum,
    //output reg [9:0] val1,
    //output reg [9:0] val2,
    //output reg [4:0] pressedOp,
    //output reg [4:0] prevOp,
    //output op_pressed,
    //output btn_pressed,
    output [3:0] an,
    output [6:0] seg
);

    logic[9:0] btn_output;
    localparam [4:0] s0 = 0, s1 = 1, s2 = 2, s3 = 3, s4 = 4, 
                    s5 = 5, s6 = 6, s7 = 7, s8 = 8, s9 = 9;
    
    logic [3:0] state = 0;
    logic [3:0] nextstate = 0;
    logic [9:0] val1 = 0;
    logic [9:0] val2 = 0;
    logic [9:0] displayedNum = 0;
    logic [4:0] pressedOp = 0;
    logic [4:0] prevOp = 0;
    logic negPressed;
    wire op_pressed;
    wire btn_pressed;
    
    
   
    bin_num_display disp(.btn(displayedNum), .clk(clk), .an(an), .seg(seg));
    // filters for individual switches
    btn_filter b0 (.btn(btn[0]), .clk(clk), .sig(btn_output[0]));
    btn_filter b1 (.btn(btn[1]), .clk(clk), .sig(btn_output[1]));
    btn_filter b2 (.btn(btn[2]), .clk(clk), .sig(btn_output[2]));
    btn_filter b3 (.btn(btn[3]), .clk(clk), .sig(btn_output[3]));
    btn_filter b4 (.btn(btn[4]), .clk(clk), .sig(btn_output[4]));
    btn_filter b5 (.btn(btn[5]), .clk(clk), .sig(btn_output[5]));
    btn_filter b6 (.btn(btn[6]), .clk(clk), .sig(btn_output[6]));
    btn_filter b7 (.btn(btn[7]), .clk(clk), .sig(btn_output[7]));
    btn_filter b8 (.btn(btn[8]), .clk(clk), .sig(btn_output[8]));
    btn_filter b9 (.btn(btn[9]), .clk(clk), .sig(btn_output[9]));
    
    //operation filters
    btn_filter o0 (.btn(opcode[0]), .clk(clk), .sig(op_filter_output_0));
    btn_filter o1 (.btn(opcode[1]), .clk(clk), .sig(op_filter_output_1));
    btn_filter o2 (.btn(opcode[2]), .clk(clk), .sig(op_filter_output_2));
    btn_filter o3 (.btn(opcode[3]), .clk(clk), .sig(op_filter_output_3));
    btn_filter o4 (.btn(opcode[4]), .clk(clk), .sig(op_filter_output_4));
    //btn_filter n (.btn(neg), .clk(clk), .sig(neg_filter_output));
    btn_filter c (.btn(clr), .clk(clk), .sig(clr_filter_output));
 
    assign btn_pressed = |btn_output | (val1!=btn);
                        
    assign op_pressed = (op_filter_output_0 | op_filter_output_1 | op_filter_output_2 | 
                        op_filter_output_3 | op_filter_output_4);
    
    always @ (posedge clk)begin
        if(clr_filter_output) state <= 0;
        else state <= nextstate;
    end
    
    always @ (posedge clk)begin
        case(state) 
            s0:begin
                if(btn_pressed) nextstate<=s1;
                else if (op_pressed) nextstate<=s2;
                //else if (neg_filter_output) nextstate=s3;
                else if(clr_filter_output) nextstate<=s4;
                else nextstate<=s0;
            end
            s1:nextstate<=s0;
            s2:nextstate<=s0;
            //s3:nextstate<=s0;
            s4:nextstate<=s0;
            default: nextstate<=s0;
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
                pressedOp = opcode;
                val2 = eval(val1, val2, prevOp);
                displayedNum = val2;
            end
            s4:begin
                val1 <= btn;
                displayedNum <= btn;
                val2<=0;
                prevOp<=0;
                pressedOp<=0;
                //negpressed<=0
            end
        endcase
    end
    
    function int eval(logic [9:0] val1, logic [9:0] val2, logic [4:0] prevOp);
        case(prevOp)
            5'b00001: return val2;                  
            5'b00010: return val1+val2;
            5'b00100: return val2-val1;
            5'b01000: return val2/val1;
            5'b10000: return val1*val2;
            default: return val1;
        endcase
    endfunction
        
endmodule
