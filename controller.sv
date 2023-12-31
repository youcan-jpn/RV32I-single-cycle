module controller(input  logic [6:0] op,
                  input  logic [2:0] funct3,
                  input  logic       funct7b5,
                  output logic [1:0] ResultSrc,
                  output logic       MemWrite,
                  output logic       Branch, ALUSrcA, ALUSrcB,
                  output logic       RegWrite, Jump, Jalr,
                  output logic [2:0] ImmSrc,
                  output logic [3:0] ALUControl);
    logic [1:0] ALUOp;

    maindec md(.op, .ResultSrc,
               .MemWrite, .Branch,
               .ALUSrcA, .ALUSrcB, .RegWrite,
               .Jump, .Jalr, .ImmSrc, .ALUOp);
    aludec  ad(.opb5(op[5]), .funct3,
               .funct7b5, .ALUOp,
               .ALUControl);
endmodule
