# sim folder - Simulation Scripts

## What is this folder for?

This folder contains **automation scripts** for people who use **GHDL** or **ModelSim** (command-line simulators).

## Do I need this?

| If you use... | Do you need this folder? |
|---------------|--------------------------|
| **Vivado** (with GUI) | ❌ NO - Ignore this folder completely |
| **GHDL** (command line) | ✅ YES |
| **ModelSim** (command line) | ✅ YES |

## What's inside (planned for future)

| File | Purpose |
|------|---------|
| `compile_ghdl.sh` | Run all tests with GHDL |
| `compile_modelsim.do` | Run all tests with ModelSim |
| `run_all_tests.sh` | Master script - runs everything |

## What to do NOW

**Since you use Vivado, you do NOT need to do anything with this folder.**

Just leave it empty or delete it. You will simulate directly inside Vivado.

## What to do in FUTURE (if you switch to GHDL/ModelSim)

1. Install GHDL or ModelSim
2. Create the script files listed above
3. Run `./sim/run_all_tests.sh` to test everything

## Current Status

⏳ **Not yet implemented** - This folder is reserved for future use if needed.
