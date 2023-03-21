.data
size: .word 5
arr: .word 5, 3, 6, 7, 31
space: .string " "
str1: .string "Array  \n"
str2: .string "\nSorted  \n"

.text
main:
    la s0, arr						
    lw a1, size
    la a0, str1		    
    li a7, 4						
    ecall									
    jal ra, print_array		
    jal ra, bbsort_oloop
    la a0, str2		
    li a7, 4						
    ecall									
    jal ra, print_array			
    li a7, 10						
    ecall	
    											
bbsort_oloop:
    addi t0, t0, 1			
    mv t1, t0 					
    blt t0, a1, bbsort_iloop
    ret	
    
bbsort_iloop:
    addi t1 t1 -1					
    blt t1, zero, bbsort_oloop
    slli t2, t1, 2					
    add t3, s0, t2					
    lw t4, 0(t3)					
    lw t5, 4(t3)					
    bgt t4, t5, swap				
    j bbsort_iloop		
    		
swap:
    sw t5 0(t3)						
    sw t4 4(t3)						
    j bbsort_iloop	
    														
print_array:
    lw a0, 0(s0)				
    li a7, 1					
    ecall						
    la a0, space				
    li a7, 4					
    ecall						
    lw a0, 4(s0)				
    li a7, 1					
    ecall						
    la a0, space					
    li a7, 4					
    ecall							
    lw a0, 8(s0)				
    li a7, 1					
    ecall						
    la a0, space			
    li a7, 4						
    ecall							
    lw a0, 12(s0)					
    li a7, 1						
    ecall
    la a0, space			
    li a7, 4						
    ecall							
    lw a0, 16(s0)					
    li a7, 1						
    ecall													
    ret								