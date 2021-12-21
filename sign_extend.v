`timescale 1ns / 1ps


module sign_extend(
    input [31:0] data,
    input        count,
    input [31:0] result
    );
    
    assign  result = count ? {{24{data[7]}}, data[7:0]} : data;
    //assign  result = count == 1 ? (data[7] ? 'b11111111_11111111_11111111_00000000 + data[7:0] : 'd0 + data[7:0]) : data;
endmodule
