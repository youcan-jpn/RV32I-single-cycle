`include "defs.sv"

module dmem(input  logic clk, we,
            input  logic  [2:0] mode,
            input  logic [31:0] a, wd,
            output logic [31:0] rd);
    logic [31:0] RAM[63:0];
    logic [31:0] rd_base;

    always_comb begin
        rd_base = RAM[a[31:2]];
        case(mode)
            `MEM_LW:  rd = rd_base;
            `MEM_LH:  rd = {{16{rd_base[15]}}, rd_base[15:0]};
            `MEM_LB:  rd = {{24{rd_base[7]}}, rd_base[7:0]};
            `MEM_LHU: rd = {16'b0, rd_base[15:0]};
            `MEM_LBU: rd = {24'b0, rd_base[7:0]};
            default: rd = 32'bx;
        endcase
    end

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
