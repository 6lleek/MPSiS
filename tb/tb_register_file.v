`timescale 1ns / 1ps

module tb_register_file();
    
    reg         clk;
    reg         reset;
    reg         we;  
    reg [4:0]   ad[0:2];
    reg [31:0]  wd;
    wire [31:0]  rd[0:1];
    reg [5:0]   i;
    
    register_file reg_file(
        .clk(clk),
        .reset(reset),
        .a1(ad[0]),
        .a2(ad[1]),
        .a3(ad[2]),
        .wd3(wd),
        .we(we),
        .rd1(rd[0]),
        .rd2(rd[1])
    );
    
    initial begin
        $display("Start test:");
        i <= 0;
        reset <= 1;
        #10
        reset <= 0;
        while (i < 31)
        begin
            i <= i + 1; 
            we <= 1;
            wd <= i;
            ad[0] <= i;
            ad[1] <= i;
            ad[2] <= i;
            #9;
            we <= 0;
            #1;
            $display("%d: wd = %d, rd1 = %d, rd2 = %d", i, wd, rd[0], rd[1]);
            if (rd[0] != rd[1] || rd[1] != wd)
                $error("Error in %d", i);
        end
        $finish();
    end    
    
    initial begin
        clk <=0;
        
        while (1)
        begin
            clk = !clk;
            #5;
        end
    end
    
endmodule
