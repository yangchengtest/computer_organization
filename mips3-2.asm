.data
buf:    .space      255
succ:   .asciiz     "Success! Location: "
fail:   .asciiz     "Fail!\r\n"
endline: .asciiz   "\r\n"
.text
main:	
	la $a0, buf
 	la $a1, 255
 	li $v0, 8  #input a string
 	syscall
 	
char:
	li $v0,12
	syscall 
	sub  $t0, $v0, 63  
	beqz $t0, exit
	move $t0,$v0
	
	li $v0,4       
   	la $a0,endline     
    	syscall
    	
    	la $t1,buf
    	li $t2,0
 
find_loop:
 	lb $t3,($t1)   	   
 	beq $t3,0,findfail	
    	sub $t4, $t3, $t0
    	beqz $t4,findsucc
 	addi $t1,$t1,1
 	addi $t2,$t2,1
 	j find_loop
 	
findsucc:
	la $a0, succ
 	li $v0, 4
 	syscall
 	move $a0,$t2
 	li $v0, 1
 	syscall
 	li $v0,4       
   	la $a0,endline     
    	syscall
	j char
	
findfail:
	la $a0, fail
 	li $v0, 4
 	syscall
	j char
	
 exit:
	li $v0, 10
	syscall    	    	