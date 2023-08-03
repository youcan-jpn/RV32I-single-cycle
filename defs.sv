`define ALU_ADD  4'b0000
`define ALU_SL   4'b0001
`define ALU_SLT  4'b0010
`define ALU_SLTU 4'b0011
`define ALU_XOR  4'b0100
`define ALU_SR   4'b0101
`define ALU_OR   4'b0110
`define ALU_AND  4'b0111
`define ALU_SUB  4'b1000
`define ALU_DCR  4'b0xxx

`define COMP_EQ  3'b000
`define COMP_NE  3'b001
`define COMP_LT  3'b100
`define COMP_GE  3'b101
`define COMP_LTU 3'b110
`define COMP_GEU 3'b111

`define MEM_SW   3'b010
`define MEM_SH   3'b001
`define MEM_SB   3'b000

`define MEM_LB   3'b000
`define MEM_LH   3'b001
`define MEM_LW   3'b010
`define MEM_LHU  3'b101
`define MEM_LBU  3'b100
