module datapath(input  logic        clk, reset,
                input  logic [1:0]  ResultSrc,
                input  logic        Branch, Jump, ALUSrcA, ALUSrcB, Jalr,
                input  logic        RegWrite,
                input  logic [2:0]  ImmSrc,
                input  logic [3:0]  ALUControl,
                output logic [31:0] PC,
                input  logic [31:0] Instr,
                output logic [31:0] ALUResult, WriteData,
                input  logic [31:0] ReadData);
    logic [31:0] PCNext, PCPlus4, PCTarget, PC_jalr;
    logic [31:0] ImmExt;
    logic [31:0] regData;
    logic [31:0] SrcA, SrcB;
    logic [31:0] Result;
    logic  [2:0] funct3;
    logic  [1:0] PCSrc;

    assign funct3  = Instr[14:12];
    assign PC_jalr = {ALUResult[31:1], 1'b0};

    // branch logic
    bcomp       bc(.a(regData), .b(SrcB), .comp_ctrl(funct3), .Branch, .Jump, .Jalr, .PCSrc);

    // next PC logic
    flopr #(32) pcreg(clk, reset, PCNext, PC);
    adder       pcadd4(PC, 32'd4, PCPlus4);
    adder       pcaddbranch(PC, ImmExt, PCTarget);
    mux3 #(32)  pcmux(.d0(PCPlus4), .d1(PCTarget), .d2(PC_jalr), .s(PCSrc), .y(PCNext));

    // register file logic
    regfile     rf(.clk, .we3(RegWrite),
                   .a1(Instr[19:15]), .a2(Instr[24:20]),
                   .a3(Instr[11:7]), .wd3(Result),
                   .rd1(regData), .rd2(WriteData));
    extend      ext(.instr(Instr[31:7]),
                    .immsrc(ImmSrc),
                    .immext(ImmExt));

    // ALU logic
    mux2 #(32)  srcamux(regData, PC, ALUSrcA, SrcA);
    mux2 #(32)  srcbmux(WriteData, ImmExt, ALUSrcB, SrcB);
    alu         alu(.src1(SrcA),
                    .src2(SrcB),
                    .alu_ctrl(ALUControl),
                    .ext(Instr[30]),
                    .alu_out(ALUResult));
    mux4 #(32)  resultmux(ALUResult, ReadData, PCPlus4, ImmExt, ResultSrc, Result);
endmodule
