`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/09/2022 10:35:15 PM
// Design Name: 
// Module Name: calc_tb
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


module calc_tb(

    );
    //input
    logic clr, clk;
    logic [4:0] opcode;
    logic [9:0] btn;
    logic [3:0] state;
    logic [3:0] nextstate;
    logic [9:0] displayedNum;
    logic op_pressed;
    logic btn_pressed;
    logic [9:0] val1;
    logic [9:0] val2;
    logic [4:0] pressedOp;
    logic [4:0] prevOp;
    
    calc uut(.clk(clk), .clr(clr), .opcode(opcode), .btn(btn), .state(state), .nextstate(nextstate),
            .displayedNum(displayedNum), .val1(val1), .val2(val2), .pressedOp(pressedOp),
            .prevOp(prevOp), .op_pressed(op_pressed), .btn_pressed(btn_pressed));
    
    initial
    begin
        btn = 0;
        opcode =0;
        clr = 0;
        for (integer i = 0; i < 100_000; i = i + 1)begin
            clk = 1;
            #1;
            clk = 0;
            #1;  
            
            if(i == 5) btn = 10'b0000000100;
            
            if(i == 15) btn = 10'b0000000110;
          
            if(i == 25) opcode = 5'b00010;
            
            if (i == 35) opcode = 5'b00000;
            
            if(i == 45) btn = 10'b0000000100;
            if(i == 55) btn = 10'b0000000000;
            
            if(i == 65) btn = 10'b000000001;
            
            if(i == 75) btn = 10'b0000000011;
            
            if(i == 85) opcode = 5'b00001;
            
            if (i == 95) opcode = 5'b00000;            
        end
    end
    
endmodule
