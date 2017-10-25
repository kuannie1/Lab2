//------------------------------------------------------------------------
// Shift Register test bench
//------------------------------------------------------------------------
`include "shiftregister.v"


module testshiftregister();

    reg             clk;
    reg             peripheralClkEdge;
    reg             parallelLoad;
    wire[7:0]       parallelDataOut;
    wire            serialDataOut;
    reg[7:0]        parallelDataIn;
    reg             serialDataIn; 
    
    // Instantiate with parameter width = 8
    shiftregister #(8) dut(.clk(clk), 
    		           .peripheralClkEdge(peripheralClkEdge),
    		           .parallelLoad(parallelLoad), 
    		           .parallelDataIn(parallelDataIn), 
    		           .serialDataIn(serialDataIn), 
    		           .parallelDataOut(parallelDataOut), 
    		           .serialDataOut(serialDataOut));
    

    // Generate clock (50MHz)
    initial begin 
    clk=0;
    end
    always #10 clk=!clk;    // 50MHz Clock


    initial begin
    	// Your Test Code
        $dumpfile("shiftregister.vcd");
        $dumpvars();

        parallelLoad = 1; peripheralClkEdge = 0; parallelDataIn = 8'b11111111; #20
        if ((parallelDataOut != parallelDataIn) && (serialDataOut != 1)) $display("Test 1 Failed");

        parallelLoad = 0; peripheralClkEdge = 1; serialDataIn = 1'b0; #20
        if ((parallelDataOut != 8'b11111110) && (serialDataOut != 1)) $display("Test 2 Failed");


        parallelLoad = 1; peripheralClkEdge = 1; parallelDataIn = 8'b00000000; serialDataIn = 1'b1; #20
        if ((parallelDataOut != 8'b00000000) && (serialDataOut != 0)) $display("Test 3 Failed");

        parallelLoad = 0; peripheralClkEdge = 1; serialDataIn = 1'b1; #20
        if ((parallelDataOut != 8'b00000001) && (serialDataOut != 0)) $display("Test 4 Failed");

        #100 $finish;

    end

endmodule

