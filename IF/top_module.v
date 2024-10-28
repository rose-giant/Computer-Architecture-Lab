module TopModule(input clock, rst);
    wire hazard, hazardTwoSrc;
    assign hazard = 0;
    wire [1:0] selSrc1, selSrc2;

    wire [31:0] pcOutIf, instOutIf;

    wire [31:0] pcOutIfId, instOutIfId;
    wire [31:0] pcOutId;
    wire [3:0] aluCmdOutId;
    wire memReadOutId, memWriteOutId, wbEnOutId, branchOutId, sOutId;
    wire [31:0] reg1OutId, reg2OutId;
    wire immOutId;
    wire [11:0] shiftOperandOutId;
    wire [23:0] imm24OutId;
    wire [3:0] destOutId;
    wire [3:0] src1OutId, src2OutId;
    wire [31:0] pcOutIdEx;
    wire [3:0] aluCmdOutIdEx;
    wire memReadOutIdEx, memWriteOutIdEx, wbEnOutIdEx, branchOutIdEx, sOutIdEx;
    wire [31:0] reg1OutIdEx, reg2OutIdEx;
    wire [3:0] src1OutIdEx, src2OutIdEx;
    wire immOutIdEx;
    wire [11:0] shiftOperandOutIdEx;
    wire [23:0] imm24OutIdEx;
    wire [3:0] destOutIdEx;
    wire carryOut;
    wire memReadOutEx, memWriteOutEx, wbEnOutEx;
    wire branchTaken;
    assign branchTaken = 0;
    wire [31:0] branchAddr;
    assign branchAddr = 32'b0;
    wire [31:0] aluResOutEx, reg2OutEx;
    wire [3:0] destOutEx;
    wire [3:0] status;
    wire carryIn;
    assign carryIn = status[1];
    wire memReadOutExMem, memWriteOutExMem, wbEnOutExMem;
    wire [31:0] aluResOutExMem, reg2OutExMem;
    wire [3:0] destOutExMem;
    wire memReadOutMem, wbEnOutMem;
    wire ramFreeze;
    assign ramFreeze = 0;
    wire [31:0] aluResOutMem, memDataOutMem;
    wire [3:0] destOutMem;
    wire memReadOutMemWb, wbEnOutMemWb;
    wire [31:0] aluResOutMemWb, memDataOutMemWb;
    wire [3:0] destOutMemWb;
    wire wbEn;
    wire [31:0] wbValue;
    wire [3:0] wbDest;
    wire [15:0] SRAM_DQ;
    wire [17:0] SRAM_ADDR;

    StageIf stIf(
        .clk(clock), .rst(rst),
        .branchTaken(branchTaken), .freeze(hazard | ramFreeze),
        .branchAddr(branchAddr),
        .pc(pcOutIf), .instruction(instOutIf)
    );
    RegsIfId regsIf(
        .clk(clock), .rst(rst),
        .freeze(hazard | ramFreeze), .flush(branchTaken),
        .pcIn(pcOutIf), .instructionIn(instOutIf),
        .pcOut(pcOutIfId), .instructionOut(instOutIfId)
    );
    StageId stId(
        .clk(clock), .rst(rst),
        .pcIn(pcOutIfId), .inst(instOutIfId),
        .status(status),
        .wbWbEn(wbEn), .wbValue(wbValue), .wbDest(wbDest),
        .hazard(hazard),
        .pcOut(pcOutId),
        .aluCmd(aluCmdOutId), .memRead(memReadOutId), .memWrite(memWriteOutId),
        .wbEn(wbEnOutId), .branch(branchOutId), .s(sOutId),
        .reg1(reg1OutId), .reg2(reg2OutId),
        .imm(immOutId), .shiftOperand(shiftOperandOutId), .imm24(imm24OutId), .dest(destOutId),
        .src1(src1OutId), .src2(src2OutId), .hazardTwoSrc(hazardTwoSrc)
    );
    RegsIfId reg2(
        .clk(clock), .rst(rst),
        .freeze(hazard | ramFreeze), .flush(branchTaken),
        .pcIn(pcOutIf), .instructionIn(instOutIf),
        .pcOut(pcOutIfId), .instructionOut(instOutIfId)
    );
    StageEx stEx(
        .clk(clock), .rst(rst),
        .wbEnIn(wbEnOutIdEx), .memREnIn(memReadOutIdEx), .memWEnIn(memWriteOutIdEx),
        .branchTakenIn(branchOutIdEx), .ldStatus(sOutIdEx), .imm(immOutIdEx), .carryIn(carryOut),
        .exeCmd(aluCmdOutIdEx), .val1(reg1OutIdEx), .valRm(reg2OutIdEx), .pc(pcOutIdEx),
        .shifterOperand(shiftOperandOutIdEx), .signedImm24(imm24OutIdEx), .dest(destOutIdEx),
        .selSrc1(selSrc1), .selSrc2(selSrc2), .valMem(aluResOutExMem), .valWb(wbValue),
        .wbEnOut(wbEnOutEx), .memREnOut(memReadOutEx), .memWEnOut(memWriteOutEx),
        .branchTakenOut(branchTaken), .aluRes(aluResOutEx), .exeValRm(reg2OutEx), .branchAddr(branchAddr),
        .exeDest(destOutEx), .status(status)
    );
    RegsIfId reg3(
        .clk(clock), .rst(rst),
        .freeze(hazard | ramFreeze), .flush(branchTaken),
        .pcIn(pcOutIf), .instructionIn(instOutIf),
        .pcOut(pcOutIfId), .instructionOut(instOutIfId)
    );
    StageMem stMem(
        .clk(clock), .rst(rst),
        .wbEnIn(wbEnOutExMem), .memREnIn(memReadOutExMem), .memWEnIn(memWriteOutExMem),
        .aluResIn(aluResOutExMem), .valRm(reg2OutExMem), .destIn(destOutExMem),
        .wbEnOut(wbEnOutMem), .memREnOut(memReadOutMem),
        .aluResOut(aluResOutMem), .memOut(memDataOutMem), .destOut(destOutMem),
        .freeze(ramFreeze),
        .SRAM_ADDR(SRAM_ADDR),
        .SRAM_DQ(SRAM_DQ),
        .SRAM_UB_N(SRAM_UB_N),
        .SRAM_LB_N(SRAM_LB_N),
        .SRAM_WE_N(SRAM_WE_N),
        .SRAM_CE_N(SRAM_CE_N),
        .SRAM_OE_N(SRAM_DE_N)
    );
    RegsIfId reg4(
        .clk(clock), .rst(rst),
        .freeze(hazard | ramFreeze), .flush(branchTaken),
        .pcIn(pcOutIf), .instructionIn(instOutIf),
        .pcOut(pcOutIfId), .instructionOut(instOutIfId)
    );
    StageWrite stWb(
        .clk(clock), .rst(rst),
        .wbEnIn(wbEnOutMemWb), .memREn(memReadOutMemWb),
        .aluRes(aluResOutMemWb), .memData(memDataOutMemWb), .destIn(destOutMemWb),
        .wbEnOut(wbEn), .wbValue(wbValue), .destOut(wbDest)
    );

endmodule