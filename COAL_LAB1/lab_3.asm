
INCLUDE Irvine32.inc
.data
colon BYTE ":", 0
newline BYTE 13, 10, 0
msg_gmt BYTE "GMT Time: ", 0
msg_pk BYTE "Pakistan Time (PK): ", 0
msg_us BYTE "US Eastern Time (US): ", 0
msg_date BYTE "Date: ", 0
hyphen BYTE "-", 0
zero BYTE "0", 0
; Define SYSTEMTIME structure manually (16-bit words)
sysTime STRUCT
 wYear WORD ?
 wMonth WORD ?
 wDayOfWeek WORD ?
 wDay WORD ?
 wHour WORD ?
 wMinute WORD ?
 wSecond WORD ?
wMilliseconds WORD ?
sysTime ENDS
localTime sysTime <>
tempHour WORD ?
.code
main PROC
 call Clrscr
clock_loop:
 INVOKE GetLocalTime, ADDR localTime
 ; ------------------ Print Date ------------------
 mov ax, LIGHTGREEN
 call SetTextColor
 mov edx, OFFSET msg_date
 call WriteString
 ; Print Year
 movzx eax, localTime.wYear
 call WriteDec
 ; Print "-"
 mov edx, OFFSET hyphen
 call WriteString
 ; Print Month
 movzx eax, localTime.wMonth
 call PrintTwoDigits
 ; Print "-"
 mov edx, OFFSET hyphen
 call WriteString
 ; Print Day
 movzx eax, localTime.wDay
 call PrintTwoDigits
 ; Newline
 mov edx, OFFSET newline
 call WriteString
 ; ------------------ GMT Time ------------------
 movzx eax, localTime.wHour
 sub eax, 5
 cmp eax, 0
 jge skip_gmt_wrap
 add eax, 24
skip_gmt_wrap:
 mov tempHour, ax
 mov ax, LIGHTCYAN
 call SetTextColor
 mov edx, OFFSET msg_gmt
 call WriteString
 movzx eax, tempHour
 call PrintTwoDigits
 mov edx, OFFSET colon
 call WriteString
 movzx eax, localTime.wMinute
 call PrintTwoDigits
 mov edx, OFFSET colon
 call WriteString
 movzx eax, localTime.wSecond
 call PrintTwoDigits
 ; Newline
 mov edx, OFFSET newline
 call WriteString
 ; ------------------ Pakistan Time ------------------
 movzx eax, tempHour
 add eax, 5
 cmp eax, 24
 jl skip_pk_wrap
 sub eax, 24
skip_pk_wrap:
 mov tempHour, ax
 mov ax, LIGHTBLUE
 call SetTextColor
 mov edx, OFFSET msg_pk
 call WriteString
 movzx eax, tempHour
 call PrintTwoDigits
 mov edx, OFFSET colon
 call WriteString
 movzx eax, localTime.wMinute
 call PrintTwoDigits
 mov edx, OFFSET colon
 call WriteString
 movzx eax, localTime.wSecond
 call PrintTwoDigits
 ; Newline
 mov edx, OFFSET newline
 call WriteString
 ; ------------------ US Eastern Time ------------------
 movzx eax, tempHour
 sub eax, 9
 cmp eax, 0
 jge skip_us_wrap
 add eax, 24
skip_us_wrap:
 mov tempHour, ax
 mov ax, YELLOW
 call SetTextColor
 mov edx, OFFSET msg_us
 call WriteString
 movzx eax, tempHour
 call PrintTwoDigits
 mov edx, OFFSET colon
 call WriteString
 movzx eax, localTime.wMinute
 call PrintTwoDigits
 mov edx, OFFSET colon
 call WriteString
 movzx eax, localTime.wSecond
 call PrintTwoDigits
 ; Extra newline
 mov edx, OFFSET newline
 call WriteString
 mov edx, OFFSET newline
 call WriteString
 ; Wait 1 second
 mov ecx, 1000
 call Delay
 ; Reset cursor to top left
 mov dh, 0
 mov dl, 0
 call Gotoxy
 jmp clock_loop
main ENDP
; Print two digits with zero-padding if needed
PrintTwoDigits PROC
 cmp eax, 10
 jge skip_zero
 mov edx, OFFSET zero
 call WriteString
skip_zero:
 call WriteDec
 ret
PrintTwoDigits ENDP
END main
