`timescale 1ns / 1ps

module proc(
    input           clk,
    input           reset,
    input   [7:0]   SW
    );
    
    reg [6:0]   PC;
    wire [31:0] command;
    reg         count_bit;
    reg [31:0]  data;
    wire [31:0] se;
    wire [31:0] wd;
    wire [31:0] rd[0:2];
    wire        flag;
    
    ram ram_one(
            .ad(PC),
            .rd(command)
        );
    
    register_file   regfile_one(
            .clk(clk),
            .reset(reset),
            .a1(command[22:18]),
            .a2(command[17:13]),
            .a3(command[12:8]),
            .wd3(wd),
            .we(command[29] | command[28]),
            .rd1(rd[0]),
            .rd2(rd[1])
        );  
    
    miriscv_alu mir_one(
            .operator_i(command[27:23]),
            .operand_a_i(rd[0]),
            .operand_b_i(rd[1]),
            .result_o(rd[2]),
            .comparison_result_o(flag)
        );
    
    sign_extend se_one(
            .data(data),
            .count(count_bit),
            .result(wd)
        );
    
    sign_extend se_two(
            .data(command[7:0]),
            .count(1),
            .result(se)
        );
    
    always @(posedge clk)
    begin
        if (reset)
        begin
            PC <= 0;
        end
        else if (command[31] | (command[30] & flag))
            PC <= PC + se;
        else
            PC <= PC + 'b1;
    end
    
    always @(*)
    begin
        if (reset)
        begin
            data <= 0;
            count_bit <= 0;
        end
        else
        begin
            case (command[29:28])
                'b11:
                begin   
                    data <= command[7:0];
                    count_bit <= 'b1;
                end
                'b01: 
                begin   
                    data <= SW[7:0];
                    count_bit <= 'b1;
                end
                'b10:
                begin
                    data <= rd[2];
                    count_bit <= 'b0;
                end
            endcase
        end
    end
    
endmodule
