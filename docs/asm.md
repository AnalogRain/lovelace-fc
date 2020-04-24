# Harriet
## Assembly

- Numbers
 - Hexadecimal numbers must be prefixed with `$`
 - Binary numbers must be prefixed with `%`
 - Decimal numbers may optionally be prefixed with `!`
 - Literals must be prefixed with `#` otherwise it is an address
 	- `#` must come before `$`, `%`, or `!`
 - Examples
	- `#$10`
	 - 16 as a literal
	- `#%10`
	 - 2 as a literal
	- `#!10` or `#10`
	 - 10 as a literal
	- `$80`
	 - the address `128`
	- `$280`
	 - the address `640`

- Labels (note: not for mini-assembler)
 - Labels can be used in place of an address to jump to where the label was defined
 - Labels are prefixed with `:` and can be accessed anywhere in the file
 - Example
 ```
:label
JMP :label
```
- Flags
 - S
	- Sign
	- x0000000
	- Set by instructions with a numerical result if that result is negative.
 - C
	- Carry
	- 0x000000
	- Set by arithmetic instructions if a 1 bit in the 9th position was truncated.
 - I
	- Interrupt Disable
	- 00x00000
	- Only manually set. Controls whether or not interrupts happen.
 - O
	- Overflow
	- 000x0000
	- Set by arithmetic instructions if the sign of the result is affected by truncation.
 - G
	- Greater
	- 000000x0
	- Only set by the CMP instruction if the first operand is greater than the second.
 - Z
	- Zero
	- 0000000x
	- Set by instructions with a numerical result if that result is 0.
	- Also set by CMP if its two operands are equal.


- Comments (note: not for mini-assembler)
 - Anything following a `;` on a line is a comment and is not compiled

- CPU/ASM Notes
  - HarrietCPU is big-endian system
  - Instruction operands are written in form \<source> \<destination>
  - All operands are 8-bit except adr which is 16-bit

- Documentation Notes
  - reg means `r0`, `r1`, `r2`, or `r3`
  - acc means the accumulator
  - lit means 8-bit literal
  - flg means the flags register
  - sp means the stack poiner
  - adr means address
  - zp means zeropage address

