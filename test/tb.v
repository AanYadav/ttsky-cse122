`default_nettype none
`timescale 1ns / 1ps

module tb;
    logic [7:0] ui_in;
    wire  [7:0] uo_out;
    logic [7:0] uio_in;
    wire  [7:0] uio_out;
    wire  [7:0] uio_oe;
    logic        ena, clk, rst_n;

    tt_um_hex_decoder dut (
        .ui_in(ui_in), .uo_out(uo_out),
        .uio_in(uio_in), .uio_out(uio_out), .uio_oe(uio_oe),
        .ena(ena), .clk(clk), .rst_n(rst_n)
    );

    initial begin
        $dumpfile("dump.fst");
        $dumpvars(0, tb);
        ena = 1; clk = 0; rst_n = 1; uio_in = 0; ui_in = 0;
    end

    always #5 clk = ~clk;

endmodule
