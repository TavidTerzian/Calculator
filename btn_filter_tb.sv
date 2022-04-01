`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/31/2022 10:52:58 PM
// Design Name: 
// Module Name: btn_filter_tb
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


module btn_filter_tb(

    );
    
    logic clk, btn, sig;
    
    btn_filter uut(.clk(clk), .btn(btn), .sig(sig));
    
    initial begin
        btn = 0;  
    
        for (integer i = 0; i < 100; i = i+1)begin
            clk = 1;
            #1;
            clk = 0;
            #1;
            
            if(i == 1) btn = 1;
            if(i == 11) btn = 0;
        end
    
    end 
endmodule
