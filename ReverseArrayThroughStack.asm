include irvine32.inc
.386
.model flat, stdcall
.stack 4096

.data
    array db 1,23,38,4,56,76,44,33, 9, 11

.code
main PROC
    mov ecx, lengthof array

    mov esi,offset array
    pushArray:
        mov eax, 0
        mov al, [esi]
        push eax
        inc esi
        loop pushArray

    mov esi, offset array
    mov ecx, 10
    popArray:
        mov eax, 0
        pop eax
        mov [esi], al
        inc esi
        loop popArray
    
    mov al, 1
    
    exit
main endp
end main
