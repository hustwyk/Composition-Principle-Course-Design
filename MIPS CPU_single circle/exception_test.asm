# block interruptions
addi $k0,$zero,1
mtc0 $k0,$30 

addi $gp,$zero,64 # base pointer
add $fp,$gp,$sp
# protect environment
sw $s0,($fp)
addi $sp,$sp,4
addi $fp,$fp,4
 # read EPC value to t1
mfc0 $s0,$31
sw $s0,($fp)
addi $fp,$fp,4
addi $sp,$sp,4
# unblock interruptions
addi $k0,$zero,0
mtc0 $k0,$30
test_program:
addi $s0,$zero,2
sw $s0,($zero)
end_of_test_program:


# block interruptions
addi $k0,$zero,1
mtc0 $k0,$30
# restore EPC value to t1
addi $fp,$fp,-4
addi $sp,$sp,-4
lw $s0,($fp)
mtc0 $s0,$31
# restore environment
addi $fp,$fp,-4
addi $sp,$sp,-4
lw $s0,($fp)

# unblock interruptions
addi $k0,$zero,0
mtc0 $k0,$30

eret
