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
    wire [3:0]    leds;       // LEDs for debugging: 3 = miso_bufe, 2 = dm_we, 1 = addr_we, 0 = sr_we
    reg [15:0]   info_pin;

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
	always #5 clk=!clk;    // 50MHz Clock
	always #50 sclk_pin=!sclk_pin;

	initial begin
		$dumpfile("spimemorytest.vcd");
	    $dumpvars();

        // Establish timing	    
	    cs_pin = 1; mosi_pin = 1; #250 

        // One cyle is 1600 time units
	    //cs_pin = 0; mosi_pin = 0; #1600

        // Reset pin
	    //cs_pin = 1; mosi_pin = 1; #250

        // Start the process!
        info_pin = 16'b1111110011111111;
        cs_pin = 0; mosi_pin = info_pin[15]; # 100 // wait until cs goes low, then another 100 time steps

        mosi_pin = info_pin[14]; # 100
        if ((leds[1] != 1'b1) || (leds[3:2] != 2'b0) || (leds[0] != 1'b0)) $display("Test 1 Write failed: 0010 != %b",leds);
        mosi_pin = info_pin[13]; # 100
        mosi_pin = info_pin[12]; # 100
        mosi_pin = info_pin[11]; # 100
        mosi_pin = info_pin[10]; # 100
        mosi_pin = info_pin[9]; # 100

        // choose read or write
        mosi_pin = 0; # 100 // first write to the thing
        mosi_pin = info_pin[7]; # 100
        mosi_pin = info_pin[6]; # 100
        if ((leds[2] != 1'b1) || (leds[3] != 1'b0) || (leds[1:0] != 2'b0)) $display("Test 1 Write failed: 0100 != %b",leds);
        mosi_pin = info_pin[5]; # 100
        mosi_pin = info_pin[4]; # 100
        mosi_pin = info_pin[3]; # 100
        mosi_pin = info_pin[2]; # 100
        mosi_pin = info_pin[1]; # 100
        mosi_pin = info_pin[0]; # 100

        cs_pin = 1; # 500 // stop writing the thing

        cs_pin = 0; mosi_pin = info_pin[15]; # 100 // wait until cs goes low, then another 100 time steps

        mosi_pin = info_pin[14]; # 100
        if ((leds[1] != 1'b1) || (leds[3:2] != 2'b0) || (leds[0] != 1'b0)) $display("Test 1 Read failed: 0010 != %b",leds);
        mosi_pin = info_pin[13]; # 100
        mosi_pin = info_pin[12]; # 100
        mosi_pin = info_pin[11]; # 100
        mosi_pin = info_pin[10]; # 100
        mosi_pin = info_pin[9]; # 100

        // choose read or write
        mosi_pin = 1; # 100 // next read from the thing

        if ((miso_pin != info_pin[7])) $display("Test 1 failed at read element 1: %b", miso_pin); #100
        if ((leds[3] != 1'b1) || (leds[2:1] != 2'b0) || (leds[0] != 1'b1)) $display("Test 1 Read failed: 1001 != %b",leds);
        if ((miso_pin != info_pin[6])) $display("Test 1 failed at read element 2"); #100
        if ((leds[3] != 1'b1) || (leds[2:0] != 3'b0)) $display("Test 1 Read failed: 1000 != %b",leds);
        if ((miso_pin != info_pin[5])) $display("Test 1 failed at read element 3"); #100
        if ((miso_pin != info_pin[4])) $display("Test 1 failed at read element 4"); #100
        if ((miso_pin != info_pin[3])) $display("Test 1 failed at read element 5"); #100
        if ((miso_pin != info_pin[2])) $display("Test 1 failed at read element 6"); #100
        if ((miso_pin != info_pin[1])) $display("Test 1 failed at read element 7"); #100
        if ((miso_pin != info_pin[0])) $display("Test 1 failed at read element 8"); #100

        cs_pin = 1; mosi_pin = 1; #250

        // Start the process!
        info_pin = 16'b0101010000000000;
        cs_pin = 0; mosi_pin = info_pin[15]; # 100 // wait until cs goes low, then another 100 time steps

        mosi_pin = info_pin[14]; # 100
        if ((leds[1] != 1'b1) || (leds[3:2] != 2'b0) || (leds[0] != 1'b0)) $display("Test 2 Write failed: 0010 != %b",leds);
        mosi_pin = info_pin[13]; # 100
        mosi_pin = info_pin[12]; # 100
        mosi_pin = info_pin[11]; # 100
        mosi_pin = info_pin[10]; # 100
        mosi_pin = info_pin[9]; # 100

        // choose read or write
        mosi_pin = 0; # 100 // first write to the thing
        mosi_pin = info_pin[7]; # 100
        mosi_pin = info_pin[6]; # 100
        if ((leds[2] != 1'b1) || (leds[3] != 1'b0) || (leds[1:0] != 2'b0)) $display("Test 2 Write failed: 0100 != %b",leds);
        mosi_pin = info_pin[5]; # 100
        mosi_pin = info_pin[4]; # 100
        mosi_pin = info_pin[3]; # 100
        mosi_pin = info_pin[2]; # 100
        mosi_pin = info_pin[1]; # 100
        mosi_pin = info_pin[0]; # 100

        cs_pin = 1; # 500 // stop writing the thing

        cs_pin = 0;
        mosi_pin = info_pin[15]; # 100 // wait until cs goes low, then another 100 time steps

        mosi_pin = info_pin[14]; # 100
        if ((leds[1] != 1'b1) || (leds[3:2] != 2'b0) || (leds[0] != 1'b0)) $display("Test 2 Read failed: 0010 != %b",leds);
        mosi_pin = info_pin[13]; # 100
        mosi_pin = info_pin[12]; # 100
        mosi_pin = info_pin[11]; # 100
        mosi_pin = info_pin[10]; # 100
        mosi_pin = info_pin[9]; # 100

        // choose read or write
        mosi_pin = 1; # 100 // next read from the thing

        if ((miso_pin != info_pin[7])) $display("Test 2 failed at read element 1: %b", miso_pin); #100
        if ((leds[3] != 1'b1) || (leds[2:1] != 2'b0) || (leds[0] != 1'b1)) $display("Test 2 Read failed: 1001 != %b",leds);
        if ((miso_pin != info_pin[6])) $display("Test 2 failed at read element 2: %b", miso_pin); #100
        if ((leds[3] != 1'b1) || (leds[2:1] != 2'b0) || (leds[0] != 1'b0)) $display("Test 2 Read failed: 1000 != %b",leds);
        if ((miso_pin != info_pin[5])) $display("Test 2 failed at read element 3: %b", miso_pin); #100
        if ((miso_pin != info_pin[4])) $display("Test 2 failed at read element 4: %b", miso_pin); #100
        if ((miso_pin != info_pin[3])) $display("Test 2 failed at read element 5: %b", miso_pin); #100
        if ((miso_pin != info_pin[2])) $display("Test 2 failed at read element 6: %b", miso_pin); #100
        if ((miso_pin != info_pin[1])) $display("Test 2 failed at read element 7: %b", miso_pin); #100
        if ((miso_pin != info_pin[0])) $display("Test 2 failed at read element 8: %b", miso_pin); #100

        cs_pin = 1; mosi_pin = 1; #250

        // Start the process!
        info_pin = 16'b0101010010101010;
        cs_pin = 0;
        mosi_pin = info_pin[15]; # 100 // wait until cs goes low, then another 100 time steps

        mosi_pin = info_pin[14]; # 100
        if ((leds[1] != 1'b1) || (leds[3:2] != 2'b0) || (leds[0] != 1'b0)) $display("Test 3 Write failed: 0010 != %b",leds);
        mosi_pin = info_pin[13]; # 100
        mosi_pin = info_pin[12]; # 100
        mosi_pin = info_pin[11]; # 100
        mosi_pin = info_pin[10]; # 100
        mosi_pin = info_pin[9]; # 100

        // choose read or write
        mosi_pin = 0; # 100 // first write to the thing
        mosi_pin = info_pin[7]; # 100
        mosi_pin = info_pin[6]; # 100
        if ((leds[2] != 1'b1) || (leds[3] != 1'b0) || (leds[1:0] != 2'b0)) $display("Test 3 Write failed: 0100 != %b",leds);
        mosi_pin = info_pin[5]; # 100
        mosi_pin = info_pin[4]; # 100
        mosi_pin = info_pin[3]; # 100
        mosi_pin = info_pin[2]; # 100
        mosi_pin = info_pin[1]; # 100
        mosi_pin = info_pin[0]; # 100

        cs_pin = 1; # 500 // stop writing the thing

        cs_pin = 0;
        mosi_pin = info_pin[15]; # 100 // wait until cs goes low, then another 100 time steps

        mosi_pin = info_pin[14]; # 100
        if ((leds[1] != 1'b1) || (leds[3:2] != 2'b0) || (leds[0] != 1'b0)) $display("Test 3 Read failed: 0010 != %b",leds);
        mosi_pin = info_pin[13]; # 100
        mosi_pin = info_pin[12]; # 100
        mosi_pin = info_pin[11]; # 100
        mosi_pin = info_pin[10]; # 100
        mosi_pin = info_pin[9]; # 100

        // choose read or write
        mosi_pin = 1; # 100 // next read from the thing

        if ((miso_pin != info_pin[7])) $display("Test 3 failed at read element 1: %b", miso_pin); #100
        if ((leds[3] != 1'b1) || (leds[2:1] != 2'b0) || (leds[0] != 1'b1)) $display("Test 3 Read failed: 1001 != %b",leds);
        if ((miso_pin != info_pin[6])) $display("Test 3 failed at read element 2: %b", miso_pin); #100
        if ((leds[3] != 1'b1) || (leds[2:0] != 3'b0)) $display("Test 3 Read failed: 1000 != %b",leds);
        if ((miso_pin != info_pin[5])) $display("Test 3 failed at read element 3: %b", miso_pin); #100
        if ((miso_pin != info_pin[4])) $display("Test 3 failed at read element 4: %b", miso_pin); #100
        if ((miso_pin != info_pin[3])) $display("Test 3 failed at read element 5: %b", miso_pin); #100
        if ((miso_pin != info_pin[2])) $display("Test 3 failed at read element 6: %b", miso_pin); #100
        if ((miso_pin != info_pin[1])) $display("Test 3 failed at read element 7: %b", miso_pin); #100
        if ((miso_pin != info_pin[0])) $display("Test 3 failed at read element 8: %b", miso_pin); #100

	    #100 $finish;
	end

endmodule

