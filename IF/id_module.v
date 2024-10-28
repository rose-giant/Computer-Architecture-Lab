module StageId(
    input clk, rst,
    input [31:0] pcIn, inst,
    input [3:0] status,
    input wbWbEn,
    input [31:0] wbValue,
    input [3:0] wbDest,
    input hazard,
    output [31:0] pcOut,
    output [3:0] aluCmd,
    output memRead, memWrite, wbEn, branch, s,
    output [31:0] reg1, reg2,
    output imm,
    output [11:0] shiftOperand,
    output signed [23:0] imm24,
    output [3:0] dest,
    output [3:0] src1, src2,
    output hazardTwoSrc
);
endmodule