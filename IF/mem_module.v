module StageMem(
    input clk, rst,
    input wbEnIn, memREnIn, memWEnIn,
    input [31:0] aluResIn, valRm,
    input [3:0] destIn,
    output wbEnOut, memREnOut,
    output [31:0] aluResOut, memOut,
    output [3:0] destOut,
    output freeze,
    inout [15:0] SRAM_DQ,
    output [17:0] SRAM_ADDR,
    output SRAM_UB_N,
    output SRAM_LB_N,
    output SRAM_WE_N,
    output SRAM_CE_N,
    output SRAM_OE_N
);

endmodule