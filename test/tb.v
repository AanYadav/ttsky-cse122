
`default_nettype none
`timescale 1ns / 1ps

module tb;

    // TinyTapeout Template Signals
    logic [7:0] ui_in;      // Dedicated inputs
    wire  [7:0] uo_out;     // Dedicated outputs
    logic [7:0] uio_in;     // IOs: Input path
    wire  [7:0] uio_out;    // IOs: Output path
    wire  [7:0] uio_oe;     // IOs: Enable path
    logic       ena;        // Design enable
    logic       clk;        // Clock
    logic       rst_n;      // Reset (active low)

    // Instantiate the TinyTapeout wrapper module
    tt_um_hex_decoder dut (
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
        // Setup waveform dumping for debugging
        $dumpfile("dump.fst");
        $dumpvars(0, tb);
        
        $display("Begin simulation.");

        // Initialize template signals
        ena = 1;
        clk = 0;
        rst_n = 1;
        uio_in = 8'b0;

        // Iterate through all 16 hex digits [cite: 34, 47]
        for (int i = 0; i < 16; i++) begin
            ui_in = 8'(i); // Sets ui_in[3:0] to the hex value
            #1;            // Wait for combinational logic to settle
        end

        $display("End simulation.");
        $finish;
    end

    // Self-checking logic [cite: 48]
    // uo_out[6:0] maps to segments {G, F, E, D, C, B, A}
    always @* begin
        unique case (ui_in[3:0])
            4'h0: assert (uo_out[6:0] == 7'b1111110) else $error("Wrong result for 0");
            4'h1: assert (uo_out[6:0] == 7'b0110000) else $error("Wrong result for 1");
            4'h2: assert (uo_out[6:0] == 7'b1101101) else $error("Wrong result for 2");
            4'h3: assert (uo_out[6:0] == 7'b1111001) else $error("Wrong result for 3");
            4'h4: assert (uo_out[6:0] == 7'b0110011) else $error("Wrong result for 4");
            4'h5: assert (uo_out[6:0] == 7'b1011011) else $error("Wrong result for 5");
            4'h6: assert (uo_out[6:0] == 7'b1011111) else $error("Wrong result for 6");
            4'h7: assert (uo_out[6:0] == 7'b1110000) else $error("Wrong result for 7");
            4'h8: assert (uo_out[6:0] == 7'b1111111) else $error("Wrong result for 8");
            4'h9: assert (uo_out[6:0] == 7'b1111011) else $error("Wrong result for 9");
            4'ha: assert (uo_out[6:0] == 7'b1110111) else $error("Wrong result for a");
            4'hb: assert (uo_out[6:0] == 7'b0011111) else $error("Wrong result for b");
            4'hc: assert (uo_out[6:0] == 7'b1001110) else $error("Wrong result for c");
            4'hd: assert (uo_out[6:0] == 7'b0111101) else $error("Wrong result for d");
            4'he: assert (uo_out[6:0] == 7'b1001111) else $error("Wrong result for e");
            4'hf: assert (uo_out[6:0] == 7'b1000111) else $error("Wrong result for f");
        endcase
    end

endmodule
