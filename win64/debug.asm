

    format PE64 GUI    at 010000h
    stack   65536
    heap    2097152

    macro alignhe
	 { virtual
	    align 8
	    algn = $ - $$
	   end virtual
	  db algn dup 0
	 }

   cell_size = 8

section '.idata' import data readable writeable

idaqa:
  dd 0,0,0,RVA kernel_name,RVA kernel_table
  dd 0,0,0,0,0

  kernel_table:
    ExitProcess 	dq RVA _ExitProcess
    AllocConsole	dq RVA _AllocConsole
    WriteConsole	dq RVA _WriteConsole
    SetConsoleTitle	dq RVA _SetConsoleTitle
    GetStdHandle	dq RVA _GetStdHandle
    ReadConsole 	dq RVA _ReadConsole
    OpenFile		dq RVA _OpenFile
    ReadFile		dq RVA _ReadFile
    VirtualAlloc	dq RVA _VirtualAlloc
    Sleep		dq RVA _Sleep
    CloseFile		dq RVA _CloseHandle
    GetLastError	dq RVA _GetLastError
    LoadLibrary 	dq RVA _LoadLibrary
    GetProcAddress	dq RVA _GetProcAddress
    SetFilePointer	dq RVA _SetFilePointer
    dq 0

  kernel_name db 'KERNEL32.DLL',0

  _ExitProcess dw 0
    db 'ExitProcess',0

  _AllocConsole dw 0
    db 'AllocConsole',0
  _WriteConsole dw 0
    db 'WriteConsoleA',0
  _SetConsoleTitle dw 0
    db 'SetConsoleTitleA',0
  _GetStdHandle dw 0
    db 'GetStdHandle',0
    _ReadConsole dw 0
    db 'ReadConsoleA',0
    _OpenFile dw 0
    db 'OpenFile',0
     _ReadFile dw 0
    db 'ReadFile',0
    _VirtualAlloc dw 0
    db 'VirtualAlloc',0
    _Sleep dw 0
    db 'Sleep',0
    _CloseHandle dw 0
    db 'CloseHandle',0
    _GetLastError dw	0
    db 'GetLastError',0
    _LoadLibrary dw 0
    db 'LoadLibraryA',0
    _GetProcAddress dw 0
    db 'GetProcAddress',0
    _SetFilePointer dw	0
    db 'SetFilePointer',0

;---------------------------
; vocabulary start
;---------------------------
 section '.text' code readable executable  writeable
    align cell_size

     hStdin   dq 0
     chars    dq 0
   _cbuffer   db 512 dup ?


nfa_0:
	db 7, "FORTH32",0
	alignhe
	dq nfa_1 ;LFA
	dq _vocabulary ;CFA
f32_list:
	dq nfa_last ;PFA - oeacaoaeu ia eoa iineaaiaai ii?aaaeaiiiai neiaa
_vocabulary:
	add rax,cell_size
	call _push
	ret
;----------------------------
	align cell_size
nfa_1:
	db 7,"BADWORD",0
	alignhe
	dq 0 ; zero LFA. End of search or link winth another vocabulary if not zero
	dq _vect
	dq abort_
_vect:
	mov rax,[rax+cell_size]
	call qword [rax]
	ret
;----------------------------
	align  cell_size
nfa_2:
	db 4,"EXIT",0
	alignhe
	dq nfa_0
ret_:
	dq _ret
_ret:
	pop rax
	pop rax
	ret
;----------------------------
	align  cell_size
nfa_3:
	db 4,"Push",0
	alignhe
	dq nfa_2
	dq _push
_push:
	mov rbx,[stack_pointer]
	add rbx , cell_size
	mov r10,[stack_base]
	and rbx , [data_stack_mask]
	add r10,rbx
	mov [r10] , rax
	mov [stack_pointer],rbx
	ret
data_stack_mask dq 0x00ffff
stack_pointer dq 0
stack_base    dq 0
;----------------------------
	align  cell_size
nfa_4:
	db 3,"Pop",0
	alignhe
	dq nfa_3
	dq _pop
_pop:
	mov rbx,[stack_pointer]
	mov r10,[stack_base]
	mov rax , [rbx+r10]
	sub rbx , cell_size
	and rbx , [data_stack_mask]
	mov [stack_pointer],rbx
	ret
