;Macro for printing out string
%macro messages 2
  mov eax, 4
  mov ebx, 1
  mov ecx,%1
  mov edx,%2
  int 80h
%endmacro

;Macro for taking user-input
%macro result 2
  mov eax, 3
  mov ebx, 0
  mov ecx,%1
  mov edx,%2
  int 80h
%endmacro

section .bss
 num1 resb 1
 num2 resb 1
 num3 resb 1
 num4 resb 1


section .data
 on db '1'
 off db '2'
 one dd '1'
 two dd '2'
 three dd '3'
 four dd '4'

;Air Condition State
power db "1. On",0xa,"2. Off",0xa,"Press 1 or 2: "
lenpower equ $ - power
onMessage db "-Air Condition is On-",0xa
lenonMessage equ $ - onMessage
load times 9 db '-',0xa
lenload equ $ - load


;Options
options db "--Choose Option--",0xa,"1. Temperature",0xa,"2. Fan Speed",0xa,"3. Exit",0xa,"Enter option: "
lenoptions equ $ - options


;Modes and Messages
choice db "--Choose Mode--",0xa,"1. Cool Mode",0xa,"2. Warm Mode",0xa,"3. Hot Mode",0xa,0xd,"Enter choice: "
lenchoice equ $ - choice
coolmode db "Cool Mode Option Selected",10
lencoolmode equ $ - coolmode
warmmode db "Warm Mode Selected",10
lenwarmmode equ $ - warmmode
hotmode db "Hot Mode Selected",0xa,0xd
lenhotmode equ $ - hotmode


;FanSpeed
choice1 db "--Choose Speed--", 0xa,0xd, "1. High Speed",0xa,"2. Medium Speed",0xa,"3. Low",0xa,"4. Exit",0xa,"Press corresponding key for speed choice: "
lenchoice1 equ $ - choice1
highfs db "Fan Speed is currently High",10
lenhighfs equ $ - highfs
mediumfs db "Fan Speed is currently Medium",10
lenmediumfs equ $ - mediumfs
lowfs db "Fan Speed is currently Low",10
lenlowfs equ $ - lowfs



section .text
 global _start
_start:
      messages power, lenpower         ; print power state options
      result num1, 1                   ; take in user-input
      mov dl, [num1]                   ; store input in the dl register
      cmp dl, [off]                    ; compare input to the value of 'off'(2)
      JE quit                          ; jump to 'quit' if equal


      mov dl, [num1]
      cmp dl, [on]                     ; compare input to the value of 'on'(1)
      JE isOn                          ; jump to 'isOn' if equal

quit:
      mov eax, 1
      int 80h


isOn:
     messages onMessage, lenonMessage   ; print 'Power On' message
     messages load, lenload             ; print '-' 
     JE option                          ; jump to option after execution
     


option:
      messages options, lenoptions      ; print the Option menu
      result num1, 1                    ; take in user-input

      mov dl, [num1]
      cmp dl, [one]
      
      JE modeMenu                       ; jump to 'modeMenu' if equal after comparing user-input and value

      result num2, 1
      mov dl, [num2]
      cmp dl, [two]
     
      JE fanSpeedMenu                   ; jump to 'fanSpeedMenu' if equal after comparing user-input and value

      mov dl, [num2]
      cmp dl, [three]
      JE quit

      
modeMenu:
       messages choice, lenchoice       ; print 'modeMenu' options
       result num2, 1                   ; take in user-input

       mov dl, [num2]
       cmp dl, [one]
      
       JE coolMes                       ; jump to 'coolMes' if equal after comparing user-input and value
       
       result num3, 1
       mov dl, [num3]
       cmp dl, [two]
 
       JE warmMes                       ; jump to 'warmMes' if equal after comparing user-input and value

       mov dl, [num3]
       cmp dl,[three]
       
       JE hotMes                        ; jump to 'hotMes' if equal after comparing user-input and value


       mov dl, [num3]
       cmp dl, [four]
       JE quit                          ; jump to 'quit' if equal after comparing user-input and value

    
     
    coolMes:
        messages coolmode, lencoolmode  ; print Cool Mode message
      
        JMP quit

    warmMes:
        messages warmmode, lenwarmmode  ; print Warm Mode message
       
        JMP quit
       

     hotMes:
        messages hotmode, lenhotmode    ; print Hot Mode message
      
        JMP quit
       


fanSpeedMenu:
        messages choice1, lenchoice1      ; print Fan Speed Menu
        result num3, 1                    ; take in user input

        mov dl, [num3]
        cmp dl, [one]
        JE highMenu                       ; jump to 'highMenu' if equal after comparing the input and value

        result num4, 1
        mov dl, [num4]
        cmp dl, [two]
        JE mediumMenu                     ; jump to 'mediumMenu' if equal after comparing the input and value

        mov dl, [num4]
        cmp dl, [three]
        JE lowMenu                        ; jump to 'lowMenu' if equal after comparing the input and value

        mov dl,[num4]
        cmp dl,[four]
        JE quit                           ; jump to 'quit' if equal after comparing the input and value
       
      highMenu:
         messages highfs, lenhighfs       ; print High Speed message
        
         JMP quit
   
      mediumMenu:
          messages mediumfs, lenmediumfs  ; print Medium Speed message
          
          JMP quit
          
      lowMenu:
          messages lowfs, lenlowfs         ; print Low Speed message
        
          JE quit
        
