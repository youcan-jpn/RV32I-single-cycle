module datapath(input  logic        clk, reset,
                input  logic [1:0]  ResultSrc,
                input  logic        Branch, Jump, ALUSrc,
                input  logic        RegWrite,
                input  logic [1:0]  ImmSrc,
                input  logic [3:0]  ALUControl,
                output logic        Zero,
                output logic [31:0] PC,
                input  logic [31:0] Instr,
                output logic [31:0] ALUResult, WriteData,
                input  logic [31:0] ReadData);
    logic [31:0] PCNext, PCPlus4, PCTarget;
    logic [31:0] ImmExt;
    logic [31:0] SrcA, SrcB;
    logic [31:0] Result;
    logic  [2:0] funct3;
    logic        PCSrc;

    assign funct3 = Instr[14:12];

    // branch logic
    bcomp       bc(.a(SrcA), .b(SrcB), .comp_ctrl(funct3), .Branch(Branch), .Jump, .PCSrc);

    // next PC logic
    flopr #(32) pcreg(clk, reset, PCNext, PC);
    adder       pcadd4(PC, 32'd4, PCPlus4);
    adder       pcaddbranch(PC, ImmExt, PCTarget);
    mux2 #(32)  pcmux(PCPlus4, PCTarget, PCSrc, PCNext);

    // register file logic
    regfile     rf(.clk(clk), .we3(RegWrite),
                   .a1(Instr[19:15]), .a2(Instr[24:20]),
                   .a3(Instr[11:7]), .wd3(Result),
                   .rd1(SrcA), .rd2(WriteData));
    extend      ext(.instr(Instr[31:7]),
                    .immsrc(ImmSrc),
                    .immext(ImmExt));

    // ALU logic
    mux2 #(32)  srcbmux(WriteData, ImmExt, ALUSrc, SrcB);
    alu         alu(.src1(SrcA),
                    .src2(SrcB),
                    .alu_ctrl(ALUControl),
                    .ext(Instr[30]),
                    .alu_out(ALUResult),
                    .zero(Zero));
    mux3 #(32)  resultmux(ALUResult, ReadData, PCPlus4, ResultSrc, Result);
endmodule
