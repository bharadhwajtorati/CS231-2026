section .data
    values:
        dq 4,4,4,4, 4, 4, 7, 7, 2, 2, 2, 2, 9, 9, 1, 7, 7, 7
    .end:
    n equ (values.end - values)/8

    ;; longest run of consecutive equal values is 4 by default

section .text
    global _start

_start:
;   find the length of the longest run of consecutive equal values in
;   `values`, and exit with that length
; int max=r10,count=r11,i=r12,lastseen;
    xor R12,R12
    xor R11,R11
    xor R10,R10
    cmp R10,n 
    je end
    inc R10
    inc R11
    add R12,8
    mov R13,[values+0]
    forbegin:
        cmp R13,[values+R12]
        je else
        if:
            cmp R10,R11
            jge noneed
            mov R10,R11
            noneed:
            mov R11,1
            jmp ifend
        else:
            inc R11
        ifend:
        mov R13,[values+R12]
        add R12,8
        cmp R12,n*8
        jl forbegin
    end:
    mov rdi,R10
    mov rax, 60
    syscall
