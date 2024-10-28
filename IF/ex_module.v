module StageEx(
    input clk, rst,
    input wbEnIn, memREnIn, memWEnIn, branchTakenIn, ldStatus, imm, carryIn,
    input [3:0] exeCmd,
    input [31:0] val1, valRm, pc,
    input [11:0] shifterOperand,
    input [23:0] signedImm24,
    input [3:0] dest,
    input [1:0] selSrc1, selSrc2,
    input [31:0] valMem, valWb,
    output wbEnOut, memREnOut, memWEnOut, branchTakenOut,
    output [31:0] aluRes, exeValRm, branchAddr,
    output [3:0] exeDest,
    output [3:0] status
);

endmodule