;------------------------------
	align cell_size
nfa_5:
	db 5,"ABORT",0
	alignhe
	dq nfa_4
abort_:
	dq _abort
_abort:
	mov rax,msgbad
	call _push
	call _typez
	mov rax,[here_value]
	call	_push
	call	_typez
	mov    eax,msgabort
	call _push
	call _typez
	jmp _bye

msgbad db 9," Badword: "
msgabort db 7," Abort!",0
;----------------------------
	align cell_size
nfa_6:
	db 4,"HERE",0
	alignhe
	dq nfa_5
	dq _constant
here_value:
	dq _here
_constant:
	mov rax,[rax+cell_size]
	call _push
	ret

;----------------------------
	align cell_size
nfa_7:
	db 9,"INTERPRET",0
	alignhe
	dq nfa_6
	dq _interpret
_interpret:

	call _parse
   ; mov eax,[here_value]
   ;call       _push ; debug
   ; call _typez
	mov rax,context_value
	call _push
	call _fetch
	call _sfind
	call _execute_code
	jmp _interpret

;----------------------------
	 align cell_size
nfa_8:
	db	10,"interpret#",0
	alignhe
	dq	nfa_7
	dq	_constant
	dq	_addr_interp
_addr_interp:
	add rax,cell_size
	push rax
	mov rax,[rax]
	call near qword [rax]
	pop rax
	jmp _addr_interp

;--------------------------------
	align cell_size
nfa_9:
	db 5,"PARSE",0
	alignhe
	dq nfa_8
parse_:
	dq _parse
_parse:
	mov rax,[buffer] ;input buffer
	call _push
	mov rax,[here_value] ;here
	call _push
	call _enclose
	ret
;----------------------------
	align cell_size
nfa_10:
	db 7,"ENCLOSE",0
	alignhe
	dq nfa_9
	dq _enclose
_enclose:
	call _pop ; to address
	mov rdi,rax
	mov r13,rax
	call _pop ; from address

	mov rsi,rax
	mov r12,rax

	xor rdx,rdx
	add rsi,[_in_value]
_enc2:
	mov rbx,rdi
; clear 32 bytes
	xor rax,rax
	mov rcx,cell_size
	cld
	rep stosq
	mov rdi,rbx
	mov rcx,[bytes_to_read] ; size of buffer
	cmp rcx,rdx
	jl _word2 ;jl
	inc rdi
_skip_delimeters:
	sub qword [bytes_to_read],1 ; [nkey],1
	jb _word2
	lodsb
	inc qword [_in_value]
	cmp al,20h
	jbe _skip_delimeters
_word3:
	stosb
	inc rdx
	sub qword [bytes_to_read],1 ; [nkey],1
	jb _word4
	lodsb
	inc qword [_in_value]
	cmp al,20h
	jnbe _word3
	 mov [rbx],dl
	 ret

_word4:
; string to validate
;����� ����� �� �������     ������� ���� ������� �� ������ �����.
   ;	int3
	sub    rsp,30h
	mov	rcx,[handle]
	mov	r9,1; rdx ;distance to move
	xor	r8,r8
	neg	rdx
;	 mov	 r8,  8192
;	 mov	 rdx, [buffer]

	xor	rax,rax
	mov	qword [rsp+20h],0
	call	[SetFilePointer]
	add	rsp,30h
	 mov	 rax,[handle]
	call	_push
	call	_rdfile   ;	 � ������ ���� ����������� �������
	;���������� IN> ����� �� 0, rdi �����, rsi �� ������ ������.
	mov	    rdi,r13
	mov	    rsi,r12
	xor	    rdx,rdx
	mov	    [_in_value],rdx
	jmp	 _enc2

_word2:
;end of buffer
    ;	 int3
	mov	rax,[handle]
	call	_push
	call	_rdfile
	jmp    _skip_delimeters
; empty string
	 mov	rax,5449584504h ;4,"EXIT"
	 mov qword [rbx],rax
	 ;mov dword [ebx+4],054h ;"T",0
	 ret
;----------------------------
	align cell_size
nfa_11:
	db 7,"CONTEXT",0
	alignhe
	dq nfa_10
context_:
	dq _variable_code
context_value:
	dq f32_list

_variable_code:
	add rax,cell_size
	call _push
	ret

