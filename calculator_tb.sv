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
    logic num;
    logic op;
    logic [31:0] val1;
    logic [31:0] val2;
    logic [31:0] displayedNum;
    
    calculator uut(
    .pwr(pwr), .opcode(opcode), .btn(btn), .displayedNum(displayedNum), .num(num), .op(op), .val1(val1), .val2(val2)
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
            if(i == 15)begin
                btn = 10'b0000000000;
            end
            if(i == 25)begin
                opcode = 3'b010;
            end
            if (i == 35) opcode = 3'b000;
            if(i == 45)begin
                btn = 10'b0000001000;
            end
            if(i == 55)begin
                btn = 10'b0000000000;
            end
            if(i == 65)begin
                opcode = 3'b001;
            end
            if(i == 75) opcode = 3'b000;
            
        end
    
endmodule
