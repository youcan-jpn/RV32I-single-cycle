`include "defs.sv"

module bcomp #(parameter N = 32)
                    (input  logic [N-1:0] a, b,
                     input  logic [2:0]  comp_ctrl,
                     input  logic Branch, Jump,
                     output logic PCSrc);
    logic eq, neq, lt, ltu, ge, geu;
    logic [N-1:0] au, as, bu, bs;

    assign au = $unsigned(a);
    assign as = $signed(a);
    assign bu = $unsigned(b);
    assign bs = $signed(a);

    assign eq  = (a === b);
    assign neq = (a !== b);
    assign lt  = (as < bs);
    assign ltu = (au < bu);
    assign ge  = (as >= bs);
    assign geu = (au >= bu);

    always_comb begin
        case(comp_ctrl)
            `COMP_EQ:  PCSrc = eq & Branch | Jump;
            `COMP_NE:  PCSrc = neq & Branch | Jump;
            `COMP_LT:  PCSrc = lt & Branch | Jump;
            `COMP_LTU: PCSrc = ltu & Branch | Jump;
            `COMP_GE:  PCSrc = ge & Branch | Jump;
            `COMP_GEU: PCSrc = geu & Branch | Jump;
            default:   PCSrc = Jump;
        endcase
    end
endmodule