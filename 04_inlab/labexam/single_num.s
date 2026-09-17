section .data
    coeffs:
        dq 1.0, 2.0, 3.0, 4.0
    .end:
    coeffs_len equ (coeffs.end - coeffs)/8

    x_val: dq 2.0

section .text
    global _start

; poly_eval(double* coeffs{rdi}, size_t N{rsi}, x{xmm0}) -> xmm0
poly_eval:
    ; ==================== DO NOT EDIT ABOVE THIS LINE ====================
    cmp esi,1
    je .basecase
    
    add rdi,8
    dec esi
    call poly_eval
    sub rdi,8
    inc esi
    mulsd xmm0,xmm1
    addsd xmm0,[rdi]
    ret
    .basecase:
        movsd xmm1,xmm0
        xorps xmm0,xmm0
        addsd xmm0,[rdi]
        ret
    
    ; ==================== DO NOT EDIT BELOW THIS LINE ====================
    ret

_start:
;   Call poly_eval(coeffs, coeffs_len, x_val), truncate the result toward
;   zero, and exit with that as the exit code.
    lea rdi, [coeffs]
    mov esi, coeffs_len
    movsd xmm0, [x_val]
    call poly_eval
    cvttsd2si rdi, xmm0

    mov rax, 60
    syscall
