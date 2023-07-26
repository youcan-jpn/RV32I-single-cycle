`include "defs.sv"

module aludec(input  logic       opb5,
              input  logic [2:0] funct3,
              input  logic       funct7b5,
              input  logic [1:0] ALUOp,
              output logic [2:0] ALUControl);
    logic  RtypeSub;
    assign RtypeSub = funct7b5 & opb5; // TRUE for R-type subtract

    always_comb begin
        case(ALUOp)
            2'b00: ALUControl = `ALU_ADD; // addition
            2'b01: ALUControl = `ALU_DCR; // もともとはbeq命令を引き算の結果が0かどうかで判定していた
            default: case(funct3) // R-type or I-type ALU
                         3'b000:     ALUControl = `ALU_ADD;  // add, addi, sub, sub
                         3'b001:     ALUControl = `ALU_SL;   // sll, slli
                         3'b010:     ALUControl = `ALU_SLT;  // slt, slti
                         3'b011:     ALUControl = `ALU_SLTU; // sltu, sltiu
                         3'b100:     ALUControl = `ALU_XOR;  // xor, xori
                         3'b101:     ALUControl = `ALU_SR;   // srl, srli, sra, srai
                         3'b110:     ALUControl = `ALU_OR;   // or, ori
                         3'b111:     ALUControl = `ALU_AND;  // and, andi
                         default:    ALUControl = `ALU_DCR;  // Don't CaRe
                     endcase
        endcase
    end
endmodule
