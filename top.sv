module top(input  logic        clk, reset,
           output logic [31:0] WriteData, DataAdr,
           output logic        MemWrite);
    logic [31:0] PC, Instr, ReadData;

    // instantiate processor and memories
    riscvsingle rvsingle(.clk, .reset, .PC, .Instr, .MemWrite, .ALUResult(DataAdr), .WriteData, .ReadData);
    imem imem(PC, Instr);
    dmem dmem(.clk, .we(MemWrite), .a(DataAdr), .wd(WriteData), .rd(ReadData), .mode(Instr[14:12]));
endmodule
