j 59       
lui 7 0        
sll 30 30 2     
jr ra          
lw 29 0(30)      
add 29 0 0     
addi 30 30 -10    
sra 28 30 31     
bne 28 0 13 
add 0 0 0      
j split_loop       
addi 29 29 1     
jr ra          
addi 28 30 10    
add 20 31 0     
sll 26 29 5     
jal 6        
addi 26 26 0xff20  
jal 3      
add 30 29 0     
sw 29 16(26)     
jal 3       
add 30 28 0     
sw 29 0(26)      
add 31 20 0     
jr ra          
lw 5 65296(0)     
addi 6 0 -1     
xor 5 5 6      
andi 6 5 0x8     
bne 6 0 add_op    
add 0 0 0      
andi 6 5 0x4     
bne 6 0 sub_op    
add 0 0 0      
andi 6 5 0x2     
bne 6 0 xor_op    
add 0 0 0      
jr ra          
addi 6 6 -5     
addi 6 6 -3     
jr ra          
add 7 6 0      
bne 7 0 48  
add 0 0 0      
jr ra          
add 4 2 3      
addi 8 7 -1     
bne 8 0 57  
sub 4 2 3      
sra 5 4 31      
beq 5 0 55 
add 0 0 0      
sub 4 0 4      
jr ra          
add 0 0 0      
jr ra          
xor 4 2 3      
lw 1 65280(0)     
sw 1 65408(0)     
andi 2 1 0x3e0    
jal get_op        
srl 2 1 5      
jal do_op        
andi 3 1 0x1f    
add 30 4 0     
jal 15         
addi 29 0 0     
add 30 2 0     
jal 15         
addi 29 0 2     
add 30 3 0     
jal 15         
addi 29 0 1     
j main_loop       
add 0 0 0      