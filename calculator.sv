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
    output logic [9:0] an,
    output [6:0] seg,
    output logic [31:0] displayedNum
    );
    
    localparam [4:0] s0 = 0,
                    s1 = 1,
                    s2 = 2,
                    s3 = 3,
                    s4 = 4,
                    s5 = 5,
                    s6 = 6,
                    s7 = 7,
                    s8 = 8,
                    s9 = 9;
                        
    logic [3:0] state = s0;
    logic [31:0] val1;
    logic [31:0] val2;
    logic [3:0] pressedNum;
    logic [3:0] desiredDigit;
    logic [2:0] pressedOp;
    logic [2:0] prevOp;
    logic [26:0] counter_100M;
    logic [13:0] counter_100T;
    logic [9:0] counter_10;
    logic counter_en_2;
    logic negPressed;
    logic op;
    logic num; 
    
    initial begin
        val1 = 0;
        val2 = 0;
        displayedNum = 0;
        state = s0;
        negPressed = 0;
    end
    
    calc_display disp1(.digit(desiredDigit), .neg(negPressed), .seven_seg(seg));
    
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
            displayedNum = 0;
            negPressed = 0;
        end
        else if(state == 3) begin 
            if (num) pressedNum = getNum(btn); 
        end
        else if(state == 4)begin
            if(negPressed)begin
                if(val1 == 0)begin
                    val1 = pressedNum + val1*10;   
                    val1 = -val1;
                end
                else begin
                    val1 = -val1;
                    val1 = pressedNum + val1*10;   
                    val1 = -val1;
                end        
            end
            else val1 = pressedNum + val1*10;
            
            pressedNum = 0;
            displayedNum = val1;
        end
        else if(state == 5)begin
            prevOp = pressedOp;
            pressedOp = opcode;
        end
        else if(state == 7) begin
            val2= eval(val1, val2, prevOp);
            val1 = 0;
            displayedNum = val2;
        end
        else if(state == 9)begin
            if(val1 == 0) negPressed = 1;
            else if (val1[31] == 1) begin
                val1 = -val1; 
                negPressed = 0;
                displayedNum = val1;
            end
            else val1 = -val1; negPressed = 1; displayedNum = val1; 
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
                    else if(neg) state = s8;
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
                s8: if(!neg)state = s9; else state = s8;
                s9: state = s2;
                default: state = s0;
            endcase
        end
      end
      
      always @ (posedge clk)begin
          if(counter_100T == 100_000) 
              counter_100T <= 0;
          else
              counter_100T <= counter_100T + 1'b1;
      end
          
      always @ (posedge clk)begin
          if (counter_en_2)
              if (counter_10 == 9)
                  counter_10 <= 0;
          else
              counter_10 <= counter_10 + 1'b1;
      end
                  
                  
      //create a signal that is active every 100M clocks
      assign counter_en_2 = (counter_100T ==0);
      
  always @ (posedge counter_en_2)
        case (counter_10)
          0: an = 10'b1111111110;
          1: an = 10'b1111111101;
          2: an = 10'b1111111011;
          3: an = 10'b1111110111;
          4: an = 10'b1111101111;
          5: an = 10'b1111011111;
          6: an = 10'b1110111111;
          7: an = 10'b1101111111;
          8: an = 10'b1011111111;
          9: an = 10'b0111111111;
        endcase
        
    always @ (posedge counter_en_2)
        case (counter_10)
            0: desiredDigit = displayedNum%10;
            1: desiredDigit = (displayedNum/10)%10;
            2: desiredDigit = (displayedNum/100)%10;
            3: desiredDigit = (displayedNum/1000)%10;
            4: desiredDigit = (displayedNum/10000)%10;
            5: desiredDigit = (displayedNum/100000)%10;
            6: desiredDigit = (displayedNum/1000000)%10;
            7: desiredDigit = (displayedNum/10000000)%10;
            8: desiredDigit = (displayedNum/100000000)%10;
            9: desiredDigit = (displayedNum/1000000000)%10;
        endcase

    
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
