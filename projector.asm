%macro text 2
  mov eax, 4
  mov ebx, 1
  mov ecx, %1
  mov edx, %2
  int 80h
%endmacro

%macro input 2
 mov eax, 3
 mov ebx, 0
 mov ecx, %1
 mov edx, %2
 int 80h
%endmacro

section .bss
 checker resb 1
 off resb 1
 source resb 1
 source2 resb 1
 
section .data
 puton db '1'
 putoff db '2'
 hibernate db '3'
 quit db '4'
 src1 db  '1'
 src2 db  '2'
 src3 db  '3'
 
 
 msg1 db "POWER OPTIONS",0Xa,0Xd,"------------",0xa,"1. POWER ON",0Xa,0Xd,"2. POWER OFF",0Xa,0Xd,"3. HIBERNATE",0xa,0xd,"Enter: "
 lenmsg1 equ $ - msg1
 msg2 db "--Projector is ON--",0xa,0xd
 lenmsg2 equ $ - msg2
 space times 9 db "*",0xa,0xd
 lenspace equ $ - space
 msg3 db "SOURCE OPTIONS",0xa,0xd,"-------------",0xa,0xd,"1. Computer",0xa,0xd,"2. HDMI",0xa,0xd,"3. VGA",0xa,0xd,"4. Exit",0xa,0xd,"Enter: "
 lenmsg3 equ $ - msg3
 msg4 db "--Source is COMPUTER--",0xa,0xd
 lenmsg4 equ $ - msg4
 msg5 db "--Source is HDMI--",0xa,0xd
 lenmsg5 equ $ - msg5
 msg6 db "--Source is VGA--",0xa,0xd
 lenmsg6 equ $ - msg6
 msg7 db "--Projector is on HIBERNATION--",0xa,0xd
 lenmsg7 equ $ - msg7
   
 

section .text
 global _start:
_start:
    text msg1, lenmsg1
    input checker, 1
    
    ;If Power is On, jump to isON
    mov dl, [checker]
    cmp dl, [puton]
    JE isON
 
    ;If Power is Off, jump to exit
    input off, 1
    mov dl, [off]
    cmp dl, [putoff]
    JE exit
    
    ;If Power is on Hibernation, jump to isHibernate
    mov dl, [checker]
    cmp dl, [hibernate]
    JE isHibernate
    
exit: 
    mov eax, 1
    int 0x80

isON:
    text msg2, lenmsg2       ; printing Power On message
    text space, lenspace     ; printing '*'
    JMP options              ; jump to 'options' after execution
    
isHibernate:
    text msg7, lenmsg7       ; printing Hibernate message
    JMP exit                 ; jump to 'exit' after execution




options:
    text msg3, lenmsg3       ; printing the 'Source Option' menu
    input source, 1          ; taking user input
    
    mov dl, [source]         ; store user-input in the dl register
    cmp dl, '1'              ; compare user input to 1 
    JE .computer             ; jump to '.computer' if equal to 1
    
    input source2, 1                
    mov dl, [source2]
    cmp dl, '2'              ; compare user-input to 2
    JE .hdmi                 ; jump to '.hdmi' if equal
    
    mov dl, [source2]
    cmp dl, '3'              ; compare user-input to 3
    JE .vga                  ; jump to '.vga' if equal
     
    mov dl, [source2]
    cmp dl, '4'              ; compare user-input to 4
    JE exit                  ; jump to 'exit' if equal

  .computer:
     text msg4, lenmsg4      ; print  Computer source message
     JMP exit                       
  
  .hdmi:
    text msg5, lenmsg5       ; print HDMI source message
    JMP exit

  .vga:
   text msg6, lenmsg6        ; print VGA source message
   JMP exit

   

    





