//------------------------------------------------------------------------
// SPI Memory test bench
//------------------------------------------------------------------------

`include "spimemory.v"

module testspimemory();
	reg           clk;        // FPGA clock
    reg           sclk_pin;   // SPI clock
    reg           cs_pin;     // SPI chip select
    wire          miso_pin;   // SPI master in slave out, has memory address
    reg           mosi_pin;   // SPI master out slave in, for reading
    wire [3:0]    leds;       // LEDs for debugging

    spiMemory dut(.clk(clk),
    				.sclk_pin(sclk_pin),
    				.cs_pin(cs_pin),
    				.miso_pin(miso_pin),
    				.mosi_pin(mosi_pin),
    				.leds(leds)
    			);

    // generating the clock
    initial begin
    	sclk_pin = 0;
		clk=0;
	end
	always #10 clk=!clk;    // 50MHz Clock
	always #100 sclk_pin=!sclk_pin;

	initial begin
		$dumpfile("spimemorytest.vcd");
	    $dumpvars();
	    
	    cs_pin = 1; mosi_pin = 1; #500 

	    cs_pin = 0; mosi_pin = 0; #3000

	    cs_pin = 1; mosi_pin = 1; #200



	    #100 $finish;
	end

endmodule

