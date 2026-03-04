`default_nettype none

module tt_um_hex_decoder (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path
    input  wire       ena,      // always 1 when the design is powered or selected
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;

    assign uo_out[7] = 1'b0;

    hex7seg core_logic (
        .d(ui_in[3:0]),
        .segments(uo_out[6:0])
    );

endmodule

module hex7seg(
    input  logic [3:0] d,
    output logic [6:0] segments
);
    
    always_comb begin
        case (d)
            4'h0: segments = 7'b0111111;
            4'h1: segments = 7'b0000110;
            4'h2: segments = 7'b1011011;
            4'h3: segments = 7'b1001111;
            4'h4: segments = 7'b1100110;
            4'h5: segments = 7'b1101101;
            4'h6: segments = 7'b1111101;
            4'h7: segments = 7'b0000111;
            4'h8: segments = 7'b1111111;
            4'h9: segments = 7'b1101111;
            4'ha: segments = 7'b1110111;
            4'hb: segments = 7'b1111100;
            4'hc: segments = 7'b0111001;
            4'hd: segments = 7'b1011110;
            4'he: segments = 7'b1111001;
            4'hf: segments = 7'b1110001;
            default: segments = 7'b0000000;
        endcase
    end
endmodule