;--------------------------------
	align cell_size
nfa_12:
	db 7,"CURRENT",0
	alignhe
	dq nfa_11
current_:
	dq _variable_code
current_value:
	dq f32_list
;--------------------------------
	align cell_size
nfa_13:
	db 1,"@",0
	alignhe
	dq nfa_12
fetch_:
	dq _fetch
_fetch:
	call _pop
	mov rax,[rax]
	call _push
	ret
;----------------------------
	align cell_size
nfa_14:
	db	1,"!",0
	alignhe
	dq	nfa_13
	dq	_store
_store:
	call	_pop	; address
	mov		rdx,rax
	call	_pop	;data
	mov		[rdx],rax
	ret
;--------------------------------
	align cell_size
nfa_15:
	db	5,"CELL+",0
	alignhe
	dq	nfa_14
cellp_:
	dq	_cellp
_cellp:
	call	_pop
	add	rax,cell_size
	call	_push
	ret
;--------------------------------
	align cell_size

nfa_16:
	db	1,",",0
	alignhe
	dq nfa_15
	dq _comma
_comma:
	mov	rdx,[here_value]
	call	_pop
	mov	[rdx],rax
	add	qword [here_value],cell_size
	ret

;--------------------
	align cell_size
nfa_17:
	db	5,"ALIGN",0
	alignhe
	dq	nfa_16
align_:
	dq	_align
_align:
	mov	rax,[here_value]
	and    rax,7
	setne  al
	and    qword [here_value],-8
	shl    al,3
	add    [here_value],rax
	ret
;----------------------------

	align cell_size
nfa_18:
	db	1,"'",0
	alignhe
	dq	nfa_17
	dq	_addr_interp
	dq	parse_
	dq context_
	dq	fetch_
	dq	sfind_
	dq	ret_

;----------------------------
	align cell_size
nfa_19:
	db 5,"SFIND",0
	alignhe
	dq nfa_18
sfind_:
	dq _sfind
_sfind:
	call _pop
	mov rsi,rax ;pop context
	mov rsi,[rsi] ;vocid
_find2:
	 movzx rbx,byte [rsi];word in vocab
	 mov rdx,rbx
	 inc bl
	 and bl,0f8h ;mask immediate in counter
	 mov rax,[here_value]
	 mov	 rdi,rax
	 movzx rcx,byte [rdi] ; word on here
	 shr rcx,3
	 inc rcx
	 mov rbp,rsi
	 mov rax,[rdi]
find22:
	 cld
	 cmpsq
	 jne _find11
	 loop find22
	 and rdx,cell_size-1
	 cmp rdx,cell_size-1
	 jne find23
	 add rsi,cell_size
find23:
	 mov rax,rsi
	 add rax,cell_size
	 call _push
	 ret ;word found

_find11:

	mov rsi,rbp
	add rsi,cell_size
	add rsi,rbx
	mov rcx,rsi
	mov rsi,[rsi]
_find4:
	test rsi,rsi
	jne _find2
	mov rax,rcx
	add rax,cell_size
	call _push
	ret ; badword
;----------------------------
	align cell_size
nfa_20:
	db 7,"EXECUTE",0
	alignhe
	dq nfa_19
	dq _execute_code
_execute_code:
	call _pop
_execute:
	call qword [rax]
	ret
;----------------------------
	align cell_size
nfa_21:
	db 3,">IN",0
	alignhe
	dq nfa_20
	dq _variable_code
_in_value:
	dq 0
bytes_to_read	     dq 8192 ;size of buffer
dq 0
;buffer 	      dq 0 ; buffer_base  ;address of input buffer
;----------------------------
	align cell_size

nfa_22:
	db	6,"N>LINK",0
	alignhe
	dq	nfa_21
nlink_:
	dq	_nlink
_nlink:
	call	_pop
	mov	rsi,rax
	call	nlink2
	mov	rax,rsi
	call	_push
	ret

nlink2:
	movzx	rbx,byte [rsi]
	inc	bl
	and	bl,0f8h
	add	rsi,rbx
	add	rsi,cell_size
	ret
;----------------------------
	align cell_size

nfa_23:
	db	6,"LATEST",0
	alignhe
	dq	nfa_22
latest_:
	dq	_latest

