# Bubble Sort 

inicio:

addi $t0, $zero, 0

addi $s0, $zero, 30
addi $s1, $zero, 10

sw $s0, 0($t0)
sw $s1, 4($t0)

lw $t1, 0($t0)
lw $t2, 4($t0)

nop
nop

slt $t3, $t2, $t1

nop

beq $t3, $zero, fin

nop

sw $t2, 0($t0)
sw $t1, 4($t0)

fin:
nop
nop
nop
nop
nop