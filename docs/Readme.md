# docs folder - Documentation

## What is this folder for?

This folder contains **written documentation** about your RISC processor - architecture details, instruction set, and usage guides.

## Do I need this now?

| Current Status | Do you need it? |
|----------------|-----------------|
| **Now** (design phase) | ⚠️ OPTIONAL - Helpful to document as you go |
| **Future** (sharing/presentation) | ✅ YES |

## What will go here

| File | Purpose | When to write |
|------|---------|---------------|
| `architecture.md` | How the processor works (block diagram, module descriptions) | During design |
| `instruction_set.md` | List of all instructions and their binary encoding | After designing Control Unit |
| `getting_started.md` | How to simulate and test the processor | After everything works |
| `simulation_guide.md` | Step-by-step simulation instructions | After testing |

## What to do NOW

**Option 1 (recommended):** Start documenting as you build

Create `architecture.md` and write down:
- What each module does
- How modules connect
- Block diagrams (you can draw and paste)

**Option 2:** Leave it empty and document later

## Simple template for `architecture.md` (copy this)

```markdown
# RISC Processor Architecture

## Modules Completed
- ALU (16-bit) - 8 operations
- Register File (16×16) - R0 hardwired to zero
- Program Counter (8-bit) - sequential, branch, jump

## Modules To Do
- Control Unit
- Instruction Memory
- Data Memory
- Top Level Connection

## Block Diagram
(Add picture here later)