module imem(input  logic [31:0] a,
            output logic [31:0] rd);
    logic [31:0] RAM[1023:0];
    initial begin
        $readmemh("tests/logic.hex", RAM, 0, 1023);
    end

    assign rd = RAM[a[31:2]]; // word aligned
endmodule
