;Author; Mason Wilde
;Class; CPTR380
;Final Project
;Description; Booth's Algorithm in Z80 Assembly

org &8000
	
;Symbol Definitions:
inputone equ -12		;The multiplicand
inputtwo equ 35		 	;The multiplier

;Register Map:
;A = Accumulator. Needed for bitwise and math operations
;B = Counter for the number of times shifted
;C = Pad bit register
;HL = The sixteen bit regiter pair that will hold our final result, and will hold the multiplicand
;D = Register for the multiplier
;E = Temporary hold for the LSB

setup:
	ld l, inputone 			;Load multiplicand into the lower 8 bits of HL
	ld d, inputtwo			;Load multiplier into DE
	
	ld h, 0				;Clear the upper 8 bits of HL
	
	scf				;Set the carry flag
	ccf				;Complement the carry flag to clear it
	
	ld b, 8				;Load the counter with 8, the number of times we need to shift.
	
mainloop:
	ld a, l				;Load input one into A
	ld e, 0				;Clear E
	rl e				;Rotate the carry bit into E (this is done because the AND instruction clears the carry)
	and 1				;AND A with 1, masking the LSB
	sla a				;Shift A left one bit to make room for the carry bit (if there is one)
	add e				;Add the carry bit to A, so we can properly make comparisons to know what to do next

	cp 0				;Check for '00'
	jp z, shift			;If pad bit and LSB are equal, do nothing and go to shift section
	
	cp 3				;Check for '11'
	jp z, shift			;Again, if pad bit and LSB are equal, do nothing and shift
	
	cp 2				;Check for '10'
	jp z, subtract 			;If the check is true, go subtract
	
addition:
	ld a, 0				;Clear register A
	ld a, h				;Load the upper eight bits of HL into A
	add d 				;Add the multiplier to A
	ld h, a				;Load the result of the addition into H, which is where we're keeping our final result.
	jp shift
	
subtract:
	ld a, 0				;Clear register A
	ld a, h				;Load the upper eight bits of HL into A
	sub d 				;Subtract the multiplier in D from A
	ld h, a				;Load the result of the subtraction into H, which is where we're keeping our final result.
	
shift:
	sra h				;Shift-right-arithmetic the upper 8 bits of our result. If there was a 1 at position 0, it gets put in the carry flag.
	rr l				;Now, we rotate-right the lower 8 bits of HL. This shifts the bits down, and rotates that carried bit from H to the top of L.
	djnz mainloop			;(D)ecreases B and (J)umps if B is (N)ot (Z)ero. If we haven't done 8 shifts yet, we go back to the main loop.
	
	;If we do not jump, then we must have shifted 8 times. Proram is finished.
nop
