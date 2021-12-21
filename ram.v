`timescale 1ns / 1ps

module ram(
    input   [5:0] ad, //address
    output  [31:0] rd //read data
    );
    
    reg [31:0]  RAM[0:63]; //создать пам€ть из 64-х 32-битных €чеек
    
    assign  rd = RAM[ad]; //подключение выхода rd к €чейке пам€ти с адресом ad 
    
    initial begin
        $readmemb("program.txt", RAM);
    end
    
endmodule
