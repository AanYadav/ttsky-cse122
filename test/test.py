# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles, Timer

EXPECTED = {
    0x0: 0b0111111,
    0x1: 0b0000110,
    0x2: 0b1011011,
    0x3: 0b1001111,
    0x4: 0b1100110,
    0x5: 0b1101101,
    0x6: 0b1111101,
    0x7: 0b0000111,
    0x8: 0b1111111,
    0x9: 0b1101111,
    0xa: 0b1110111,
    0xb: 0b1111100,
    0xc: 0b0111001,
    0xd: 0b1011110,
    0xe: 0b1111001,
    0xf: 0b1110001,
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
    await ClockCycles(dut.clk, 20)
    dut.rst_n.value = 1
    await ClockCycles(dut.clk, 10)

    dut._log.info("Test all 16 hex digits")
    for i in range(16):
        dut.ui_in.value = i
        await Timer(1, unit="us")

        val = dut.uo_out.value
        assert val.is_resolvable, \
            f"Input {i:#x}: output contains X/Z values: {val}"
        actual = int(val) & 0x7F
        expected = EXPECTED[i]
        assert actual == expected, \
            f"Input {i:#x}: expected {expected:#09b}, got {actual:#09b}"
        dut._log.info(f"  {i:#x} -> {actual:#09b} PASS")

    dut._log.info("All tests passed!")
