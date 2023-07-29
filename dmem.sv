`include "defs.sv"

module dmem(input  logic clk, we,
            input  logic  [2:0] mode,
            input  logic [31:0] a, wd,
            output logic [31:0] rd);
    logic [31:0] RAM[63:0];

    assign rd = RAM[a[31:2]]; // word aligned

    always_ff @(posedge clk) begin
        if (we) begin
            case(mode)
                `MEM_SW: RAM[a[31:2]][31:0] <= wd[31:0];
                `MEM_SH: RAM[a[31:2]][15:0] <= wd[15:0];
                `MEM_SB: RAM[a[31:2]][7:0]  <= wd[7:0];
                default: ;// do nothing
            endcase
        end
    end
endmodule
