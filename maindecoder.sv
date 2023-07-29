module maindec(input  logic [6:0] op,
               output logic [1:0] ResultSrc,
               output logic       MemWrite,
               output logic       Branch, ALUSrcA, ALUSrcB,
               output logic       RegWrite, Jump, Jalr,
               output logic [2:0] ImmSrc,
               output logic [1:0] ALUOp);
    logic [13:0] controls;

    assign {RegWrite, ImmSrc, ALUSrcA, ALUSrcB, MemWrite,
            ResultSrc, Branch, ALUOp, Jump, Jalr} = controls;

    always_comb begin
        case(op)
            // RegWrite_ImmSrc_ALUSrcA_ALUSrcB_MemWrite_ResultSrc_Branch_ALUOp_Jump_Jalr
            // ImmSrcはextendの方式を指定
            // ALUSrcA: 1で現PCを採用、0でregisterから読みだしたデータを採用
            // ALUSrcB: 1でImmExtを採用、0でWriteDataを採用 (datapath.svのSrcB)
            // ResultSrc: 00でALUResult, 01でReadData, 10でPCPlus4, 11でImmExtを採用 (datapath.svのResult=regfileへの書き込み内容)
            7'b0000011: controls = 14'b1_000_0_1_0_01_0_00_0_0; // lw
            7'b0100011: controls = 14'b0_001_0_1_1_00_0_00_0_0; // sw
            7'b0110011: controls = 14'b1_xxx_0_0_0_00_0_10_0_0; // R-type
            7'b1100011: controls = 14'b0_010_0_0_0_00_1_01_0_0; // B-type
            7'b0010011: controls = 14'b1_000_0_1_0_00_0_10_0_0; // I-type ALU
            7'b1100111: controls = 14'b1_000_0_1_0_10_0_00_0_1; // jalr
            7'b1101111: controls = 14'b1_011_0_0_0_10_0_00_1_0; // jal
            7'b0010111: controls = 14'b1_100_1_1_0_00_0_00_0_0; // auipc
            7'b0110111: controls = 14'b1_100_x_x_0_11_0_xx_0_0; // lui
            default:    controls = 14'bx_xxx_x_x_x_xx_x_xx_x_x; // ???
        endcase
    end
endmodule
