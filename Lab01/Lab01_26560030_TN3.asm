# Bui Thieu Khiem - 26560030 - Calculating energy used by a household (fictitious readings, kWh)
# Variable   Register
# reading0   $s0   start of month 1
# reading1   $s1   start of month 2
# reading2   $s2   start of month 3
# reading3   $s3   end of month 3
# usage1     $t0   energy used in month 1
# usage2     $t1   energy used in month 2
# usage3     $t2   energy used in month 3
# total      $t3   usage1 + usage2 + usage3

.data
prompt: .asciiz "Enter reading (kWh): "
m1:     .asciiz "Month 1: "
m2:     .asciiz "Month 2: "
m3:     .asciiz "Month 3: "
tot:    .asciiz "Total:   "
nl:     .asciiz "\n"

.text
.globl main
main:
    # addi $s0, $zero, 1200
    # addi $s1, $zero, 1350
    # addi $s2, $zero, 1475
    # addi $s3, $zero, 1640
    li   $v0, 4     # print prompt
    la   $a0, prompt
    syscall
    
    li   $v0, 5     # read reading0
    syscall
    add  $s0, $v0, $zero

    li   $v0, 5     # read reading1
    syscall
    add  $s1, $v0, $zero

    li   $v0, 5     # read reading2
    syscall
    add  $s2, $v0, $zero

    li   $v0, 5     # read reading3
    syscall
    add  $s3, $v0, $zero

    sub $t0, $s1, $s0   # usage1 = reading1 - reading0
    li   $v0, 4         # print m1
    la   $a0, m1
    syscall
    li   $v0, 1         # print usage1
    add  $a0, $t0, $zero
    syscall
    li   $v0, 4         # print \n
    la   $a0, nl
    syscall

    sub $t1, $s2, $s1 # usage2 = reading2 - reading1
    li   $v0, 4         # print m2
    la   $a0, m2
    syscall
    li   $v0, 1         # print usage2
    add  $a0, $t1, $zero
    syscall
    li   $v0, 4         # print \n
    la   $a0, nl
    syscall

    sub $t2, $s3, $s2 # usage3 = reading3 - reading2
    li   $v0, 4         # print m3
    la   $a0, m3
    syscall
    li   $v0, 1         # print usage3
    add  $a0, $t2, $zero
    syscall
    li   $v0, 4         # print \n
    la   $a0, nl
    syscall

    # total = usage1 + usage2 + usage3   (two add instructions)
    add $t3, $t0, $t1   # total = usage1 + usage2
    add $t3, $t3, $t2   # total = total + usage3
    li   $v0, 4         # print tot
    la   $a0, tot
    syscall
    li   $v0, 1         # print total
    add  $a0, $t3, $zero
    syscall

    li   $v0, 10
    syscall
