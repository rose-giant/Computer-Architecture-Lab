`timescale 1ns/1ns

module TopLevelTB();
    localparam HCLK = 5;

    reg clk, rst;
    TopModule tm(.clock(clk), .rst(rst));
    always #HCLK clk = ~clk;

    initial begin
        
        {clk, rst} = 3'b01;
        #10 rst = 1'b0;
        #30000 $stop;
    end

endmodule