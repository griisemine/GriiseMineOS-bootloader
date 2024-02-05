[bits 16]
[org 0x7c00]

; address to load kernel
KERNEL_OFFSET equ 0x1000

; store dl value for disk address
mov [BOOT_DRIVE], dl

;stack
mov bp, 0x9000
mov sp, bp

call load_kernel
call switch_to_32bit

jmp $

%include "print.asm"
%include "disk.asm"
%include "gdt.asm"
%include "switch_to_32bit.asm"

[bits 16]
load_kernel:
    mov bx, KERNEL_OFFSET ; ptr to buffer
    mov dh, 2 ; nb sector to read
    mov dl, [BOOT_DRIVE] ; disk
    call disk_load
    ret

[bits 32]
BEGIN_32BIT:
    call KERNEL_OFFSET; 
    jmp $ ; on case of kernel ret

; BOOT_DRIVER VAR
BOOT_DRIVE db 0    
DISK_ERROR:
    db "DISK READ FAILURE", 0x0a, 0x0d, 0
DISK_SUCCESS:
    db "DISK READ SUCCESS", 0x0a, 0x0d, 0

;padding
times 510-($-$$) db 0
;magic number
dw 0xaa55