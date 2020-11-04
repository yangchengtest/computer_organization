.data
Upper:	.asciiz   
    "Alpha\r\n","Bravo\r\n","China\r\n","Delta\r\n","Echo\r\n",
    "Foxtrot\r\n","Golf\r\n","Hotel\r\n","India\r\n","Juliet\r\n",
    "Kilo\r\n","Lima\r\n","Mary\r\n","November\r\n","Oscar\r\n",
    "Paper\r\n","Quebec\r\n","Reserach\r\n","Sierra\r\n","Tango\r\n",
    "Uniform\r\n","Victor\r\n","Whisky\r\n","X-ray\r\n","Yankee\r\n",
    "Zulu\r\n"

Lower:	.asciiz 
    "alpha\r\n","bravo\r\n","china\r\n","delta\r\n","echo\r\n",
    "foxtrot\r\n","golf\r\n","hotel\r\n","india\r\n","juliet\r\n",
    "kilo\r\n","lima\r\n","mary\r\n","november\r\n","oscar\r\n",
    "paper\r\n","quebec\r\n","reserach\r\n","sierra\r\n","tango\r\n",
    "uniform\r\n","victor\r\n","whisky\r\n","x-ray\r\n","yankee\r\n",
    "zulu\r\n"

alphabet_offset: .word 0,8,16,24,32,39,49,56,64,72,81,88,95,102,113,121,129,138,149,158,166,176,185,194,202,211

Number:	.asciiz "zero ", "one ", "two ", "three ", "four ", "five ", "six ", "seven ","eight ","nine "
number_offset:	.word 0,6,11,16,23,29,35,40,47,54

Other: .asciiz "*\n"
.text 
main:
	li $v0,12
	syscall 
	sub  $t0, $v0, 63  
	beqz $t0, exit
	
	sub  $t0, $v0, 48
	bltz $t0, other
	
	sub  $t1, $v0, 122
	bgtz $t1, other
	
	sub  $t0,$t0,10
	bltz $t0,num
	
	sub  $t0,$v0,65
	bltz $t0, other
	
	sub  $t0,$v0,91
	bltz $t0, upper
	
	sub  $t0,$v0,97
	bltz $t0, other
	j lower
	
num:
	sub $t1,$v0, 48
	la $t2,number_offset	
	sll $t1,$t1,2
	add $t1,$t1,$t2
	lw $t2,($t1)
	la $t3,Number
	add $a0,$t3,$t2
	li $v0, 4
	syscall 
	j main

upper:
	sub $t1,$v0, 65
	la $t2,alphabet_offset
	sll $t1,$t1,2
	add $t1,$t1,$t2
	lw $t2,($t1)
	la $t3,Upper
	add $a0,$t3,$t2
	li $v0, 4
	syscall 
	j main
	
lower:
	sub $t1,$v0, 97
	la $t2,alphabet_offset
	sll $t1,$t1,2
	add $t1,$t1,$t2
	lw $t2,($t1)
	la $t3,Lower
	add $a0,$t3,$t2
	li $v0, 4
	syscall 
	j main	
	
other:
	la $a0,Other
	li $v0, 4
	syscall 
	j main
		
exit:
	li $v0, 10
	syscall 