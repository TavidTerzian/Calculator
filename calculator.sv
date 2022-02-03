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
    output logic num,
    output logic op,
    output logic [31:0] displayedNum,
    output logic [31:0] val1,
    output logic [31:0] val2
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
                        
    reg [3:0] state = s0;
    //reg [31:0] val1;
    //reg [31:0] val2;
    reg [3:0] pressedNum;
    reg [2:0] pressedOp;
    reg [2:0] prevOp;
    //logic op;
    //logic num;  
    
    always_comb begin
        if (btn != 0) num = 1;
        else num = 0;
    end   
    
    always_comb begin
        if (opcode != 0) op = 1;
        else op = 0;
    end
    
    always_comb begin
        case (state)
            s1:begin
                val1=0;
                val2=0;
                pressedNum = 0;
                pressedOp = 0;
                prevOp = 0;
            end
            s3: pressedNum = getNum(btn);
            s4:begin
               val1 = pressedNum + val1*10;
               displayedNum = val1;
            end
            s5: begin
                prevOp = pressedOp;
                pressedOp = opcode;
            end
            s6: val2 = eval(val1, val2, prevOp);
            s7: begin
                val1=val1*-1;
                displayedNum = val1;
            end
        endcase
    end
  
    always @ (posedge clk)begin        
        if(rst) state = s0;
        else 
        begin
            case(state) 
                s0: if(pwr) state = s1;
                    else state = s0;
                s1: state = s2;
                s2:begin
                    if(clr) state = s1;
                    else if(num)state = s3;
                    else if(op) state = s5;
                    else if(neg) state = s7;
                    else state = s2;
                end
                s3: begin
                    if(!num) state = s4;
                    else state = s3;
                end
                s4: state = s2;
                s5:begin
                    if(!op) state = s6;
                    else state = s5;
                end
                s6: state = s2;
                s7: state = s2;
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
            default: return 0;
        endcase
    endfunction
    
    function int getNum(input btn);
        case(btn)
            10'b0000000001: return 0;
            10'b0000000010: return 1;
            10'b0000000100: return 2;
            10'b0000001000: return 3;
            10'b0000010000: return 4;
            10'b0000100000: return 5;
            10'b0001000000: return 6;
            10'b0010000000: return 7;
            10'b0100000000: return 8;
            10'b1000000000: return 9;
            default: return 0;
        endcase
    endfunction
    
endmodule
