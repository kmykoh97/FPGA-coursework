lui $7 0
lw $1 $0 4294967040
sw $1 $0 4294967168
andi $2 $1 992
srl $2 $1 5
andi $3 $1 31
lw $5 $0 4294967056 # jump
addi $6 $0 -1
xor $5 $5 $6
andi $6 $5 8
addi $6 $6 -5
# addi $6 $6 -3 # for sub
add $4 $2 $3 # jump do addition
add $30 $4 $0
addi $29 $0 0
add $20 $31 $0 # jump again
sll $26 $29 5
addi $26 $26 65312
add $29 $0 $0 # break
addi $30 $30 -10
sra $28 $30 31
bne $28 $0 25
addi $29 $29 1
j 19
addi $28 $30 10 # done
add $30 $29 $0
sll $30 $30 2
lw $29 $30 0
sw $29 $26 16 # tens digit show
add $30 $28 $0
sll $30 $30 2
lw $29 $30 0
sw $29 $26 0 # ones digit show
j 0