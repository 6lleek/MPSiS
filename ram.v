`timescale 1ns / 1ps

module ram(
    input   [5:0] ad, //address
    output  [31:0] rd //read data
    );
    
    reg [31:0]  RAM[0:63]; //������� ������ �� 64-� 32-������ �����
    
    assign  rd = RAM[ad]; //����������� ������ rd � ������ ������ � ������� ad 
    
    initial begin
        $readmemb("program.txt", RAM);
    end
    
endmodule
