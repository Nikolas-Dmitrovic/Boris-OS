[org 0x7c00 ]

mov bx, HELLO
call print

call print_n1

mov bx, GOODBYE
call print

call print_n1

mov dx, 0x12fe
call print_hex

jmp $

; remember to include the subroutines below the hang
%include "boot_sect_print.asm"
%include "boot_sect_print_hex.asm"

; data

HELLO:
	db 'Hello, World', 0

GOODBYE:
	db 'Goodbye', 0

times 510-($-$$) db 0
db 0x55, 0xaa



