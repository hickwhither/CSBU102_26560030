# Listing 6 - energy used between two readings
# Variable   Register
# reading0   $s0   start of month 1
# reading1   $s1   start of month 2
# reading2   $s2   start of month 3
# reading3   $s3   end of month 3

.data
prompt1: .asciiz "Enter previous reading (kWh): "
prompt2: .asciiz "Enter current reading (kWh): "
label:   .asciiz "Usage (kWh): "
newline: .asciiz "\n"

.text
.globl main
main:
    # --- read the previous reading into $s0 ---
    li   $v0, 4
    la   $a0, prompt1
    syscall
    li   $v0, 5              # service 5: read integer, result in $v0
    syscall
    add  $s0, $v0, $zero     # keep the value in $s0
 
    # read the current reading into $s1 (print prompt2, then service 5)
    li   $v0, 4         # 
    la   $a0, prompt2
    syscall
    li   $v0, 5
    syscall
    add  $s1, $v0, $zero
 
    # usage = current - previous, into $t0
    sub $t0, $s1, $s0
 
    # print label, then the usage (service 1), then newline
    li   $v0, 4
    la   $a0, label
    syscall
    li   $v0, 1
    add  $a0, $t0, $zero
    syscall
    li   $v0, 4
    la   $a0, newline
    syscall
 
    li  $v0, 10
    syscall