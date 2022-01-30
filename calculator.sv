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
    input num,
    input opcode[3:0],
    input btn[9:0],
    output reg displayedNum
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
    reg [32:0] val1;
    reg [32:0] va12;
    reg op;
    
    always @ (posedge clk)begin
        if (opcode != 0) op = 1;
        else op = 0;
    end
      
    always @ (posedge clk)begin
        if(rst) state = s0;
        else 
        begin
            case(state) 
                s0: if(pwr) state = s1;
                s1: state = s2;
                s2:begin
                    if(num)state = s3;
                    if(op) state = s4;
                    if(neg) state = s7;
                end
                s3:begin
                    if(!num)begin
                        val1= getNum(btn)+val1*10;
                        displayedNum = val1;
                        state = s2;
                    end
                end
                s4:begin
                    if(!op)begin
                        val2 = eval(val1, val2, opcode); // stopped here need to figure out eval
                    end
                end
            endcase
        end
      end
    
    function int eval(input reg val1,val2, opcode);
        if(opcode == 3'b000) return val1;
        else if(opcode == 3'b001) return val1+val2;
        else if(opcode == 3'b010) return val2-val1;
        else if(opcode == 3'b011)return val2/val1;
        else if(opcode == 3'b100)return val1*val2;
        else return 0;
    endfunction
    
    function int getNum(input btn[9:0]);
        case(btn)
            btn[0:0]: return 0;
            btn[1:0]: return 1;
            btn[2:0]: return 2;
            btn[3:0]: return 3;
            btn[4:0]: return 4;
            btn[5:0]: return 5;
            btn[6:0]: return 6;
            btn[7:0]: return 7;
            btn[8:0]: return 8;
            btn[9:0]: return 9;
        endcase
    endfunction
    
endmodule
