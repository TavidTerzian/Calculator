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
    output sig
    );
    wire q_bar;
    
    d_ff d0(.clk(clk), .d(btn), .q(q0));
    d_ff d1(.clk(clk), .d(q0), .q(q1));
    d_ff d2(.clk(clk), .d(q1), .q(q2));
    
    assign q_bar = ~q2;
    assign sig = (q1 && q_bar);    

endmodule

module d_ff(
    input clk,
    input d,
    output reg q
    );
    
    always @ (posedge clk)begin
        q <= d;
    end

endmodule
