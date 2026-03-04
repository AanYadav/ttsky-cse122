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
        $display("Begin simulation.");
        for (int i = 0; i < 16; i++) begin
            ui_in = 8'(i);
            #10;
            // A=uo[0], B=uo[1], ..., G=uo[6]
            case (ui_in[3:0])
                4'h0: assert ({uo_out[0],uo_out[1],uo_out[2],uo_out[3],uo_out[4],uo_out[5],uo_out[6]} == 7'b1111110) else $error("Fail 0");
                4'h1: assert ({uo_out[0],uo_out[1],uo_out[2],uo_out[3],uo_out[4],uo_out[5],uo_out[6]} == 7'b0110000) else $error("Fail 1");
                4'h2: assert ({uo_out[0],uo_out[1],uo_out[2],uo_out[3],uo_out[4],uo_out[5],uo_out[6]} == 7'b1101101) else $error("Fail 2");
                4'h3: assert ({uo_out[0],uo_out[1],uo_out[2],uo_out[3],uo_out[4],uo_out[5],uo_out[6]} == 7'b1111001) else $error("Fail 3");
                4'h4: assert ({uo_out[0],uo_out[1],uo_out[2],uo_out[3],uo_out[4],uo_out[5],uo_out[6]} == 7'b0110011) else $error("Fail 4");
                4'h5: assert ({uo_out[0],uo_out[1],uo_out[2],uo_out[3],uo_out[4],uo_out[5],uo_out[6]} == 7'b1011011) else $error("Fail 5");
                4'h6: assert ({uo_out[0],uo_out[1],uo_out[2],uo_out[3],uo_out[4],uo_out[5],uo_out[6]} == 7'b1011111) else $error("Fail 6");
                4'h7: assert ({uo_out[0],uo_out[1],uo_out[2],uo_out[3],uo_out[4],uo_out[5],uo_out[6]} == 7'b1110000) else $error("Fail 7");
                4'h8: assert ({uo_out[0],uo_out[1],uo_out[2],uo_out[3],uo_out[4],uo_out[5],uo_out[6]} == 7'b1111111) else $error("Fail 8");
                4'h9: assert ({uo_out[0],uo_out[1],uo_out[2],uo_out[3],uo_out[4],uo_out[5],uo_out[6]} == 7'b1111011) else $error("Fail 9");
                4'ha: assert ({uo_out[0],uo_out[1],uo_out[2],uo_out[3],uo_out[4],uo_out[5],uo_out[6]} == 7'b1110111) else $error("Fail a");
                4'hb: assert ({uo_out[0],uo_out[1],uo_out[2],uo_out[3],uo_out[4],uo_out[5],uo_out[6]} == 7'b0011111) else $error("Fail b");
                4'hc: assert ({uo_out[0],uo_out[1],uo_out[2],uo_out[3],uo_out[4],uo_out[5],uo_out[6]} == 7'b1001110) else $error("Fail c");
                4'hd: assert ({uo_out[0],uo_out[1],uo_out[2],uo_out[3],uo_out[4],uo_out[5],uo_out[6]} == 7'b0111101) else $error("Fail d");
                4'he: assert ({uo_out[0],uo_out[1],uo_out[2],uo_out[3],uo_out[4],uo_out[5],uo_out[6]} == 7'b1001111) else $error("Fail e");
                4'hf: assert ({uo_out[0],uo_out[1],uo_out[2],uo_out[3],uo_out[4],uo_out[5],uo_out[6]} == 7'b1000111) else $error("Fail f");
            endcase
        end
        $display("End simulation.");
        $finish;
    end
endmodule
