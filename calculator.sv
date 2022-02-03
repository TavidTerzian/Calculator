`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/23/2022 12:21:06 AM
// Design Name: 
// Module Name: calculator
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


module calculator(
    input clk,
    input rst,
    input pwr,
    input neg,
    input clr,
    input [2:0] opcode,
    input [9:0] btn,
    output reg [31:0] displayedNum
    );
    
    localparam [4:0] s0 = 0,
                    s1 = 1,
                    s2 = 2,
                    s3 = 3,
                    s4 = 4,
                    s5 = 5,
                    s6 = 6,
                    s7 = 7,
                    s8 = 8;
                        
    reg [4:0] state = s0;
    reg [31:0] val1;
    reg [31:0] val2;
    reg [3:0] pressedNum;
    reg [2:0] pressedOp;
    reg [2:0] prevOp;
    logic op;
    logic num;
    
    
    always @ (posedge clk) begin
        if (opcode == 0) op = 0;
        else op = 1;
    end
    
    always @ (posedge clk) begin
        if(btn == 0) num = 0;
        else num = 1;
    end
      
    always @ (posedge clk)begin
        if(rst) state = s0;
        else 
        begin
            case(state) 
                s0: if(pwr) state = s1;
                s1: begin
                    val1=0;
                    val2=0;
                    pressedNum = 0;
                    pressedOp = 0;
                    prevOp = 0;
                    state = s2;
                end
                s2:begin
                    if(clr) state = s1;
                    else if(num)state = s3;
                    else if(op) state = s5;
                    else if(neg) state = s7;
                    else state = s2;
                end
                s3: begin
                    pressedNum = getNum(btn);
                    if(!num) state = s4;
                    else state = s3;
                end
                s4:begin 
                    val1 = pressedNum + val1*10;
                    displayedNum = val1;
                    state = s2;
                end
                s5:begin
                    prevOp = pressedOp;
                    pressedOp = opcode;
                    if(!op) state = s6;
                    else state = s5;
                end
                s6:begin
                    val2 = eval(val1, val2, prevOp);
                    state = s2;
                end
                s7:begin
                    val1=val1*-1;
                    displayedNum = val1;
                    state = s2;
                end
                default: state = s0;
            endcase
        end
      end
      

    
    function int eval(reg val1, reg val2, opcode);
        case(opcode)
            3'b000: return val2;
            3'b001: return val2;
            3'b010: return val1+val2;
            3'b011: return val1-val2;
            3'b100: return val2/val1;
            3'b101: return val1*val2;
        endcase
    endfunction
    
    function int getNum(input btn);
        case(btn)
            10'b0000000001: return 0;
            10'b0000000010: return 1;
            10'b000000100: return 2;
            10'b0000001000: return 3;
            10'b0000010000: return 4;
            10'b0000100000: return 5;
            10'b0001000000: return 6;
            10'b0010000000: return 7;
            10'b0100000000: return 8;
            10'b1000000000: return 9;
        endcase
    endfunction
    
endmodule
