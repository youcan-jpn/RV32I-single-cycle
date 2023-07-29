module riscvsingle(input  logic        clk, reset,
                   output logic [31:0] PC,
                   input  logic [31:0] Instr,
                   output logic        MemWrite,
                   output logic [31:0] ALUResult, WriteData,
                   input  logic [31:0] ReadData);
    logic       ALUsrcA, ALUSrcB, RegWrite, Jump, Jalr, Branch;
    logic [1:0] ResultSrc;
    logic [2:0] ImmSrc;
    logic [3:0] ALUControl;

    controller c(.op(Instr[6:0]), .funct3(Instr[14:12]),
                 .funct7b5(Instr[30]),
                 .ResultSrc(ResultSrc), .MemWrite(MemWrite), .Branch(Branch),
                 .ALUSrcA(ALUSrcA), .ALUSrcB(ALUSrcB), .RegWrite(RegWrite), .Jump(Jump), .Jalr,
                 .ImmSrc(ImmSrc), .ALUControl(ALUControl));
    datapath  dp(.clk(clk), .reset(reset),
                 .ResultSrc(ResultSrc), .Branch(Branch), .Jump, .Jalr,
                 .ALUSrcA(ALUSrcA), .ALUSrcB(ALUSrcB), .RegWrite(RegWrite),
                 .ImmSrc(ImmSrc), .ALUControl(ALUControl),
                 .PC(PC), .Instr(Instr),
                 .ALUResult(ALUResult), .WriteData(WriteData),
                 .ReadData(ReadData));
endmodule
