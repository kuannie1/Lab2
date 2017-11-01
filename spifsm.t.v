//------------------------------------------------------------------------
// SPI Finite State Machine test bench
//------------------------------------------------------------------------
`include "spifsm.v"


module testFsm();

    reg cs;
    reg clkpos;
    reg ReadWrite;
    wire miso;
    wire dm_we;
    wire addr_we;
    wire sr_we;
    
    spifsm dut(.cs(cs),
    			 .clkpos(clkpos),
			 .ReadWrite(ReadWrite),
			 .miso(miso),
			 .dm_we(dm_we),
             .addr_we(addr_we),
             .sr_we(sr_we));




    // Generate clock (50MHz)
    initial begin 
    cs=1;
    clkpos=0;
    end
    always #10 clkpos=!clkpos;    // 50MHz Clock
    
    initial begin
    $dumpfile("spifsm.vcd");
    $dumpvars();
    ReadWrite = 1; #40

    cs=0; #20
    if (!((miso == 0) && (dm_we == 0) && (addr_we == 1) && (sr_we == 0))) 
        $display("State 1 failed. miso: %b dm_we: %b addr_we: %b sr_we: %b", miso, dm_we, addr_we, sr_we); 
    #20
    if (!((miso == 0) && (dm_we == 0) && (addr_we == 1) && (sr_we == 0))) 
        $display("State 2 failed. miso: %b dm_we: %b addr_we: %b sr_we: %b", miso, dm_we, addr_we, sr_we); 
    #20
    if (!((miso == 0) && (dm_we == 0) && (addr_we == 1) && (sr_we == 0))) 
        $display("State 3 failed. miso: %b dm_we: %b addr_we: %b sr_we: %b", miso, dm_we, addr_we, sr_we); 
    #20
    if (!((miso == 0) && (dm_we == 0) && (addr_we == 1) && (sr_we == 0))) 
        $display("State 4 failed. miso: %b dm_we: %b addr_we: %b sr_we: %b", miso, dm_we, addr_we, sr_we); 
    #20
    if (!((miso == 0) && (dm_we == 0) && (addr_we == 1) && (sr_we == 0))) 
        $display("State 5 failed. miso: %b dm_we: %b addr_we: %b sr_we: %b", miso, dm_we, addr_we, sr_we); 
    #20
    if (!((miso == 0) && (dm_we == 0) && (addr_we == 1) && (sr_we == 0))) 
        $display("State 6 failed. miso: %b dm_we: %b addr_we: %b sr_we: %b", miso, dm_we, addr_we, sr_we); 
    #20
    if (!((miso == 0) && (dm_we == 0) && (addr_we == 1) && (sr_we == 0))) 
        $display("State 7 failed. miso: %b dm_we: %b addr_we: %b sr_we: %b", miso, dm_we, addr_we, sr_we); 
    #20

    #100 $finish;
    end
    
endmodule
