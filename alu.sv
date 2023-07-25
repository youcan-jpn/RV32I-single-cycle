`include "defs.sv"

module alu (
    input  logic [31:0] src1, src2,
    input  logic [2:0]   alu_ctrl,
    input  logic         arith,
    output logic [31:0]  alu_out,
    output logic         zero
);
    logic [31:0] sub;
    logic [4:0]  shamt;
    assign sub = src1 - src2;
    assign shamt = src2[4:0];

    always_comb begin
        case(alu_ctrl)
            `ALU_ADD: alu_out = src1 + src2;
            `ALU_SUB: alu_out = sub;
            `ALU_AND: alu_out = src1 & src2;
            `ALU_OR : alu_out = src1 | src2;
            `ALU_XOR: alu_out = src1 ^ src2;
            `ALU_SLT: alu_out = {{31{1'b0}}, sub[31]};
            `ALU_SL : alu_out = src1 << shamt;
            `ALU_SR : if (arith) begin
                          alu_out = src1 >>> shamt;
                      end else begin
                          alu_out = src1 >> shamt;
                      end
            // `ALU_SR : alu_out = 7;
            default:  alu_out = 32'bx;
        endcase
    end
    assign zero = alu_out == 0;
endmodule
