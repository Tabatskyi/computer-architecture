.text
.globl main

main:
    addi t0, x0, 0x100 
    addi t1, x0, 0x104
    
    addi a0, x0, 5
    slli a0, a0, 1 
    addi a0, a0, 1 
    
    addi a1, x0, 3
    slli a1, a1, 9
    or a0, a0, a1
    
    addi a1, x0, 4
    slli a1, a1, 17
    or a0, a0, a1
    
    addi a1, x0, 2
    slli a1, a1, 25
    or a0, a0, a1 
    
    sw a0, 0(t0)
    
wait_config1_run1:
    lw a2, 0(t1)
    andi a2, a2, 1
    beq a2, x0, wait_config1_run1  
    
    andi a0, a0, -2
    sw a0, 0(t0)
    
    addi s0, x0, 10  # delay
delay1_1:
    addi s0, s0, -1
    bne s0, x0, delay1_1
    
    ori a0, a0, 1
    sw a0, 0(t0)
    
wait_config1_run2:
    lw a2, 0(t1)
    andi a2, a2, 1
    beq a2, x0, wait_config1_run2
    
    andi a0, a0, -2
    sw a0, 0(t0)
    
    addi s0, x0, 10
delay1_2:
    addi s0, s0, -1
    bne s0, x0, delay1_2
    
    addi a0, x0, 10
    slli a0, a0, 1
    addi a0, a0, 1
    
    addi a1, x0, 5
    slli a1, a1, 9
    or a0, a0, a1
    
    addi a1, x0, 8
    slli a1, a1, 17
    or a0, a0, a1
    
    addi a1, x0, 6
    slli a1, a1, 25
    or a0, a0, a1
    
    sw a0, 0(t0)
    
wait_config2_run1:
    lw a2, 0(t1)
    andi a2, a2, 1
    beq a2, x0, wait_config2_run1
    
    andi a0, a0, -2
    sw a0, 0(t0)
    
    addi s0, x0, 10
delay2_1:
    addi s0, s0, -1
    bne s0, x0, delay2_1
    
    ori a0, a0, 1
    sw a0, 0(t0)
    
wait_config2_run2:
    lw a2, 0(t1)
    andi a2, a2, 1
    beq a2, x0, wait_config2_run2
    
    andi a0, a0, -2
    sw a0, 0(t0)
    
    addi s0, x0, 10
delay2_2:
    addi s0, s0, -1
    bne s0, x0, delay2_2
    
    ori a0, a0, 1
    sw a0, 0(t0)
    
wait_config2_run3:
    lw a2, 0(t1)
    andi a2, a2, 1
    beq a2, x0, wait_config2_run3
    
    andi a0, a0, -2
    sw a0, 0(t0)
    
    addi s0, x0, 10
delay2_3:
    addi s0, s0, -1
    bne s0, x0, delay2_3
    
    addi a0, x0, 15
    slli a0, a0, 1
    addi a0, a0, 1
    
    addi a1, x0, 10
    slli a1, a1, 9
    or a0, a0, a1
    
    addi a1, x0, 12
    slli a1, a1, 17
    or a0, a0, a1
    
    addi a1, x0, 8
    slli a1, a1, 25
    or a0, a0, a1
    
    sw a0, 0(t0)
    
wait_config3_run1:
    lw a2, 0(t1)
    andi a2, a2, 1
    beq a2, x0, wait_config3_run1
    
    andi a0, a0, -2
    sw a0, 0(t0)
    
    addi s0, x0, 10
delay3_1:
    addi s0, s0, -1
    bne s0, x0, delay3_1
    
    ori a0, a0, 1
    sw a0, 0(t0)
    
wait_config3_run2:
    lw a2, 0(t1)
    andi a2, a2, 1
    beq a2, x0, wait_config3_run2
    
    andi a0, a0, -2
    sw a0, 0(t0)
    
    addi s0, x0, 10
delay3_2:
    addi s0, s0, -1
    bne s0, x0, delay3_2
    
    ori a0, a0, 1
    sw a0, 0(t0)
    
wait_config3_run3:
    lw a2, 0(t1)
    andi a2, a2, 1
    beq a2, x0, wait_config3_run3
    
    andi a0, a0, -2
    sw a0, 0(t0)
    
    addi s0, x0, 10
delay3_3:
    addi s0, s0, -1
    bne s0, x0, delay3_3
    
    ori a0, a0, 1
    sw a0, 0(t0)
    
wait_config3_run4:
    lw a2, 0(t1)
    andi a2, a2, 1
    beq a2, x0, wait_config3_run4
    
    andi a0, a0, -2
    sw a0, 0(t0)
done:
    addi t2, x0, 0x80
    addi t3, x0, 0x55
    sw t3, 0(t2)
    
loop:
    jal x0, loop