_latest:
	call	latest_code2
	call	_push
	ret

latest_code2:
	mov	rax,[current_value]
	mov	rax,[rax] ; eax = latest nfa of curent vocabulary
	ret
;--------------------
	align cell_size

nfa_24:
	db 6,"(WORD)",0
	alignhe
	dq nfa_23
	dq _word
_word:
	call _pop ; to address
	mov rdi,rax ;[here_value]
	call _pop ; from address
	mov rsi,rax ;[block_value+cell_size]
	call _pop	; symbol
	mov  [word_symb],al
	xor rdx,rdx
	add rsi,[_in_value]
	mov rbx,rdi
; clear 32 bytes
	xor rax,rax
	mov rcx,cell_size
	cld
	rep stosq
	mov rdi,rbx
	mov rcx,[bytes_to_read] ; size of buffer
	cmp rcx,rdx
	jl _word42 ;jl
	inc edi
_word45:
	sub qword [bytes_to_read],1 ; [nkey],1
	jb _word42
	lodsb
	inc qword [_in_value]
	cmp al,[word_symb]
	je _word45
_word43:
	stosb
	inc rdx
	sub qword [bytes_to_read],1 ; [nkey],1
	jb _word44
	lodsb
	inc qword [_in_value]
	cmp al,[word_symb]
	jne _word43
_word44:
; string to validate
	 mov [rbx],dl
	 ret
_word42:
; empty string
     mov	rax,5449584504h  
	; mov qword [rbx],495cell_size4504h ;4,"EXI"
	; mov dword [ebx+4],054h ;"T",0
	 ret
word_symb	db	20h
;--------------------------------
       align cell_size

nfa_25:
	db	8,"(HEADER)",0
	alignhe
	dq nfa_24
	dq _hheader
_hheader:
	mov	rsi,[here_value]
	call	nlink2		;esi - address of lf
	call	latest_code2	;eax - latest
	mov	[rsi],rax	;fill link field
	mov	rbx,[here_value]
	mov	rax,[current_value]
	mov	[rax],rbx	; here to latest
	add	rsi,cell_size
	mov	[here_value],rsi
	ret

;--------------------
	align cell_size

nfa_26:
	db	6,"HEADER",0
	alignhe
	dq nfa_25
	dq _header
_header:
	call	_parse
	call	_hheader
	ret
;--------------------------------
	align	16
value:		dq	0
		dq	0

zeroes: 	dq	3030303030303030h
		dq	3030303030303030h

sixes:		dq	0606060606060606h
		dq	0606060606060606h

fes:		dq	0x0f0f0f0f0f0f0f0f
		dq	0x0f0f0f0f0f0f0f0f

lowupmask:	dq	0xdfdfdfdfdfdfdfdf
		dq	0xdfdfdfdfdfdfdfdf


;-----------------------
	align cell_size
nfa_27:
	db	  3,"0xd",0
	alignhe
	dq nfa_26
	dq _0xd1
_0xd1:
	call	_number
	call	_0xd
	ret

_0xd:
      ;  int3
	call		_pop
	mov		rsi,[rax+cell_size+cell_size+cell_size]
	bswap		rsi
	mov		rcx,[rax+cell_size+cell_size]
	bswap		rcx
	mov		rbx,[rax+cell_size]
	bswap		rbx
	mov		rdx,[rax]
	bswap		rdx
	mov		[rax+cell_size+cell_size+cell_size],rdx
	mov		[rax+cell_size+cell_size],rbx
	mov		[rax+cell_size],rcx
	mov		[rax],rsi
	movdqu		xmm0,[rax]
	movdqu		xmm1,[lowupmask]

	movdqu		xmm2,[fes]
	movdqu		xmm3,[sixes]
	movdqu		xmm4,[zeroes]
	movdqu		xmm7,[bytemask]
	psubb		xmm0,xmm4	; sub 30h ascii zero
	pand		xmm0,xmm1
	paddb		xmm0,xmm3	; add six.
	movdqa		xmm5,xmm0	;
	pand		xmm0,xmm2
	psubb		xmm0,xmm3	;????? ?????
	psrlq		xmm5,4
	pand		xmm5,xmm2	;???????? ?????? ????????
	paddb		xmm0,xmm5
	psllq		xmm5,3
	por		xmm0,xmm5
	movdqa		xmm6,xmm0

	pxor		xmm1,xmm1

	pand		xmm0,xmm7
	psrlq		xmm6,8
	pand		xmm6,xmm7

	packsswb	xmm0,xmm1
	packsswb	xmm6,xmm1
	psllq		xmm6,4
	por		xmm0,xmm6

	movdqu		dqword [value],xmm0
	mov		rax, qword  [value]
	call		_push
	mov		rax,qword[value+cell_size]
	call		_push
	ret
