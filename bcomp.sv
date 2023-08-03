`include "defs.sv"

module bcomp #(parameter N = 32)
                    (input  logic [N-1:0] a, b,
                     input  logic [2:0]  comp_ctrl,
                     input  logic        Branch, Jump, Jalr,
                     output logic [1:0]  PCSrc);
    logic eq, neq, lt, ltu, ge, geu;

    assign eq  = (a === b);
    assign neq = (a !== b);
    assign lt  = ($signed(a) < $signed(b));
    assign ltu = (a < b);
    assign ge  = ($signed(a) >= $signed(b));
    assign geu = (a >= b);

    always_comb begin
        if (Jump) begin
            PCSrc = 2'b01;
        end else if (~Jump & Jalr) begin
            PCSrc = 2'b10;
        end else if (~Jump & ~Jalr) begin
            case(comp_ctrl)
                `COMP_EQ:  PCSrc = (eq & Branch)  ? 2'b01 : 2'b00;
                `COMP_NE:  PCSrc = (neq & Branch) ? 2'b01 : 2'b00;
                `COMP_LT:  PCSrc = (lt & Branch)  ? 2'b01 : 2'b00;
                `COMP_LTU: PCSrc = (ltu & Branch) ? 2'b01 : 2'b00;
                `COMP_GE:  PCSrc = (ge & Branch)  ? 2'b01 : 2'b00;
                `COMP_GEU: PCSrc = (geu & Branch) ? 2'b01 : 2'b00;
                default:   PCSrc = 2'b00;
            endcase
        end
    end
endmodule