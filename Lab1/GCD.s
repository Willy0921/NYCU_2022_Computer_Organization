.data
N1: .word 99
N2: .word 63
str1: .string "GCD value of " 
str2: .string " and "
str3: .string " is "

.text
main:
    lw a0, N1
    lw a1, N2
    mv a2, a0
    mv a3, a1
    jal ra, gcd
    jal ra, print
    li a7, 10
    ecall
    
gcd:
    beq a1, zero, end
    addi sp, sp, -16
    sw ra, 0(sp)
    sw a1, 8(sp)
    rem a1, a0, a1
    lw a0, 8(sp)
    jal ra, gcd
    lw ra, 0(sp)
    addi sp, sp, 16
    ret
end:
    ret
print:
    mv t0, a0
    la a0, str1
    li a7, 4
    ecall
    mv a0, a2
    li a7, 1
    ecall
    la a0, str2
    li a7, 4
    ecall
    mv a0, a3
    li a7, 1
    ecall
    la a0, str3
    li a7, 4
    ecall
    mv a0, t0
    li a7, 1
    ecall
    ret