;----------------------------
	align cell_size
nfa_28:
	db	  2,"0x",0
	alignhe
	dq nfa_27
	dq _0x
_0x:
	call	_0xd1
	call	_pop

	ret
	align 16
bytemask:	dq	0ff00ff00ff00ffh
		dq	0ff00ff00ff00ffh

;----------------------------
	align cell_size
nfa_29:
	db	  6,"number",0
	alignhe
	dq nfa_28
	dq _number
_number:
     ;	 int 3
	mov	rsi,[buffer]
	xor	rdx,rdx
	add	rsi,[_in_value]
	mov	rdi,[here_value]
	mov	rbx,rdi
	; fill 32 bytes with zeroes
	mov	rax,3030303030303030h
	mov	rcx,cell_size
	cld
	rep	stosq


	mov	rdi,rbx
	mov	rcx,[bytes_to_read] ; [nkey]
	cmp	rcx,rdx ; edx=0
	jl	number2

	inc	rdi
_skip_delimeters2:

	sub	qword [bytes_to_read],1 ; [nkey],1
	je	number2
	lodsb
	inc	qword [_in_value]
	cmp	al,21h
	jb     _skip_delimeters2

	mov		rdi,[here_value]
	add		rdi,32
number3:
	; move to here +15
	stosb
	inc	rdx
	sub	qword [bytes_to_read],1 ; [nkey],1
	jb	number4
	lodsb
	inc	qword [_in_value]
	cmp	al,20h
	ja     number3

number4:
	;normalize number
	; edx - count of digits
	sub		rdi,32
	mov		rax,rdi
	call	_push
	ret

number2:

	; empty string
	mov	qword [_in_value],0
	ret
;--------------------
	align cell_size

nfa_30:
	db	4,"LINK",0
	alignhe
	dq	nfa_29
	dq	_link
_link:
	call	_pop
	mov	rcx,[rax]
	push	rcx
	call	_badword_xt
	call	_pop
	pop	rbx
	mov	qword [rax-cell_size],rbx
	ret
;----------------------------
	align cell_size

nfa_31:
	db	6,"UNLINK",0
	alignhe
	dq	nfa_30
	dq	_unlink

_unlink:
	call	_badword_xt
	call	_pop
	xor	rbx,rbx
	mov	 qword [rax-cell_size],rbx
	ret

;----------------------------
	align cell_size

nfa_32:
	db	10,"BADWORD-xt",0
	alignhe
	dq	nfa_31
	dq	_badword_xt

_badword_xt:
	mov	rdx,[here_value]
	mov	rax,44524f5744414207h
	mov	qword [rdx],rax ; 44414207h
	;mov	qword [rdx+8],;"WORD"
	xor	rax,rax
	mov	qword [rdx+cell_size],rax
	call	_sfind
	ret
;----------------------------
	align cell_size

nfa_33:
	db 3,"BYE",0
    alignhe
	dq nfa_32
	dq _bye
_bye:
_quit_forth:
	mov	rcx,24000
	call	[Sleep]
	xor	rcx,rcx
	call	[ExitProcess]

;----------------------------
	align cell_size
nfa_34:
	db 6,"BUFFER",0
	alignhe
	dq nfa_33
buffer_:
	dq _variable_code
buffer:
	dq  0
block	dq  0
buffer_base:
	dq	0
;----------------------------
	align cell_size

nfa_35:
	db	9,"ASSEMBLER",0
	alignhe
	dq     nfa_34
	dq     _vocabulary
	dq     _nfa_assembler_last
;----------------------------
	align cell_size
nfa_36:
	db 7,"BADWORD",0
	alignhe
	dq nfa_last ; zero LFA. End of search or link winth another vocabulary if not zero
	dq _vect
	dq abort_

