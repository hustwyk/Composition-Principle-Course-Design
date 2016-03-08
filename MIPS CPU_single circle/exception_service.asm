# block interruptions
addi $k0,$zero,1
mtc0 $k0,$30

addi $gp,$zero,64 # base pointer
add $fp,$gp,$sp

# protect environment
sw $s0,($fp)
addi $sp,$sp,4
addi $fp,$fp,4
sw $s2,($fp)
addi $sp,$sp,4
addi $fp,$fp,4
sw $s3,($fp)
addi $sp,$sp,4
addi $fp,$fp,4
sw $s6,($fp)
addi $sp,$sp,4
addi $fp,$fp,4
sw $t0,($fp)
addi $sp,$sp,4
addi $fp,$fp,4
sw $t1,($fp)
addi $sp,$sp,4
addi $fp,$fp,4
sw $a0,($fp)
addi $sp,$sp,4
addi $fp,$fp,4
sw $v0,($fp)
addi $sp,$sp,4
addi $fp,$fp,4

# read EPC value to t1
mfc0 $t1,$31
sw $t1,($fp)
addi $fp,$fp,4
addi $sp,$sp,4

# unblock interruptions
addi $k0,$zero,0
mtc0 $k0,$30

test_program:
#############################################################
#走马灯测试,测试addi,andi,sll,srl,sra,or,ori,nor,syscall  LED按走马灯方式来回显示数据
#############################################################

addi $s0,$zero,1 
sll $s3, $s0, 31      # $s3=0x80000000
sra $s3, $s3, 31      # $s3=0xFFFFFFFF   
addu $s0,$zero,$zero   # $s0=0         
addi $s2,$zero,12 

addiu $s6,$0,3  #走马灯计数
zmd_loop:

addiu $s0, $s0, 1    #计算下一个走马灯的数据
andi $s0, $s0, 15  

#######################################
addi $t0,$0,8    
addi $t1,$0,1
left:

sll $s3, $s3, 4   #走马灯左移
or $s3, $s3, $s0

add    $a0,$0,$s3       # display $s3
addi   $v0,$0,34         # system call for LED display 
syscall                 # display 

sub $t0,$t0,$t1
bne $t0,$0,left
#######################################

addi $s0, $s0, 1   #计算下一个走马灯的数据
addi $t8,$0,15
and $s0, $s0, $t8
sll $s0, $s0, 28     

addi $t0,$0,8
addi $t1,$0,1

zmd_right:

srl $s3, $s3, 4  #走马灯右移
or $s3, $s3, $s0

addu    $a0,$0,$s3       # display $s3
addi   $v0,$0,34         # system call for LED display 
syscall                 # display 

sub $t0,$t0,$t1
bne $t0,$0,zmd_right
srl $s0, $s0, 28  
#######################################

sub $s6,$s6,$t1
beq $s6,$0, exit
j zmd_loop

exit:

add $t0,$0,$0
nor $t0,$t0,$t0      #test nor  ori
sll $t0,$t0,16
ori $t0,$t0,0xffff

addu   $a0,$0,$t0       # display $t0
addi   $v0,$0,34         # system call for LED display 
syscall                 # display 

end_of_test_program:

# block interruptions
addi $k0,$zero,1
mtc0 $k0,$30

# restore EPC value to t1
addi $fp,$fp,-4
addi $sp,$sp,-4
lw $t1,($fp)
mtc0 $t1,$31

# restore environment
addi $fp,$fp,-4
addi $sp,$sp,-4
lw $v0,($fp)
addi $fp,$fp,-4
addi $sp,$sp,-4
lw $a0,($fp)
addi $fp,$fp,-4
addi $sp,$sp,-4
lw $t1,($fp)
addi $fp,$fp,-4
addi $sp,$sp,-4
lw $t0,($fp)
addi $fp,$fp,-4
addi $sp,$sp,-4
lw $s6,($fp)
addi $fp,$fp,-4
addi $sp,$sp,-4
lw $s3,($fp)
addi $fp,$fp,-4
addi $sp,$sp,-4
lw $s2,($fp)
addi $fp,$fp,-4
addi $sp,$sp,-4
lw $s0,($fp)

# unblock interruptions
addi $k0,$zero,0
mtc0 $k0,$30

eret










