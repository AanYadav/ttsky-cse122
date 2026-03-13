`default_nettype none
`timescale 1ns / 1ps


module tb;
    reg [7:0] ui_in;
    wire [7:0] uo_out;
    reg [7:0] uio_in;
    wire [7:0] uio_out;
    wire [7:0] uio_oe;
    reg       ena, clk, rst_n;

    wire VPWR = 1'b1;
    wire VGND = 1'b0;

    tt_um_hex_decoder dut (
    `ifdef GL_TEST
        .VPWR(VPWR),    
        .VGND(VGND),
    `endif
        .ui_in  (ui_in),
        .uo_out (uo_out),
        .uio_in (uio_in),
        .uio_out(uio_out),
        .uio_oe (uio_oe),
        .ena    (ena),
        .clk    (clk),
        .rst_n  (rst_n)
    );

    initial begin
        $dumpfile("dump.fst");
        $dumpvars(0, tb);
        
        ena = 1;
        clk = 0;
        rst_n = 1;
        uio_in = 8'b0;
        ui_in = 8'b0;

        `ifdef GL_TEST
            force dut.VPWR = 1'b1;
            force dut.VGND = 1'b0;
        `endif
    end

    always #5 clk = ~clk;

endmodule