;----------------------------
	align cell_size
nfa_37:

	db 4,"EXIT",0
	alignhe
	dq nfa_36
	dq _ret
;----------------------------
	align cell_size
_nfa_assembler_last:
nfa_38:
	db	6,"opcode",0
	alignhe
	dq	nfa_37
	dq	_opcode_code
_opcode_code:
	call	_header
	mov	rax,[here_value]
	mov	qword [rax],op_compile_code
	call _pop
	mov cl,al
      ;  int 3
	mov rdx,[here_value]
	add rdx,cell_size
	mov [rdx],al
	inc rdx
	and rcx,0ffh
	add qword [here_value],16 ;ecx
       ; inc dword [here_value]
oc1:
	call _pop
	mov [rdx],al
	inc rdx
	loop oc1
	call _align
	ret

	align cell_size

op_compile_code:
	movzx rcx,byte [rax+cell_size]
	inc rax
	mov rdx,[here_value]
	add [here_value],rcx
occ1:
	mov bl,[rax+cell_size]
	mov [rdx],bl
	inc rax
	inc rdx
	dec cl
	jne occ1
	ret
;----------------------------
	align cell_size

nfa_39:
	db 8,"OpenFile",0
	alignhe
	dq nfa_35
	dq _openfile
_openfile:
      ;   int3
	call	_pop
	nop
	nop
	xor		r8,r8
	inc		rax
	mov		rdx,ofStruc
	mov		rcx,rax
	call		[OpenFile]
	mov		[handle],rax
	call		_push
      ;  call		 _push
      ;  push		 rax
      ;  call		 _hex_dot
      ;  pop		 rax
	ret

	align cell_size
handle	  dq  0
ofStruc:  db 136
	  db 0
	  dw 0
	  dw 0
	  dw 0
	  db 128 dup(0)

	align cell_size
filestruc:
subfun		     dq 0
file_pos	     dq 0
		     dd 0

		      db 0
fileptr 	     dq filename ;����� ����� ����� - 㪠��⥫� �� ��� 䠩��

;block_value:
;	dd 1 ;block number;
;	dd cell_size192 ;size of buffer;
;	dd 0ecell_size00h ;address of input buffer

;----------------------------

	align cell_size
nfa_40:
	db 8,"INCLUDE:",0
	alignhe
	dq nfa_39
	dq _load
_load:
	call _parse
	push qword [block]
	push qword [file_pos]
	push qword [fileptr] ;block number
	push qword [bytes_to_read] ; size of buffer
	push qword [buffer] ;address of buffer
	mov  rax,[buffer_base]
	mov  [buffer],rax
	inc  qword [block]

	push qword [_in_value]
	mov   rax,[here_value]
	call  _push_ascii
	mov   rax,[here_value]
	call  _push
	call  _openfile
	call  _push
	call _rdfile
   ;	 call _closefile

	xor rbx,rbx
	mov [_in_value],rbx
	mov qword [bytes_to_read],8192
	call _interpret


	pop qword [_in_value]
	pop qword [buffer]
	pop qword [bytes_to_read]
	pop qword [fileptr]
	pop qword [file_pos]
	pop qword [block]
	call _pop_ascii
	mov  rax,[block]
	test rax,rax
	je   _block0
	mov   rax,[here_value]
	call  _push
	call  _openfile
	call  _push
	call _rdfile
   ;	 call _closefile
	ret

_block0:
ret

_push_ascii:
       nop
    ;	int3
       nop
       nop
	xor	rcx,rcx
	mov rsi,[here_value]
	mov cl,[rsi]
	inc rsi
	mov rbx,rcx
	mov rdi,[push_ascii_stack]
	mov rax,rdi
	cld

_push_asciiz1:
	rep movsb
	mov	[rdi],bl
	inc	rdi
	mov  [push_ascii_stack],rdi
	sub  rdi,rbx
	dec  rdi
	dec  rdi
	mov  [pop_ascii_stack],rdi
	ret

_pop_ascii:
	nop
     ;	 int3
	nop
	nop
	nop
	mov rdi,[here_value]
	xor rcx,rcx
	mov rsi,[pop_ascii_stack]
	mov  cl,[rsi]
	mov  [rdi],cl
	mov  rax,rsi
	sub  rsi,rcx
	mov  rbx,rsi

	inc  rdi
	cld
	rep	movsb
	dec	rbx
	inc	rax
	mov  [pop_ascii_stack],rbx
