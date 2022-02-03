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
    logic clk, pwr;
    logic [2:0] opcode;
    logic [9:0] btn;
    
    //output
    logic [31:0] displayedNum;
    
    calculator uut(
    .pwr(pwr), .opcode(opcode), .btn(btn), .displayedNum(displayedNum)
    );
    
    initial
        for (integer i = 0; i < 100_000; i = i + 1)begin
            clk = 1;
            #1;
            clk = 0;
            #1;
            if(i == 1)begin
                pwr = 1;
            end
            if(i == 3)begin
                pwr = 0;
            end
            if(i == 5)begin
                btn = 10'b0000100000;
            end
            if(i == 9)begin
                btn = 10'b0000000000;
            end
            if(i == 13)begin
                opcode = 3'b010;
            end
            if (i == 17) opcode = 3'b000;
            if(i == 20)begin
                btn = 10'b0000001000;
            end
            if(i == 25)begin
                btn = 10'b0000000000;
            end
            if(i == 30)begin
                opcode = 3'b001;
            end
            if(i == 35) opcode = 3'b000;
            
        end
    
endmodule
