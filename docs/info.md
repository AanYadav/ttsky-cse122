<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->


## How it works

This project implements a combinational hex to 7-segment display decoder. It takes a 4-bit binary input representing a hexadecimal digit (0–F) and outputs the corresponding 7-segment display encoding. where each bit controls one segment (A–G). The logic is implemented using Boolean sum-of-products expressions.

## How to test

Set `ui_in[3:0]` to any value from 0x0 to 0xF and observe `uo_out[6:0]`. Each output should match the standard 7-segment encoding for the corresponding hex digit. The testbench tests all 16 possible inputs and checks that the output matches the expected pattern for each digit.

## External hardware

A 7-segment display connected to `uo[6:0]`.

## GenAI Use

ChatGPT was used to help write `test.py`. The Verilog design (`project.v`) and testbench structure (`tb.v`) were from CSE100