;	 add	 rsi,rax
	mov  [push_ascii_stack],rax
	ret

	push_ascii_stack dq 0
	pop_ascii_stack dq  0
heap_base		dq 0
;----------------------------

	align cell_size
nfa_41:
	db 6,"rdfile",0
	alignhe
	dq nfa_40
	dq _rdfile
_rdfile:

	call	_pop
	sub	rsp,30h
	mov	rcx,rax
	xor	rax,rax
	mov	[bytes_to_read],rax
	mov	r9,bytes_to_read
	mov	r8,  8192
	mov	rdx, [buffer]

	xor	rax,rax
	mov	qword [rsp+20h],0
	call	[ReadFile]
	add	rsp,30h

       ; call	 [GetLastError]
	mov	 rax,[bytes_to_read]
	sub	 rax,8192
	jb	_rd2

	call	_push
	call	_hex_dot
	ret
_rd2:
	mov	rax,[handle]
	call	_push
	call	_closefile
	ret


 msg_err db 10,13, " Filesystem error!  ",0
 msg_load db 10,13, "  Loading file:",0

;----------------------------
	align cell_size
nfa_42:
	db 8,"CloseFile",0
	alignhe
	dq nfa_41
	dq _closefile

_closefile:
	call		_pop
	mov		rcx,rax
	call		[CloseFile]
	mov		rax,0xaabbccdd
	call		_push
	call		_hex_dot
	ret

;----------------------------
	align cell_size
nfa_43:
	 db	   4,"TYPE",0
	 alignhe
	 dq nfa_42
	 dq _typez
_typez:
;int 3
	 call	_pop
	 movzx	rcx,byte [rax]
	 inc	rax


	 mov	[symbols],rcx

	 xor	 r9,r9
	 mov	 r8,[symbols]
	 mov	 rdx,rax
	 mov	 rcx,[hStdout]
	 call	 [WriteConsole]
	 ret


symbols 	dq 0
hStdout 	dq  0

position	dd 0


;----------------------------

	align cell_size
nfa_44:
	db 2,"h.",0
	alignhe
	dq nfa_43
	dq _hex_dot

_hex_dot:
	call	_pop
	mov	[value],rax
	movdqu xmm0, [value] ;
	pxor xmm1,xmm1
	punpcklbw xmm0,xmm1 ; interleave bytes of value with nulls 
	movdqa xmm1,xmm0 ; copy
	pand xmm1,[fes] ; mask tetrades xmm1 - low tetrades
	psllq xmm0,4 ; 
	pand xmm0,[fes] ; xmm0 - high tetrades
	por xmm0,xmm1 ; assembly tetrades
	movdqa xmm1,xmm0 
	paddb xmm1,[sixes] ;
	psrlq xmm1,4
	pand xmm1,[fes]
	pxor xmm9,xmm9
	psubb xmm9,xmm1
	pand xmm9,[sevens]
	paddb xmm0,xmm9
	paddb xmm0,[zeroes]

	movdqu [hexstr],xmm0

	mov	rax,[hexstr]
	mov	r15,[hexstr+8]
	bswap	rax
	bswap	r15
	mov	[hexstr],r15
	mov	[hexstr+8],rax
	mov	byte [hexstr+17],0
      ;  call	 _space
      mov	 rax,hexstr-1
      call	 _push
 ;	 mov	 rsi,hexstr
;	 mov	 rcx,16
       call    _typez
       ; call	 _space
	ret
	align 16

sevens: dq	0707070707070707h
	dq	0707070707070707h
 db 18
hexstr:        db 32 dup 0

;--------------------
	align cell_size


nfa_48:
	db 5,"(LIB)",0
	alignhe
	dq nfa_44
	dq _lib
_lib:

	call	 _pop
	sub	 rsp,30h
	mov	 rcx,rax ;dllname
	call	 [LoadLibrary]
	add	 rsp,30h
	mov	 [dllhandl],rax
  ;	 call	  _push
	ret
	align cell_size
dllhandl dq	 0

nfa_last:
nfa_49:
	db 11,"(SetModule)",0
	alignhe
	dq nfa_48
	dq _setmodule
