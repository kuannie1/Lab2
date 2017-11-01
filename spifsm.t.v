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

    //cs select high
    ReadWrite = 1;
    repeat(7) begin
    #20
        if (!((miso == 0) && (dm_we == 0) && (addr_we == 0) && (sr_we == 0))) 
            $display("State 1 failed. miso: %b dm_we: %b addr_we: %b sr_we: %b", miso, dm_we, addr_we, sr_we); 
    end

    //cs select low, readwrite = 1
    cs=0; 
    repeat(7) begin
    #20
        if (!((miso == 0) && (dm_we == 0) && (addr_we == 1) && (sr_we == 0))) 
            $display("State 2 failed. miso: %b dm_we: %b addr_we: %b sr_we: %b", miso, dm_we, addr_we, sr_we); 
    end

    repeat(7) begin
    #20
        if (!((miso == 1) && (dm_we == 0) && (addr_we == 0) && (sr_we == 1))) 
            $display("State 3 failed. miso: %b dm_we: %b addr_we: %b sr_we: %b", miso, dm_we, addr_we, sr_we); 
    end

    //cs select high
    ReadWrite = 0;
    cs=1;
    repeat(7) begin
    #20
        if (!((miso == 0) && (dm_we == 0) && (addr_we == 0) && (sr_we == 0))) 
            $display("State 4 failed. miso: %b dm_we: %b addr_we: %b sr_we: %b", miso, dm_we, addr_we, sr_we); 
    end

    //cs select low, readwrite = 0
    cs=0; 
    repeat(7) begin
    #20
        if (!((miso == 0) && (dm_we == 0) && (addr_we == 1) && (sr_we == 0))) 
            $display("State 5 failed. miso: %b dm_we: %b addr_we: %b sr_we: %b", miso, dm_we, addr_we, sr_we); 
    end

    repeat(7) begin
    #20
        if (!((miso == 0) && (dm_we == 1) && (addr_we == 0) && (sr_we == 0))) 
            $display("State 6 failed. miso: %b dm_we: %b addr_we: %b sr_we: %b", miso, dm_we, addr_we, sr_we); 
    end

    #100 $finish;
    end
    
endmodule
