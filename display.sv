`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/11/2022 03:10:54 PM
// Design Name: 
// Module Name: calc_display
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


module display(
        input[3:0] digit,
        output reg [6:0] seven_seg
    );
    
    parameter zero = 7'b100_0000;
    parameter one = 7'b111_1001;
    parameter two = 7'b010_0100;
    parameter three = 7'b011_0000;
    parameter four = 7'b001_1001;
    parameter five = 7'b001_0010;
    parameter six = 7'b000_0010;
    parameter seven = 7'b111_1000;
    parameter eight = 7'b000_0000;
    parameter nine = 7'b001_0000; 
    parameter negOn = 7'b011_1111;
    parameter off = 7'b111_1111;  
    
    
    always@(digit)
        case(digit)
        0: seven_seg = zero;
        1: seven_seg = one;
        2: seven_seg = two;
        3: seven_seg = three;
        4: seven_seg = four;
        5: seven_seg = five;
        6: seven_seg = six;
        7: seven_seg = seven;
        8: seven_seg = eight;
        9: seven_seg = nine;
        default: seven_seg = off;
    endcase
endmodule
