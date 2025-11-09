.data

.eqv N 5

A: .word 10, -20, 7, -8, 0
B: .word 2, -5, 3, 0, -1

C: .word 0, 0, 0, 0, 0

.text
.globl main

main:
	la s0, A
	la s1, B
	la s2, C
	li s3, N
	li s5, 0

loop:
	bge s5, s3, done

	slli s8, s5, 2

	add t0, s0, s8
	lw a0, 0(t0)

	add t1, s1, s8
	lw a1, 0(t1)

	mv s6, a0 
	mv s7, a1 

	call divide 

	add t0, s2, s8
	sw a0, 0(t0)

	mv s9, a0

	li a7, 1
	mv a0, s6
	ecall
	li a7, 11 
	li a0, ' '
	ecall
	li a7, 1
	mv a0, s7
	ecall
	li a7, 11
	li a0, ' '
	ecall
	li a7, 1 
	mv a0, s9
	ecall
	li a7, 11
	li a0, 10
	ecall

	addi s5, s5, 1
	j loop

done:
	addi a7, x0, 10
	ecall

divide:
	beq a1, x0, div_by_zero

	slt t2, a0, x0
	slt t3, a1, x0
	xor t2, t2, t3

	mv t0, a0 
	blt t0, x0, neg_a
	j after_abs_a

	neg_a:
		sub t0, x0, t0

	after_abs_a:
		mv t1, a1
		blt t1, x0, neg_b
		j after_abs_b

	neg_b:
		sub t1, x0, t1

	after_abs_b:
		bltu t0, t1, mag_small

		mv t6, t1
		mv t4, x0

	find_shift:
		srli a2, t0, 1 
		bltu a2, t6, shift_found
		slli t6, t6, 1
		addi t4, t4, 1
		j find_shift

	shift_found:
		mv t5, x0
		li t3, 1
		sll t3, t3, t4

	div_loop:
		bltu t0, t6, no_sub
		sub t0, t0, t6
		add t5, t5, t3 
		no_sub:
			srli t6, t6, 1 
			srli t3, t3, 1 
			bne t3, x0, div_loop

		mv a0, t5 
		j apply_sign

	mag_small:
		mv a0, x0

	apply_sign:
		beq t2, x0, div_ret
		sub a0, x0, a0 
		div_ret:
			ret

	div_by_zero:
		li a0, 0
		ret