`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/31/2022 07:45:06 PM
// Design Name: 
// Module Name: btn_filter
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


module btn_filter(
    input btn,
    input clk,
    output logic sig
    );
    
    logic q1;
    logic q2;
    logic q2_bar;
    
    always @ (posedge clk)begin
        q1 <= btn;
        q2 <= q1;
        q2_bar <= !q2;
        sig <= (btn && q2_bar);
    end
endmodule
