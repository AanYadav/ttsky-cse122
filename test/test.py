# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles, Timer

# {A,B,C,D,E,F,G} expected values, indexed 0-15
EXPECTED = {
    0x0: 0b1111110,
    0x1: 0b0110000,
    0x2: 0b1101101,
    0x3: 0b1111001,
    0x4: 0b0110011,
    0x5: 0b1011011,
    0x6: 0b1011111,
    0x7: 0b1110000,
    0x8: 0b1111111,
    0x9: 0b1111011,
    0xa: 0b1110111,
    0xb: 0b0011111,
    0xc: 0b1001110,
    0xd: 0b0111101,
    0xe: 0b1001111,
    0xf: 0b1000111,
}

@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")

    clock = Clock(dut.clk, 10, unit="us")
    cocotb.start_soon(clock.start())

    dut._log.info("Reset")
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1

    dut._log.info("Test all 16 hex digits")
    for i in range(16):
        dut.ui_in.value = i
        await Timer(1, units="us")  # combinational settle time

        actual = int(dut.uo_out.value) & 0x7F  # lower 7 bits = A-G
        expected = EXPECTED[i]
        assert actual == expected, \
            f"Input {i:#x}: expected uo_out[6:0]={expected:#09b}, got {actual:#09b}"
        dut._log.info(f"  {i:#x} -> {actual:#09b} PASS")

    dut._log.info("All tests passed!")
