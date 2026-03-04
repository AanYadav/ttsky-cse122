/*
 * Copyright (c) 2024 Aan Yadav
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

// src/project.v
module tt_um_hex_decoder (
    input  wire [7:0] ui_in,    // Pins: d3=ui_in[3], d2=ui_in[2], d1=ui_in[1], d0=ui_in[0]
    output wire [7:0] uo_out,   // Pins: A=uo_out[0], B=uo_out[1] ... G=uo_out[6]
    input  wire [7:0] uio_in,   // IOs: Unused
    output wire [7:0] uio_out,  // IOs: Unused
    output wire [7:0] uio_oe,   // IOs: Unused
    input  wire       ena,      
    input  wire       clk,      
    input  wire       rst_n     
);

    // Assign unused outputs to zero
    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;
    assign uo_out[7] = 1'b0;

    // Instantiate your logic and map to TinyTapeout pins
    hex7seg core_logic (
        .d3(ui_in[3]), .d2(ui_in[2]), .d1(ui_in[1]), .d0(ui_in[0]),
        .A(uo_out[0]), .B(uo_out[1]), .C(uo_out[2]), .D(uo_out[3]),
        .E(uo_out[4]), .F(uo_out[5]), .G(uo_out[6])
    );

endmodule

module hex7seg(
    input  logic d3,d2,d1,d0,
    output logic A,B,C,D,E,F,G
);
    // Your provided logic
    assign A = !((~d3&~d2&~d1&d0)|(~d3&d2&~d1&~0)|(d3&~d2&d1&d0)|(d3&d2&~d1&d0));
    assign B = !((~d3&d2&~d1&d0)|(~d3&d2&d1&~d0)|(d3&~d2&d1&d0)|(d3&d2&~d1&~d0)|(d3&d2&d1&~d0)|(d3&d2&d1&d0));
    assign C = !((~d3&~d2&d1&~d0)|(d3&d2&~d1&~d0)|(d3&d2&d1&~d0)|(d3&d2&d1&d0));
    assign D = !((~d3&~d2&~d1&d0)|(~d3&d2&~d1&~d0)|(~d3&d2&d1&d0)|(d3&!d2&d1&!d0)|(d3&d2&d1&d0));
    assign E = !((~d3&~d2&~d1&d0)|(~d3&~d2&d1&d0)|(~d3&d2&~d1&~d0)|(~d3&d2&~d1&d0)|(~d3&d2&d1&d0)|(d3&~d2&~d1&d0));
    assign F = !((~d3&~d2&~d1&d0)|(~d3&~d2&d1&~d0)|(~d3&~d2&d1&d0)|(~d3&d2&d1&d0)|(d3&d2&~d1&d0));
    assign G = !((~d3&~d2&~d1&~d0)|(~d3&~d2&~d1&d0)|(~d3&d2&d1&d0)|(d3&d2&~d1&~d0));
endmodule
