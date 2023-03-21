.data
argument: .word 4
str: .string "th number in the Fibonacci sequence is "

.text
main:
    lw a0, argument		#1
    mv a1, a0			#2
    li s0, 1			#3
    jal ra, fibonacci	#4
    jal ra, print		#75
    li a7, 10			#87
    ecall				#88

fibonacci:
    ble a0, s0, end		#5	11	17	23		29			40			51	57		63
    addi sp, sp, -24	#6	12	18									52
    sw ra, 0(sp)		#7	13	19									53
    sw a0, 8(sp)		#8	14	20									54
    addi a0, a0, -1		#9	15	21									55
    jal ra, fibonacci	#10	16	22									56
    sw a0, 12(sp)		#				25			36			47			59
    lw a0, 8(sp)		#				26			37			48			60
    addi a0, a0, -2		#				27			38			49			61
    jal ra, fibonacci	#				28			39			50			62
    lw t0, 12(sp)		#						31			42						65	70
    add a0, a0, t0		#						32			43						66	71
    lw ra, 0(sp)		#						33			44						67	72
    addi sp, sp, 24		#						34			45						68	73
    ret					#						35			46						69	74 
	
end:
    ret					#			24		30			41				58		64   
	
print:
    mv t0, a0			#76
    mv a0, a1			#77
    li a7, 1			#78
    ecall				#79
    la a0, str			#80
    li a7, 4			#81
    ecall				#82
    mv a0, t0			#83
    li a7, 1			#84
    ecall				#85
    ret					#86
    
    