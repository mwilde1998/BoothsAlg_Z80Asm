# BoothsAlg_Z80Asm
## Description:
A simple assembly program for a Z80 processor that performs Booth's Algorithm on two 8-bit numbers and gives a 16-bit result.

Tested with WinAPE Amstrad CPC Emulator. WinAPE is useful, since it includes a basic editor, assembler, and debugger.

The program is pretty basic and does not have any form of input or output with the user. The input must be hardcoded into the assembly program, and the output must be read from the registers.

**To run the program:**
1. Open WinAPE, select "Assembler" in the taskbar, and select "Show Assembler" (F3)
2. Towards the top of the program, under "Symbol Definitions", there are two constants, the multiplicands. Change these to whatever two numbers you wish to multiply. Keep in mind that you're limited to 8 bits in 2's complement notation, so a minimum of -128 and a maximum of 127. 
3. Insert a breakpoint at the final line with the "nop" instruction. This can be done by clicking on the left side of the window next to the instruction.
4. In the asssembler, open the assembly file you wish to run. Select "Assemble" in the tasbkar, and select "Assemble" to assemble the program for the Z80 and emulator.
5. The program was assembled and placed into memory location &8000. To run the program, type "Call &8000". If the breakpoint was placed, the debugger will open, and the results of the multiplication can be seen in hexadecimal format in the HL register pair.