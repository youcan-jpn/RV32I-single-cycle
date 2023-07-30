# single-cycle-processor-riscv

```bash
$ iverilog -g2012 adder.sv alu.sv aludec.sv controller.sv datapath.sv dmem.sv extend.sv flopenr.sv flopr.sv imem.sv maindecoder.sv mux2.sv mux3.sv mux4.sv regfile.sv riscvsingle.sv testbench.sv top.sv bcomp.sv
$ vvp a.out
```

## Implemented Instructions
- R-type
  - `add`, `sub`, `and`, `or`, `slt`, `sltu`, `xor`, `srl`, `sra`, `sll`, `jalr`
- I-type
  - `lw`, `lb`, `lh`, `lbu`, `lhu`, `addi`, `andi`, `ori`, `xori`, `srli`, `srai`, `slli`, `slti`, `sltiu`,
- B-type
  - `beq`, `bne`, `blt`, `bge`, `bltu`, `bgeu`
- J-type
  - `jal`
- S-type
  - `sw`, `sh`, `sb`
- U-type
  - `lui`, `auipc`

## Unimplement Instructions
- Privileged / CSR instructions
  - `ecall`, `ebreak`, `uret`, `sret`, `mret`, `csrrw`, `csrrs`, `csrrc`, `csrrwi`, `csrrsi`, `csrrci`

## About testbench
`riscvtest.txt` is based on Harris&Harris.
Some instructions are added / modified.

- `sw  x2, 0x20(x3)` has been transformed into `sw  x2, 0x20(x0)` because x3 has an instruction address which would be change by adding testbench lines.
- `ori x4, x4, 8` and `xori x4, x4, 8` are added after `or x4, x7, x2` to test `ori` and `xori`
- `slli x7, x7, 2`, `srli x7, x7, 1`, and `srai x7, x7, 1` are added after `addi x7, x3, -9` to test `slli`, `srli`, and `srai`

## How to create docker environment for test
1. `docker compose up -d --build`
2. `docker exec -it riscv-single-cycle`
3. `cd /src && mkdir build && cd build && ../configure --prefix=${RISCV} --enable-multilib`
4. `make linux -j4` (this would take long time)

## References
1. [Digital Design and Computer Architecture RISC-V Edition](https://www.amazon.co.jp/Digital-Design-Computer-Architecture-RISC-V/dp/0128200642)
2. [riscv-gnu-toolchain](https://github.com/riscv-collab/riscv-gnu-toolchain)
3. [riscv-tests](https://github.com/riscv-software-src/riscv-tests)
4. [RISC-V CONVERTER](https://www.eg.bucknell.edu/~csci206/riscv-converter/index.html#)
5. [計算機構成 第6回 RV32Iのマイクロアーキテクチャ](https://www.am.ics.keio.ac.jp/parthenon/rvmicro.pdf)
6. [Verilog-HDLで算術右シフトを書く方法](https://hikalium.hatenablog.jp/entry/2017/07/10/091146)
7. [SystemVerilog: ビット長拡張（符号拡張）の書き方](https://nodamushi.hatenablog.com/entry/2018/12/03/233840)
   - `bcomp.sv`作成時に参考にした
8. [Amano Lab.](https://www.am.ics.keio.ac.jp/parthenon/)
9. [コンピュータ構成と設計 / Computer Organization and Design](https://yamin.cis.k.hosei.ac.jp/lectures/cod/)
