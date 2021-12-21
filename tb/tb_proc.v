`timescale 1ns / 1ps

module tb_proc();
    reg clk;
    reg reset;
    reg [7:0] sw;
    proc one_proc(
        .clk(clk),
        .reset(reset),
        .SW(sw)
    );
    
    initial
    begin
       clk <= 0;
       while (1)
        #5 clk <= ~clk;
    end
    
    initial
    begin
        sw <= 'd28;
        reset <= 0;
        #10;
        reset <= 1;
        #20;
        reset <= 0;
        #600;
        $finish();
    end
endmodule