- Instructions
 - NOP
	- No operation
	- Opcodes:
	 - 0x00
		- 1 Cycle
		- NOP
 - STR \<reg/acc/lit> \<adr/zp>
	- Stores data from source operand to destination address
	- Opcodes:
		- 0x09
			- 4 cycles
			- STR r0 \<adr>
		- 0x0A
			- 4 cycles
			- STR r1 \<adr>
		- 0x0B
			- 4 cycles
			- STR r2 \<adr>
		- 0x0C
			- 4 cycles
			- STR r3 \<adr>
		- 0x0D
			- 4 cycles
			- STR acc \<adr>
		- 0x0E
			- 4 cycles
			- STR lit \<adr>
		- 0x0F
			- 3 cycles
			- STR r0 \<zp>
		- 0x10
			- 3 cycles
			- STR r1 \<zp>
		- 0x11
			- 3 cycles
			- STR r2 \<zp>
		- 0x12
			- 3 cycles
			- STR r3 \<zp>
		- 0x13
			- 3 cycles
			- STR acc \<zp>
		- 0x14
			- 3 cycles
			- STR lit \<zp>
 - STRI \<reg/acc/lit> \<adr/zp>
	- Stores data from source operand to address pointed to by destination address
	- Opcodes:
		- 0x15
			- 6 cycles
			- STRI r0 \<adr>
		- 0x16
			- 6 cycles
			- STRI r1 \<adr>
		- 0x17
			- 6 cycles
			- STRI r2 \<adr>
		- 0x18
			- 6 cycles
			- STRI r3 \<adr>
		- 0x19
			- 6 cycles
			- STRI acc \<adr>
		- 0x1A
			- 5 cycles
			- STRI r0 \<zp>
		- 0x1B
			- 5 cycles
			- STRI r1 \<zp>
		- 0x1C
			- 5 cycles
			- STRI r2 \<zp>
		- 0x1D
			- 5 cycles
			- STRI r3 \<zp>
		- 0x1E
			- 5 cycles
			- STRI acc \<zp>
 - LOD \<lit/adr/zp> \<reg/acc>
	- Loads data from source operand into destination register
	- Opcodes:
		- 0x1F
			- 4 cycles
			- LOD \<adr> r0
		- 0x20
			- 4 cycles
			- LOD \<adr> r1
		- 0x21
			- 4 cycles
			- LOD \<adr> r2
		- 0x22
			- 4 cycles
			- LOD \<adr> r3
		- 0x23
			- 4 cycles
			- LOD \<adr> acc
		- 0x24
			- 3 cycles
			- LOD \<zp> r0
		- 0x25
			- 3 cycles
			- LOD \<zp> r1
		- 0x26
			- 3 cycles
			- LOD \<zp> r2
		- 0x27
			- 3 cycles
			- LOD \<zp> r3
		- 0x28
			- 3 cycles
			- LOD \<zp> acc
		- 0x29
			- 2 cycles
			- LOD \<lit> r0
		- 0x2A
			- 2 cycles
			- LOD \<lit> r1
		- 0x2B
			- 2 cycles
			- LOD \<lit> r2
		- 0x2C
			- 2 cycles
			- LOD \<lit> r3
		- 0x2D
			- 2 cycles
			- LOD \<lit> acc
 - LODI \<adr/zp> \<reg/acc>
	- Loads data from address pointed to by source address into destination register
	- Opcodes:
		- 0x2E
			- 6 cycles
			- LODI \<adr> r0
		- 0x2F
			- 6 cycles
			- LODI \<adr> r1
		- 0x30
			- 6 cycles
			- LODI \<adr> r2
		- 0x31
			- 6 cycles
			- LODI \<adr> r3
		- 0x32
			- 6 cycles
			- LODI \<adr> acc
		- 0x33
			- 5 cycles
			- LODI \<zp> r0
		- 0x34
			- 5 cycles
			- LODI \<zp> r1
		- 0x35
			- 5 cycles
			- LODI \<zp> r2
		- 0x36
			- 5 cycles
			- LODI \<zp> r3
		- 0x37
			- 5 cycles
			- LODI \<zp> acc
 - TRN \<reg/acc/sp/flg> \<reg/acc>
	- Copies value from source register to destination register
	- Opcodes:
		- 0x38
			- 1 cycle
			- TRN r0 r1
		- 0x39
			- 1 cycle
			- TRN r0 r2
		- 0x3A
			- 1 cycle
			- TRN r0 r3
		- 0x3B
			- 1 cycle
			- TRN r0 acc
		- 0x3C
			- 1 cycle
			- TRN r1 r0
		- 0x3D
			- 1 cycle
			- TRN r1 r2
		- 0x3E
			- 1 cycle
			- TRN r1 r3
		- 0x3F
			- 1 cycle
			- TRN r1 acc
		- 0x40
			- 1 cycle
			- TRN r2 r0
		- 0x41
			- 1 cycle
			- TRN r2 r1
		- 0x42
			- 1 cycle
			- TRN r2 r3
		- 0x43
			- 1 cycle
			- TRN r2 acc
		- 0x44
			- 1 cycle
			- TRN r3 r0
		- 0x45
			- 1 cycle
			- TRN r3 r1
		- 0x46
			- 1 cycle
			- TRN r3 r2
		- 0x47
			- 1 cycle
			- TRN r3 acc
		- 0x48
			- 1 cycle
			- TRN acc r0
		- 0x49
			- 1 cycle
			- TRN acc r1
		- 0x4A
			- 1 cycle
			- TRN acc r2
		- 0x4B
			- 1 cycle
			- TRN acc r3
		- 0x4C
			- 1 cycle
			- TRN sp r0
		- 0x4D
			- 1 cycle
			- TRN sp r1
		- 0x4E
			- 1 cycle
			- TRN sp r2
		- 0x4F
			- 1 cycle
			- TRN sp r3
		- 0x50
			- 1 cycle
			- TRN sp acc
		- 0x51
			- 1 cycle
			- TRN flg r0
		- 0x52
			- 1 cycle
			- TRN flg r1
		- 0x53
			- 1 cycle
			- TRN flg r2
		- 0x54
			- 1 cycle
			- TRN flg r3
		- 0x55
			- 1 cycle
			- TRN flg acc
 - ADD \<reg/acc/lit>
	- Adds the source to the accumulator, setting some flags.
	- Flags: S, Z, O, C
	- Opcodes:
		- 0x5e
			- 1 cycle
			- ADD r0
		- 0x5f
			- 1 cycle
			- ADD r1
		- 0x60
			- 1 cycle
			- ADD r2
		- 0x61
			- 1 cycle
			- ADD r3
		- 0x62
			- 1 cycle
			- ADD acc
		- 0x63
			- 2 cycles
			- ADD \<lit>
 - ADDC \<reg/acc/lit>
	- Adds the source and the carry flag to the accumulator, setting some flags.
	- Flags: S, Z, O, C
	- Opcodes:
		- 0x64
			- 1 cycle
			- ADDC r0
		- 0x65
			- 1 cycle
			- ADDC r1
		- 0x66
			- 1 cycle
			- ADDC r2
		- 0x67
			- 1 cycle
			- ADDC r3
		- 0x68
			- 1 cycle
			- ADDC acc
		- 0x69
			- 2 cycles
			- ADDC \<lit>
 - SUB \<reg/lit>
	- Subtracts the source to the accumulator, setting some flags.
	- Flags: S, Z, O, C
	- Opcodes:
		- 0x6a
			- 1 cycle
			- SUB r0
		- 0x6b
			- 1 cycle
			- SUB r1
		- 0x6c
			- 1 cycle
			- SUB r2
		- 0x6d
			- 1 cycle
			- SUB r3
		- 0x6e
			- 2 cycles
			- SUB \<lit>
 - SUBC \<reg/lit>
	- Subtracts the source and the carry flag to the accumulator, setting some flags.
	- Flags: S, Z, O, C
	- Opcodes:
		- 0x6f
			- 1 cycle
			- SUBC r0
		- 0x70
			- 1 cycle
			- SUBC r1
		- 0x71
			- 1 cycle
			- SUBC r2
		- 0x72
			- 1 cycle
			- SUBC r3
		- 0x73
			- 2 cycles
			- SUBC \<lit>
 - SHR \<reg/acc/lit>
	- Bitshifts the accumulator to the right, setting some flags.
	- Flags: S, Z
	- Opcodes:
		- 0x74
			- 1 cycle
			- SHR r0
		- 0x75
			- 1 cycle
			- SHR r1
		- 0x76
			- 1 cycle
			- SHR r2
		- 0x77
			- 1 cycle
			- SHR r3
		- 0x78
			- 1 cycle
			- SHR acc
		- 0x79
			- 2 cycles
			- SHR \<lit>
 - SHL \<reg/acc/lit>
	- Bitshifts the accumulator to the left, setting some flags.
	- Flags: S, Z
	- Opcodes:
		- 0x7a
			- 1 cycle
			- SHL r0
		- 0x7b
			- 1 cycle
			- SHL r1
		- 0x7c
			- 1 cycle
			- SHL r2
		- 0x7d
			- 1 cycle
			- SHL r3
		- 0x7e
			- 1 cycle
			- SHL acc
		- 0x7f
			- 2 cycles
			- SHL \<lit>
 - AND \<reg/lit>
	- Applies a bitwise and to the accumulator, setting some flags.
	- Flags: S, Z
	- Opcodes:
		- 0x80
			- 1 cycle
			- AND r0
		- 0x81
			- 1 cycle
			- AND r1
		- 0x82
			- 1 cycle
			- AND r2
		- 0x83
			- 1 cycle
			- AND r3
		- 0x84
			- 2 cycles
			- AND \<lit>
 - OR \<reg/lit>
	- Applies a bitwise or to the accumulator, setting some flags.
	- Flags: S, Z
	- Opcodes:
		- 0x85
			- 1 cycle
			- OR r0
		- 0x86
			- 1 cycle
			- OR r1
		- 0x87
			- 1 cycle
			- OR r2
		- 0x88
			- 1 cycle
			- OR r3
		- 0x89
			- 2 cycles
			- OR \<lit>
 - XOR \<reg/lit>
	- Applies a bitwise xor to the accumulator, setting some flags.
	- Flags: S, Z
	- Opcodes:
		- 0x8a
			- 1 cycle
			- XOR r0
		- 0x8b
			- 1 cycle
			- XOR r1
		- 0x8c
			- 1 cycle
			- XOR r2
		- 0x8d
			- 1 cycle
			- XOR r3
		- 0x8e
			- 2 cycles
			- XOR \<lit>
 - NOT
	- Applies a bitwise not to the accumulator, setting some flags.
	- Flags: S, Z
	- Opcodes:
		- 0x8f
			- 1 cycle
			- NOT
 - INC \<reg/acc>
	- Adds 1 to the argument, setting some flags.
	- Flags: S, Z, O, C
	- Opcodes:
		- 0x90
			- 1 cycle
			- INC r0
		- 0x91
			- 1 cycle
			- INC r1
		- 0x92
			- 1 cycle
			- INC r2
		- 0x93
			- 1 cycle
			- INC r3
		- 0x94
			- 1 cycle
			- INC acc
 - DEC \<reg/acc>
	- Subtracts 1 to the argument, setting some flags.
	- Flags: S, Z, O, C
	- Opcodes:
		- 0x95
			- 1 cycle
			- DEC r0
		- 0x96
			- 1 cycle
			- DEC r1
		- 0x97
			- 1 cycle
			- DEC r2
		- 0x98
			- 1 cycle
			- DEC r3
		- 0x99
			- 1 cycle
			- DEC acc
 - JSR \<adr>
	- Pushes the PC to the stack and jumps to the given address.
	- Opcodes:
		- 0xa2
			- 5 cycles
			- JSR \<adr>
 - RET
	- Pops an address off of the stack and jumps to it.
	- Opcodes:
		- 0xa3
			- 3 cycles
			- RET
 - RETI
	- Pops an address off of the stack and jumps to it. Also pops the flags register.
	- Opcodes:
		- 0xa4
			- 4 cycles
			- RETI
 - PSH \<reg/acc/lit>
	- Pushes a value to the stack. This increments the stack pointer.
	- Opcodes:
		- 0xad
			- 2 cycles
			- PUSH r0
		- 0xae
			- 2 cycles
			- PUSH r1
		- 0xaf
			- 2 cycles
			- PUSH r2
		- 0xb0
			- 2 cycles
			- PUSH r3
		- 0xb1
			- 2 cycles
			- PUSH acc
		- 0xb2
			- 3 cycles
			- PUSH \<lit>
 - POP \<reg/acc>
	- Pops a value from the stack. This decrements the stack pointer.
	- Opcodes:
		- 0xb3
			- 2 cycles
			- POP r0
		- 0xb4
			- 2 cycles
			- POP r1
		- 0xb5
			- 2 cycles
			- POP r2
		- 0xb6
			- 2 cycles
			- POP r3
		- 0xb7
			- 2 cycles
			- POP acc
 - DRP
	- Drops a value from the stack. This decrements the stack pointer.
	- Opcodes:
		- 0xb8
			- 1 cycle
			- DROP
 - CMP \<reg/acc> \<reg/acc/lit>
	- Compares two values. The Z flag is set if they are equal, and the G flag is set if the first is greater than the second.
	- Note that comparisons are unsigned.
	- Opcodes:
		- 0xc1
			- 1 cycle
			- CMP r0 r1
		- 0xc2
			- 1 cycle
			- CMP r0 r2
		- 0xc3
			- 1 cycle
			- CMP r0 r3
		- 0xc4
			- 1 cycle
			- CMP r0 acc
		- 0xc5
			- 1 cycle
			- CMP r1 r0
		- 0xc6
			- 1 cycle
			- CMP r1 r2
		- 0xc7
			- 1 cycle
			- CMP r1 r3
		- 0xc8
			- 1 cycle
			- CMP r1 acc
		- 0xc9
			- 1 cycle
			- CMP r2 r0
		- 0xca
			- 1 cycle
			- CMP r2 r1
		- 0xcb
			- 1 cycle
			- CMP r2 r3
		- 0xcc
			- 1 cycle
			- CMP r2 acc
		- 0xcd
			- 1 cycle
			- CMP r3 r0
		- 0xce
			- 1 cycle
			- CMP r3 r1
		- 0xcf
			- 1 cycle
			- CMP r3 r2
		- 0xd0
			- 1 cycle
			- CMP r3 acc
		- 0xd1
			- 1 cycle
			- CMP acc r0
		- 0xd2
			- 1 cycle
			- CMP acc r1
		- 0xd3
			- 1 cycle
			- CMP acc r2
		- 0xd4
			- 1 cycle
			- CMP acc r3
		- 0xd5
			- 2 cycles
			- CMP r0 \<lit>
		- 0xd6
			- 2 cycles
			- CMP r1 \<lit>
		- 0xd7
			- 2 cycles
			- CMP r2 \<lit>
		- 0xd8
			- 2 cycles
			- CMP r3 \<lit>
		- 0xd9
			- 2 cycles
			- CMP acc \<lit>
 - BRA \<flg> \<adr>
	- Acts like a JMP conditional on the flag being set.
	- Opcodes:
		- 0xda
			- 3 cycles if jump, 1 otherwise
			- BRA S
		- 0xdb
			- 3 cycles if jump, 1 otherwise
			- BRA C
		- 0xdc
			- 3 cycles if jump, 1 otherwise
			- BRA I
		- 0xdd
			- 3 cycles if jump, 1 otherwise
			- BRA O
		- 0xde
			- 3 cycles if jump, 1 otherwise
			- BRA G
		- 0xdf
			- 3 cycles if jump, 1 otherwise
			- BRA Z
 - BRAN \<flg> \<adr>
	- Acts like a JMP conditional on the flag being clear.
	- Opcodes:
		- 0xe0
			- 3 cycles if jump, 1 otherwise
			- BRAN S
		- 0xe1
			- 3 cycles if jump, 1 otherwise
			- BRAN C
		- 0xe2
			- 3 cycles if jump, 1 otherwise
			- BRAN I
		- 0xe3
			- 3 cycles if jump, 1 otherwise
			- BRAN O
		- 0xe4
			- 3 cycles if jump, 1 otherwise
			- BRAN G
		- 0xe5
			- 3 cycles if jump, 1 otherwise
			- BRAN Z
 - JMP \<adr>
	- Sets the program counter to the address.
	- Opcodes:
		- 0xe6
			- 3 cycles
			- JMP \<adr>
 - SET \<flg>
	- Sets a given flag.
	- Opcodes:
		- 0xef
			- 1 cycle
			- SET S
		- 0xf0
			- 1 cycle
			- SET C
		- 0xf1
			- 1 cycle
			- SET I
		- 0xf2
			- 1 cycle
			- SET O
		- 0xf3
			- 1 cycle
			- SET G
		- 0xf4
			- 1 cycle
			- SET Z
 - CLR \<flg>
	- Clears a given flag.
	- Opcodes:
		- 0xf5
			- 1 cycle
			- CLR S
		- 0xf6
			- 1 cycle
			- CLR C
		- 0xf7
			- 1 cycle
			- CLR I
		- 0xf8
			- 1 cycle
			- CLR O
		- 0xf9
			- 1 cycle
			- CLR G
		- 0xfa
			- 1 cycle
			- CLR Z