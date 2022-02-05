`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/02/2022 12:48:07 PM
// Design Name: 
// Module Name: calculator_tb
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


module calculator_tb(

    );
    
    //input 
    logic clk, pwr, clr;
    logic [2:0] opcode;
    logic [9:0] btn;
    
    //output
    logic num;
    logic op;
    logic [3:0] pressedNum;
    logic [3:0] state;
    logic [2:0] pressedOp;
    logic [2:0] prevOp;
    logic [31:0] val1;
    logic [31:0] val2;
    logic [31:0] displayedNum;
    
    calculator uut(
    .clk(clk), .clr(clr), .pwr(pwr), .opcode(opcode), .state(state), .btn(btn), .pressedNum(pressedNum), .displayedNum(displayedNum), .num(num), .op(op), .pressedOp(pressedOp), .prevOp(prevOp), .val1(val1), .val2(val2)
    );
    
    initial
    begin
        pwr = 0;
        btn = 0;
        opcode =0;
        clr = 0;
        for (integer i = 0; i < 100_000; i = i + 1)begin
            clk = 1;
            #1;
            clk = 0;
            #1;
            if(i == 1) pwr = 1;
     
            if(i == 3) pwr = 0;    
            
            if(i == 5) btn = 10'b0000001000;
            
            if(i == 15) btn = 10'b0000000000;
          
            if(i == 25) opcode = 3'b010;
            
            if (i == 35) opcode = 3'b000;
            
            if(i == 45) btn = 10'b0000001000;
            
            if(i == 55) btn = 10'b0000000000;
            
            if(i == 65) opcode = 3'b010;
            
            if (i == 75) opcode = 3'b000;
            
            if(i == 85) btn = 10'b0000001000;
            
            if(i == 95) btn = 10'b0000000000;
            
            if(i == 105) opcode = 3'b001;
            
            if(i == 115) opcode = 3'b000;
            
            if(i == 125) opcode = 3'b010;
            
            if(i == 135) opcode = 3'b000;
            
            if(i == 145) btn = 10'b0000001000;
                        
            if(i == 155) btn = 10'b0000000000;

            if(i == 165) opcode = 3'b001;
            
            if(i == 175) opcode = 3'b000;
            
            if(i == 185) clr = 1;
            if(i == 195) clr = 0;
            
            if(i == 205) btn = 10'b0000100000;
            if(i == 215) btn = 10'b0000000000;
            
            if(i == 225) btn = 10'b0000000001;
            if(i == 235) btn = 10'b0000000000;
            
            if(i == 245) opcode = 3'b100;
            if(i == 255) opcode = 3'b000;
            
            if(i == 265) btn = 10'b0000000010;
            if(i == 275) btn = 10'b0000000000;
            
            if(i == 285) btn = 10'b0000000001;
            if(i == 295) btn = 10'b0000000000;
            
            if(i == 305) opcode = 3'b001;
            if(i == 315) opcode = 3'b000;
            
        end
    end
endmodule
