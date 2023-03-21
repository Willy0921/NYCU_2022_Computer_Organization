.data
argument: .word 7
str: .string "th number in the Fibonacci sequence is "

.text
main:
    lw a0, argument
    mv a1, a0
    li s0, 1
    jal ra, fibonacci
    jal ra, print
    li a7, 10
    ecall

fibonacci:
    ble a0, s0, end
    addi sp, sp, -24
    sw ra, 0(sp)
    sw a0, 8(sp)
    addi a0, a0, -1
    jal ra, fibonacci
    sw a0, 12(sp)
    lw a0, 8(sp)
    addi a0, a0, -2
    jal ra, fibonacci
    lw t0, 12(sp)
    add a0, a0, t0
    lw ra, 0(sp)
    addi sp, sp, 24
    ret
    
end:
    ret
    
print:
    mv t0, a0
    mv a0, a1
    li a7, 1
    ecall
    la a0, str
    li a7, 4
    ecall
    mv a0, t0
    li a7, 1
    ecall
    ret
    
    