j 4           
sll $30 $30 2    
jr $31
lw $29 $30 0      
lw $1 $0 65280 
andi $1 $1 1023
srl $1 $1 2
addi $2 $0 160       
jal 1        
hamd $30 $2 $1
j 4
sw $29 $0 65392