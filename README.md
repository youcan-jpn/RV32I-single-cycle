# single-cycle-processor-riscv

```bash
$ iverilog -g2012 adder.sv alu.sv aludec.sv controller.sv datapath.sv dmem.sv extend.sv flopenr.sv flopr.sv imem.sv maindecoder.sv mux2.sv mux3.sv regfile.sv riscvsingle.sv testbench.sv top.sv
$ vvp a.out
```

## Implemented Instructions
- R-type
  - `add`, `sub`, `and`, `or`, `slt`
- I-type
  - `lw`, `sw`, `addi`, `andi`, `ori`
- B-type
  - `beq`
- J-type
  - `jal`

## Unimplement Instructions
- R-type
  - `sll`, `sltu`, `xor`, `srl`, `sra`
- I-type
  - `lb`, `lh`, `lbu`, `lhu`, `slli`, `slti`, `sltiu`, `xori`, `srli`, `srai`, , `jalr`
- U-type
  - `auipc`, `lui`
