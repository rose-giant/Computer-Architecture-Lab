
module StageIf(input clk, rst, branchTaken, freeze, input [31:0] branchAddr, output [31:0] pc, instruction);
    wire [31:0] muxOutput, pcOutput, pcAdderOut;

    Mux2To1 #(32) pcMux( .a0(pcAdderOut), .a1(branchAddr), .sel(branchTaken), .out(muxOutput));
    Register #(32) pcReg(.clk(clk), .rst(rst), .in(muxOutput), .ld(~freeze), .clr(1'b0), .out(pcOutput));
    Adder #(32) pcAdder(.a(pcOutput), .b(32'd4), .out(pcAdderOut));
    InstructionMemory instMem(.pc(pcOutput), .inst(instruction));
    assign pc = pcAdderOut;

endmodule
