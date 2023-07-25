module alu (
    input  logic [31:0] src1, src2,
    input  logic [2:0]   alu_ctrl,
    output logic [31:0]  alu_out,
    output logic         zero
);
    logic [31:0] sub;
    assign sub = src1 - src2;

    always_comb begin
        case(alu_ctrl)
            3'b000:  alu_out = src1 + src2;
            3'b001:  alu_out = sub;
            3'b010:  alu_out = src1 & src2;
            3'b011:  alu_out = src1 | src2;
            3'b100:  alu_out = src1 ^ src2;
            3'b101:  alu_out = {{31{1'b0}}, sub[31]};
            default: alu_out = 32'bx;
        endcase
    end
    assign zero = alu_out == 0;
endmodule