_setmodule:
	call	_pop ;modulename
	sub	 rsp,30h
	mov	 rcx,[dllhandl]
	mov	 rdx,rax
	mov	 rsi,[GetProcAddress]
	call	 rsi
	add	 rsp,30h
	call	 _push
	ret

	 align cell_size
_here:
	db 19,'Interpret worlink',10,13
align 1024
;---------------------------------------------------------------------
;---  ������ ���������	----------------------------------------------
;---------------------------------------------------------------------
msgforth	db 29,10,13, 'Hi there, it is Forth64! ',10,13,0

filename2 db '  INCLUDE: Loads.f       ',0
filename  db 7,'Loads.f',0
dllname   db   'KERNEL32.DLL',0 ;   'USER32.DLL',0   ;
fname	  db   'Sleep',0 ;'MessageBoxA',0 ;	  'Beep',0 ;
faddr	  dq 0
mtext	  db  'sjkfhsk',0
crlf	  db 2,10,13
msgsp	  db 4,' SP:'
impormsg  db 6,'impor:'
codemsg   db 4,'Code:'



entry start



  start:
	sub	rsp,cell_size*5 	; reserve stack for API use and make stack dqword aligned
 ;--------import dll-----
	mov	 rcx,dllname
	call	 [LoadLibrary]
	mov	 rcx,rax
	mov	 rdx,fname
	call	 [GetProcAddress]
	mov	 [faddr],rax
     ;	 mov	  rax,rcx
	xor	 r9,r9
	xor	 r8,r8
	mov	 rdx, mtext
	xor	 rcx,rcx
;	  mov	   rcx,100
	call	  [faddr]
	call	[AllocConsole]
	;--------get stdout handler-------------
       mov     rcx,-11
       call    [GetStdHandle]
      mov    [hStdout],rax
	;-------get stdin handler----------------
       ; mov	 rcx,-10
	;call	 [GetStdHandle]
	;mov	[hStdin],rax
	;--------alloc far---
	mov	       r9,0x40
	mov	       r8,0x3000
	mov	       rdx,65535
	mov	       rcx,0x13000
    ;	 call		[VirtualAlloc]
	;--------alloc data stack---
	mov	       r9,0x40
	mov	       r8,0x3000
	mov	       rdx,65536
	xor	       rcx,rcx
	call	       [VirtualAlloc]
	mov	       [stack_base],rax
	call	       _push
	call	       _hex_dot
	 ;--------alloc heap ---
	mov	       r9,0x40
	mov	       r8,0x3000
	mov	       rdx,65536
	xor	       rcx,rcx
	call	       [VirtualAlloc]
	mov	       [heap_base],rax
	 mov		[push_ascii_stack],rax
	  mov		 [pop_ascii_stack],rax
	call	       _push
	call	       _hex_dot
	;--------alloc buffer---
	mov	       r9,0x40
	mov	       r8,0x3000
	mov	       rdx,65536
	xor	       rcx,rcx
	call	       [VirtualAlloc]
	mov	       [buffer_base],rax
	mov	       [buffer],rax


	call	       _push
	call	       _hex_dot
	;-------move first include------------
	mov	     rcx,3
	mov	     rdi,[buffer]
	mov	     rsi,filename2
	rep	     movsq
 ;	 xor	      rcx,rcx
 ;	 mov	      rdi,[push_ascii_stack]
 ;	 mov	      rsi,filename
 ;	 mov	      cl,[rdi]
;	 cld
 ;	 rep	      movsb
   ;	 mov	      [push_ascii_stack],rdi

   ;	 mov	      rax,filename
   ;	 call	      _push
   ;	 call	      _openfile2
   ;	  mov	       rax,filename
   ;	 call	      _push
   ;	 call	      _openfile2
   ;	 call	      _pop
   ;	 mov	      rcx,rax
   ;	 xor	      rax,rax
   ;	 push	      rax
   ;	 mov	      rdx,[buffer]
   ;	 mov	      r8,8192
   ;	 mov	      r9,bytes_to_read
   ;	 call	      [ReadFile]


      ;  jmp $
	;--------jmp to interpret-------------
	push   qword _quit_forth
	jmp	  _interpret


 ;
	;----------open file-------
_openfile2:


db	 0x200000 dup  (?)
