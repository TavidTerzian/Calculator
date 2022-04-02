`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/01/2022 02:07:34 PM
// Design Name: 
// Module Name: bin_num_display
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


module bin_num_display(
    input [9:0] btn,
    input clk,
    output logic [3:0] an,
    output [6:0] seg
    );
    logic [16:0] counter;
    logic [9:0] last_val = 0;
    logic [3:0] desiredDigit;
    logic [1:0] counter_4;
    logic counter_en;
    
    display disp1(.digit(desiredDigit), .seven_seg(seg));
    
    always @ (posedge clk)begin
        case (counter_4)
            0: an = 4'b1110;
            1: an = 4'b1101;
            2: an = 4'b1011;
            3: an = 4'b0111;
        endcase
    end
    
    always @ (posedge clk)
        case (counter_4)
            0: desiredDigit = btn%10;
            1: desiredDigit = (btn/10)%10;
            2: desiredDigit = (btn/100)%10;
            3: desiredDigit = (btn/1000)%10;
        endcase
    
    always @ (posedge clk)begin
        if (counter >= 10_000) counter <= 0;
        else counter <= counter + 1'b1;
    end
    
    always @ (posedge clk)begin
        if (counter_en)begin
            if (counter_4 == 3) counter_4 <= 0;
            else counter_4 <= counter_4 + 1'b1;
        end
    end
    
    assign counter_en = (counter == 0);        
    
endmodule
