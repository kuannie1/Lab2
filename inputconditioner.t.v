//------------------------------------------------------------------------
// Input Conditioner test bench
//------------------------------------------------------------------------
`include "inputconditioner.v"


module testConditioner();

    reg clk;
    reg pin;
    wire conditioned;
    wire rising;
    wire falling;
    
    inputconditioner dut(.clk(clk),
    			 .noisysignal(pin),
			 .conditioned(conditioned),
			 .positiveedge(rising),
			 .negativeedge(falling));


    // Generate clock (50MHz)
    initial begin 
    clk=0;
    end
    always #10 clk=!clk;    // 50MHz Clock
    
    initial begin
    $dumpfile("iconditioner.vcd");
    $dumpvars();
    pin=1; #200

    pin=0; #200

    pin=1; #30

    pin=0; #30

    pin=1; #50

    #100 $finish;
    end
    
endmodule
