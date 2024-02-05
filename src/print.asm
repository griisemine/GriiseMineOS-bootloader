print:
    pusha


.start:
    mov ah, 0x0E ; display char
    mov al, [bx] ;
    cmp al,0x00  ; check if al == 0x00
    je .done      ; stop print

    int 0x10     ; BIOS interruption
    add bx, 0x01 ; incr
    jmp .start

.done:
    popa
    ret