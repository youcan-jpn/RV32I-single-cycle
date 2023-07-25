# single-cycle-processor-riscv

```bash
$ iverilog -g2012 adder.sv alu.sv aludec.sv controller.sv datapath.sv dmem.sv extend.sv flopenr.sv flopr.sv imem.sv maindecoder.sv mux2.sv mux3.sv regfile.sv riscvsingle.sv testbench.sv top.sv
$ vvp a.out
```

## Implemented Instructions
- R-type
  - `add`, `sub`, `and`, `or`, `slt`, `xor`
- I-type
  - `lw`, `sw`, `addi`, `andi`, `ori`, `xori`
- B-type
  - `beq`
- J-type
  - `jal`

## Unimplement Instructions
- R-type
  - `sll`, `sltu`, `srl`, `sra`
- I-type
  - `lb`, `lh`, `lbu`, `lhu`, `slli`, `slti`, `sltiu`, `srli`, `srai`, `jalr`
- U-type
  - `auipc`, `lui`


## About testbench
`riscvtest.txt` is based on Harris&Harris.
Some instructions are added.

`sw  x2, 0x20(x3)` has been transformed into `sw  x2, 0x20(x0)` because x3 has an instruction address which would be change by adding testbench lines.

