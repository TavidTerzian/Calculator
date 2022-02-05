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
    input logic [2:0] opcode,
    input logic [9:0] btn,
    output logic num,
    output logic op,
    output logic [3:0] state,
    output logic [3:0] pressedNum,
    output logic [31:0] displayedNum,
    output logic [31:0] val1,
    output logic [31:0] val2,
    output logic [2:0] pressedOp,
    output logic [2:0] prevOp
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
                        
    //reg [3:0] state = s0;
    //reg [31:0] val1;
    //reg [31:0] val2;
    //reg [3:0] pressedNum;
    //reg [2:0] pressedOp;
    //reg [2:0] prevOp;
    //logic op;
    //logic num; 
    
    initial begin
        val1 = 0;
        val2 =0;
        displayedNum =0;
        state = s0;
    end
    
    always @ (posedge clk) begin
        if (btn != 0) num = 1;
        else num = 0;
    end   
    
    always @ (posedge clk) begin
        if (opcode != 0) op = 1;
        else op = 0;
    end
    
    always @ (posedge clk) begin
        if(state == 1)begin
            val1=0;
            val2=0;
            pressedNum = 0;
            pressedOp = 0;
            prevOp = 0;
            displayedNum =0 ;
        end
        else if(state == 3) begin 
            if (num) pressedNum = getNum(btn); 
        end
        else if(state == 4)begin
            val1 = pressedNum + val1*10;
            pressedNum = 0;
            displayedNum = val1;
        end
        else if(state == 5)begin
            prevOp = pressedOp;
            pressedOp = opcode;
        end
        else if(state == 7) begin
            case(prevOp)
                0: val2 = val1;
                1: val2 = val2;
                2: val2 = val1+val2;
                3: val2 = val2-val1;
                4: val2 = val2/val1;
                5: val2 = val1*val2;
            endcase
            //val2= eval(val1, val2, prevOp);
            val1 = 0;
            displayedNum = val2;
        end
        else if(state == 8)begin
            val1=val1*-1;
            displayedNum = val1;
        end
    end
  
    always @ (posedge clk) begin        
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
                s5: state = s6;
                s6: if(!op)state = s7; else state = s6;
                s7: state = s2;
                s8: state = s2;
                default: state = s0;
            endcase
        end
      end
      

    
    function int eval(logic val1, logic val2, logic [2:0] prevOp);
        $display("function ", val1);
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
    
    function int getNum(input logic [9:0] btn);
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
