//--------------------------------------------------------------------------------
//  Wrapper for Lab 0: Full Adder using additional Pmod I/Os
// 
//  Rationale: 
//     The ZYBO board has 4 buttons, 4 switches, and 4 LEDs. But if we want to
//     show the results of a 4-bit add operation, we will need at least 6 LEDs!
//
//     This wrapper module assumes the use of the Pmod 8LD LED module and the
//     Pmod SWT switch module. In the following code the 8LD is plugged into JE
//     (bottom left) and the SWT is plugged into the top half of JA (right side),
//     but you can change that in code.
//
//  Your job:
//     Write FullAdder4bit with the proper port signature. It will be instantiated
//     by the lab0_wrapper_pmod module in this file, which interfaces with the
//     switches and LEDs for you.
//
//     Note: Be sure to un-comment the appropriate ports in your project XDC
//     constraint file: sw, ja_p, led, je
//
//     Note: Buttons, switches, and LEDs have the least-significant (0) position
//     labeled (usually on the right, except the SWT Pmod).      
//--------------------------------------------------------------------------------

`timescale 1ns / 1ps

`include "shiftregister.v"
`include "inputconditioner.v"


module midpoint(
    input           clk,
    input[3:0]      btn,
    input [3:0]     sw,
    output[3:0]     led,
    output[7:0]     je
    );

    wire serialDataOut;
    wire [7:0] parallelDataOut;
    wire conditioned1, PE2, NE0;

    assign je = parallelDataOut;
    assign led[0] = serialDataOut;
    assign  led[3:1] = 3'b0;


    inputconditioner ic0(.clk(clk),
                        .noisysignal(btn[0]),
                        .conditioned(),
                        .positiveedge(),
                        .negativeedge(NE0));
    inputconditioner ic1(.clk(clk),
                        .noisysignal(sw[0]),
                        .conditioned(conditioned1),
                        .positiveedge(),
                        .negativeedge());
    inputconditioner ic2(.clk(clk),
                        .noisysignal(sw[1]),
                        .conditioned(),
                        .positiveedge(PE2),
                        .negativeedge());

    shiftregister #(8) sr(.clk(clk), 
                       .peripheralClkEdge(PE2),
                       .parallelLoad(NE0), 
                       .parallelDataIn(8'hA5), 
                       .serialDataIn(conditioned1), 
                       .parallelDataOut(parallelDataOut), 
                       .serialDataOut(serialDataOut));
endmodule

