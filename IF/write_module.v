module StageWrite(
    input clk, rst,
    input wbEnIn, memREn,
    input [31:0] aluRes, memData,
    input [3:0] destIn,
    output wbEnOut,
    output [31:0] wbValue,
    output [3:0] destOut
);

endmodule