// src/project.v  (or tt_um_hex_decoder.v)
`default_nettype none

module tt_um_hex_decoder (
    input  wire [7:0] ui_in,
    output wire [7:0] uo_out,
    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,
    input  wire       ena,
    input  wire       clk,
    input  wire       rst_n
);

    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;

    wire A, B, C, D, E, F, G;

    hex7seg decoder (
        .d3(ui_in[3]),
        .d2(ui_in[2]),
        .d1(ui_in[1]),
        .d0(ui_in[0]),
        .A(A), .B(B), .C(C), .D(D), .E(E), .F(F), .G(G)
    );
    
    assign uo_out = {1'b0, G, F, E, D, C, B, A};

endmodule

module hex7seg (
    input  logic d3, d2, d1, d0,
    output logic A, B, C, D, E, F, G
);
    assign A = !((~d3&~d2&~d1&d0)|(~d3&d2&~d1&~d0)|(d3&~d2&d1&d0)|(d3&d2&~d1&d0));
    assign B = !((~d3&d2&~d1&d0)|(~d3&d2&d1&~d0)|(d3&~d2&d1&d0)|(d3&d2&~d1&~d0)
                |(d3&d2&d1&~d0)|(d3&d2&d1&d0));
    assign C = !((~d3&~d2&d1&~d0)|(d3&d2&~d1&~d0)|(d3&d2&d1&~d0)|(d3&d2&d1&d0));
    assign D = !((~d3&~d2&~d1&d0)|(~d3&d2&~d1&~d0)|(~d3&d2&d1&d0)
                |(d3&~d2&d1&~d0)|(d3&d2&d1&d0));
    assign E = !((~d3&~d2&~d1&d0)|(~d3&~d2&d1&d0)|(~d3&d2&~d1&~d0)|(~d3&d2&~d1&d0)
                |(~d3&d2&d1&d0)|(d3&~d2&~d1&d0));
    assign F = !((~d3&~d2&~d1&d0)|(~d3&~d2&d1&~d0)|(~d3&~d2&d1&d0)|(~d3&d2&d1&d0)|(d3&d2&~d1&d0));
    assign G = !((~d3&~d2&~d1&~d0)|(~d3&~d2&~d1&d0)|(~d3&d2&d1&d0)|(d3&d2&~d1&~d0));
endmodule
