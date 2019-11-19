start:       lui $7, 0               
             j main_loop             
sevenseg:    sll $30, $30, 2         
             lw $29, 0($30)          
             jr $ra                  
split:       add $29, $0, $0         
split_loop:  addi $30, $30, -10      
             sra $28, $30, 31        
             bne $28, $0, split_done 
             addi $29, $29, 1        
             j split_loop            
split_done:  addi $28, $30, 10       
             jr $ra                  
show:        add $20, $31, $0        
             sll $26, $29, 5         
             addi $26, $26, 0xff20   
             jal split               
             add $30, $29, $0        
             jal sevenseg            
             sw $29, 16($26)         
             add $30, $28, $0        
             jal sevenseg            
             sw $29, 0($26)          
             add $31, $20, $0        
             jr $ra                  
get_op:      lw $5, 65296($0)        
             addi $6, $0, -1         
             xor $5, $5, $6          
             andi $6, $5, 0x8        
             bne $6, $0, add_op      
             andi $6, $5, 0x4        
             bne $6, $0, sub_op      
             andi $6, $5, 0x2        
             bne $6, $0, xor_op      
             jr $ra                  
add_op:      addi $6, $6, -5         
sub_op:      addi $6, $6, -3         
xor_op:      add $7, $6, $0          
             jr $ra                  
do_op:       bne $7, $0, not_add     
             add $4, $2, $3          
             jr $ra                  
not_add:     addi $8, $7, -1         
             bne $8, $0, not_sub     
             sub $4, $2, $3          
             sra $5, $4, 31          
             beq $5, $0, sub_done    
             sub $4, $0, $4          
sub_done:    jr $ra                  
not_sub:     xor $4, $2, $3          
             jr $ra                  
main_loop:   lw $1, 65280($0)        
             sw $1, 65408($0)        
             andi $2, $1, 0x3e0      
             srl $2, $1, 5           
             andi $3, $1, 0x1f       
             jal get_op              
             jal do_op               
             add $30, $4, $0         
             addi $29, $0, 0         
             jal show                
             add $30, $2, $0         
             addi $29, $0, 2         
             jal show                
             add $30, $3, $0         
             addi $29, $0, 1         
             jal show                
             j main_loop             
