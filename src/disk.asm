disk_load:
    pusha
    push dx

    mov ah, 0x02 ; read mode
    mov al, dh   ; read dh nb sector
    mov cl, 0x02 ; start from sector 2
    mov ch, 0x00 ; cylinder 0
    mov dh, 0x00 ; head 0


    int 0x10     ; BIOS interruption
    jc disk_error; check for error
    
    mov bx, DISK_SUCCESS
    call print

    popa
    ret

disk_error:
    mov bx, DISK_ERROR
    call print
    jmp disk_loop

disk_loop:
    jmp $