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
sw $s4,($fp)
addi $sp,$sp,4
addi $fp,$fp,4
sw $s5,($fp)
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
#�ж���ʾ���򣬼�����Ʋ��ԣ�������1�ż�������1ѭ����λ����
#############################################################
.text

mfc0 $s6,$s6      #�жϺ�1,2,3   ��ͬ�ն˺���ʾֵ��һ��

addi $s4,$zero,5      #ѭ��������ʼֵ  
addi $s5,$zero,1       #�������ۼ�ֵ
###################################################################
#                �߼����ƣ�ÿ����λ4λ 
# ��ʾ����������ʾ0x00000001 0x00000010 0x0000100 0x00001000 ... 10000000 ����ѭ��20��
###################################################################
IntLoop:
add $s0,$zero,$s6   

IntLeftShift:       
add    $a0,$0,$s0       #display $s0
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.   
sll $s0, $s0, 4  
bne $s0, $zero, IntLeftShift
sub $s4,$s4,$s5      #ѭ�������ݼ�
bne $s4, $zero, IntLoop

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
lw $s5,($fp)
addi $fp,$fp,-4
addi $sp,$sp,-4
lw $s4,($fp)
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










