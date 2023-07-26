module riscvsingle(input  logic        clk, reset,
                   output logic [31:0] PC,
                   input  logic [31:0] Instr,
                   output logic        MemWrite,
                   output logic [31:0] ALUResult, WriteData,
                   input  logic [31:0] ReadData);
    logic       ALUsrc, RegWrite, Jump, Zero, Branch;
    logic [1:0] ResultSrc, ImmSrc;
    logic [2:0] ALUControl;

    controller c(.op(Instr[6:0]), .funct3(Instr[14:12]),
                 .funct7b5(Instr[30]), .Zero(Zero),
                 .ResultSrc(ResultSrc), .MemWrite(MemWrite), .Branch(Branch),
                 .ALUSrc(ALUSrc), .RegWrite(RegWrite), .Jump(Jump),
                 .ImmSrc(ImmSrc), .ALUControl(ALUControl));
    datapath  dp(.clk(clk), .reset(reset),
                 .ResultSrc(ResultSrc), .Branch(Branch),
                 .ALUSrc(ALUSrc), .RegWrite(RegWrite),
                 .ImmSrc(ImmSrc), .funct3(ALUControl),
                 .Zero(Zero), .PC(PC), .Instr(Instr),
                 .ALUResult(ALUResult), .WriteData(WriteData),
                 .ReadData(ReadData));
endmodule
