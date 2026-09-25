section .data
    text:
        db "mississsssiiiiippi"
    .end:
    text_len equ (text.end - text)

    counts: times 26 dd 0

    ;; the most common letter's count is 4 by default

section .text
    global _start

_start:
;   build a histogram of letter counts into `counts` (counts[c - 'a']
;   for each byte c in `text`), then exit with the highest count found
;   in `counts`

    xor R10,R10
    forbegin:
        movzx R11, byte [text+R10]
        sub R11,'a'
        inc [counts+R11*4]
        inc R10
        cmp R10,text_len
        jl forbegin
    
    xor R10,R10
    xor R11,R11
    forbegin2:
        cmp dword [counts+R10*4],R11d
        jle skip
        movzx R11,dword [counts+R10*4]
        skip:
        inc R10
        cmp R10,26
        jl forbegin2
    mov rdi,R11
    mov rax, 60
    syscall
