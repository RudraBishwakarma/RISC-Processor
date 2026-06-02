# synth folder - Synthesis Files

## What is this folder for?

This folder will contain files for **FPGA synthesis** - converting VHDL code into hardware that can be programmed onto an FPGA chip.

## Do I need this now?

| Current Status | Do you need it? |
|----------------|-----------------|
| **Now** (design phase) | ❌ NO - Focus on simulation first |
| **Future** (FPGA implementation) | ✅ YES |

## What will go here (future work)

| File | Purpose |
|------|---------|
| `constraints.xdc` | Timing constraints for Xilinx FPGA |
| `synth.tcl` | Automated synthesis script |
| `implementation.tcl` | Automated place & route script |

## What to do NOW

**NOTHING.** You are still in the design and simulation phase.

Complete these first:
1. ✅ ALU module
2. ✅ Register File module  
3. ✅ Program Counter module
4. ⏳ Control Unit (not done yet)
5. ⏳ Complete processor integration (not done yet)
6. ⏳ Test with programs (not done yet)

## What to do in FUTURE (after processor is working)

1. Select an FPGA board (e.g., Basys 3, Arty, Nexys)
2. Create `constraints.xdc` file with pin assignments
3. Add timing constraints (clock frequency)
4. Run synthesis in Vivado
5. Generate bitstream
6. Program the FPGA

## Current Status

⏳ **Not started** - This folder is reserved for FPGA implementation phase.

## When to come back to this folder

Come back AFTER:
- Your processor simulates correctly
- You have tested real programs (loops, addition, etc.)
- You have an FPGA board
- You want to run your processor on real hardware