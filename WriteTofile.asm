INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096
BUFFER_SIZE = 501
.data
    buffer BYTE BUFFER_SIZE DUP(?)
    filename BYTE "output.txt", 0
    fileHandle HANDLE ?
    stringLength DWORD ?
    bytesWritten DWORD ?
    
    str1 BYTE "Cannot create file ", 0
    str2 BYTE "Bytes written to file [output.txt]:", 0
    str3 BYTE "Enter up to 500 characters and press [Enter]: ", 0
.code
main PROC
    ; Create a new text file.
    mov edx,OFFSET filename
    call CreateOutputFile
    
    mov fileHandle, eax
   
    cmp eax, INVALID_HANDLE_VALUE   ;Check for errors.
    jne letsWriteToFile ; if error not found
   
  
    mov edx,OFFSET str1 ; display error
    ; display error
    call WriteString
    jmp quit
    
    letsWriteToFile:
    mov edx,OFFSET str3 ; Ask the user to input a string.
    call WriteString    
    
    mov ecx, BUFFER_SIZE
    mov edx, OFFSET buffer
    call ReadString ; Input a string
    
    mov stringLength, eax   ; counts chars entered
   
    ; Write the buffer to the output file.
    mov eax, fileHandle
    mov edx, OFFSET buffer
    mov ecx, stringLength
    call WriteToFile
    
    mov bytesWritten, eax
    
    ; save return value
    call CloseFile
    
    mov edx,OFFSET str2 ; Display the return value.
    call WriteString
    
    mov eax, bytesWritten
    call WriteDec
    call Crlf
    
    quit:
    exit
main ENDP
END main