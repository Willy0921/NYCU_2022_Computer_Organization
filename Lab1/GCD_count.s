.data
N1: .word 99
N2: .word 63
str1: .string "GCD value of " 
str2: .string " and "
str3: .string " is "

.text
main:
    lw a0, N1			#1	
    lw a1, N2			#2
    mv a2, a0			#3
    mv a3, a1			#4
    jal ra, gcd			#5
    jal ra, print		#48
    li a7, 10			#69
    ecall				#70
    
gcd:
    beq a1, zero, end	#6	13	20	27	34
    addi sp, sp, -16	#7	14	21	28
    sw ra, 0(sp)		#8	15	22	29
    sw a1, 8(sp)		#9	16	23	30
    rem a1, a0, a1		#10	17	24	31
    lw a0, 8(sp)		#11	18	25	32
    jal ra, gcd			#12	19	26	33
    lw ra, 0(sp)		#					36	39	42	45
    addi sp, sp, 16		#					37	40	43	46
    ret					#					38	41	44	47
end:
    ret					#				35
print:
    mv t0, a0			#49
    la a0, str1			#50
    li a7, 4			#51
    ecall				#52
    mv a0, a2			#53
    li a7, 1			#54
    ecall				#55
    la a0, str2			#56
    li a7, 4			#57
    ecall				#58
    mv a0, a3			#59
    li a7, 1			#60
    ecall				#61
    la a0, str3			#62
    li a7, 4			#63
    ecall				#64
    mv a0, t0			#65
    li a7, 1			#66
    ecall				#67
	ret					#68