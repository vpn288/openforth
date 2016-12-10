  use32 	     ; ������� 32-���� ०�� ��ᥬ����
  org	 0x0	     ; ������ � ���

  db	 'MENUET01'  ; 8-����� �����䨪��� MenuetOS
  dd	 0x01	     ; ����� ��������� (�ᥣ�� 1)
  dd	 START	     ; ���� ��ࢮ� �������
  dd	 I_END	     ; ࠧ��� �ணࠬ��
  dd	 0x100000      ; ������⢮ �����
  dd	 0x100000      ; ���� ���設� �����
  dd	 0x0	     ; ���� ���� ��� ��ࠬ��஢
  dd	 0x0f0000	; ����

include "macros.inc" ; ������ �������� ����� ��ᥬ����騪��!

macro alignhe
{ virtual
align 4
algn = $ - $$
end virtual
db algn dup 0
}

win_width=600
win_height=300
cell_size = 4
data_stack_base = 0e0000h
buffer_base = 0d0000h
return_stack = 0f0000h

;---------------------------
; vocabulary start
;---------------------------
    align 4
nfa_0:
	db 7, "FORTH32",0
	alignhe
	dd nfa_1 ;LFA
	dd _vocabulary ;CFA
f32_list:
	dd nfa_last ;PFA - oeacaoaeu ia eoa iineaaiaai ii?aaaeaiiiai neiaa
_vocabulary:
	add eax,cell_size
	call _push
	ret
;----------------------------
	align 4
nfa_1:
	db 7,"BADWORD",0
	alignhe
	dd 0 ; zero LFA. End of search or link winth another vocabulary if not zero
	dd _vect
	dd abort_
_vect:
	mov eax,[eax+cell_size]
	call dword [eax]
	ret
;----------------------------
	align 4
nfa_2:
	db 4,"EXIT",0
	alignhe
	dd nfa_0
ret_:
	dd _ret
	_ret:
	pop eax
	pop eax
	ret
;----------------------------
	align 4
nfa_3:
	db 4,"Push",0
	alignhe
	dd nfa_2
	dd _push
_push:
	mov ebx,[stack_pointer]
	add ebx , cell_size
	and ebx , [data_stack_mask]
	mov [ ebx+data_stack_base ] , eax
	mov [stack_pointer],ebx
	ret
data_stack_mask dd 0x00ffff
stack_pointer dd 0
;----------------------------
	align 4
nfa_4:
	db 5,"ABORT",0
	alignhe
	dd nfa_3
abort_:
	dd _abort
_abort:
	mov eax,msgbad
	call _push
	call _type
	mov eax,[here_value]
	call	_push
	call	_type
	mcall 5,1000
	mov    eax,msgabort
	call _push
	call _typez
	jmp _ret

msgbad db 9," Badword: "
msgabort db " Abort!",0
;----------------------------
	align 4
nfa_5:
	db 4,"HERE",0
	alignhe
	dd nfa_4
	dd _constant
here_value:
	dd _here
_constant:
	mov eax,[eax+4]
	call _push
	ret

;----------------------------
	align 4
nfa_7:
	db 3,"Pop",0
	alignhe
	dd nfa_5	;nfa_6
	dd _pop
_pop:
	mov ebx,[stack_pointer]
	mov eax , [ ebx+data_stack_base]
	sub ebx , 4
	and ebx , [data_stack_mask]
	mov [stack_pointer],ebx
	ret
;----------------------------
	align 4
nfa_8:
	db 9,"INTERPRET",0
	alignhe
	dd nfa_7
	dd _interpret
_interpret:

	call _parse
   ; mov eax,[here_value]
   ; call       _push ; debug
   ; call _type
	mov eax,context_value
	call _push
	call _fetch
	call _sfind
	call _execute_code
	jmp _interpret

;----------------------------
	align 4
nfa_9:
	db 5,"PARSE",0
	alignhe
	dd nfa_8
parse_:
	dd _parse
_parse:
	mov eax,[buffer] ;input buffer
	call _push
	mov eax,[here_value] ;here
	call _push
	call _enclose
	ret
;----------------------------
	align 4
nfa_10:
	db 7,"CONTEXT",0
	alignhe
	dd nfa_9
context_:
	dd _variable_code
	context_value:
	dd f32_list
;--------------------------------
	align 4
nfa_11:
	db 7,"ENCLOSE",0
	alignhe
	dd nfa_10
	dd _enclose
_enclose:
	call _pop ; to address
	mov edi,eax
	call _pop ; from address
	mov esi,eax
	xor edx,edx
	add esi,[_in_value]
	mov ebx,edi
; clear 32 bytes
	xor eax,eax
	mov ecx,8
	cld
	rep stosd
	mov edi,ebx
	mov ecx,[bytes_to_read] ; size of buffer
	cmp ecx,edx
	jl _word2 ;jl
	inc edi
_skip_delimeters:
	sub dword [bytes_to_read],1 ; [nkey],1
	jb _word2
	lodsb
	inc dword [_in_value]
	cmp al,20h
	jbe _skip_delimeters
_word3:
	stosb
	inc edx
	sub dword [bytes_to_read],1 ; [nkey],1
	jb _word4
	lodsb
	inc dword [_in_value]
	cmp al,20h
	jnbe _word3
_word4:
; string to validate
	 mov [ebx],dl
	 ret
_word2:
; empty string
	 mov dword [ebx],49584504h ;4,"EXI"
	 mov dword [ebx+4],054h ;"T",0
	 ret
;----------------------------
	align 4
nfa_12:
	db 1,"@",0
	alignhe
	dd nfa_11
fetch_:
	dd _fetch
_fetch:
	call _pop
	mov eax,[eax]
	call _push
	ret
;----------------------------
	align 4
nfa_13:
	db 5,"SFIND",0
	alignhe
	dd nfa_12
sfind_:
	dd _sfind
_sfind:
	call _pop
	mov esi,eax ;pop context
	mov esi,[esi] ;vocid
_find2:
	movzx ebx,byte [esi];word in vocab
	mov edx,ebx
	inc bl
	and bl,07ch ;mask immediate in counter
	mov eax,[here_value]
	mov	edi,eax
	movzx ecx,byte [edi] ; word on here
	shr ecx,2
	inc ecx
	mov ebp,esi
	mov eax,[edi]
find22:
	cld
	cmpsd
	jne _find11
	loop find22
	and edx,3
	cmp edx,3
	jne find23
	add esi,4
find23:
	mov eax,esi
	add eax,4
	call _push
	ret ;word found

_find11:
	mov esi,ebp
	add esi,4
	add esi,ebx
	mov ecx,esi
	mov esi,[esi]
_find4:
	test esi,esi
	jne _find2
	mov eax,ecx
	add eax,4
	call _push
	ret ; badword
;----------------------------
	align 4
nfa_14:
	db 7,"EXECUTE",0
	alignhe
	dd nfa_13
	dd _execute_code
_execute_code:
	call _pop
_execute:
	call dword [eax]
	ret
;----------------------------
	align 4
nfa_15:
	db 9,"filestruc",0
	alignhe
	dd nfa_14
block_:
	dd _variable_code
	_variable_code:
	add eax,cell_size
	call _push
	ret
 align 4
filestruc:
subfun		     dd 0
file_pos	     dd 0
			 dd 0
bytes_to_read	 dd 8192 ;size of buffer
buffer		     dd buffer_base  ;address of input buffer
			 db 0
fileptr 	     dd filename ;����� ����� ����� - 㪠��⥫� �� ��� 䠩��

;block_value:
;       dd 1 ;block number;
;       dd 8192 ;size of buffer;
;       dd 0e800h ;address of input buffer

;----------------------------
	align 4
nfa_17:
	db 3,">IN",0
	alignhe
	dd nfa_15	; nfa_16
	dd _variable_code
_in_value:
	dd 0
;----------------------------
	align 4
nfa_18:
	db 8,"INCLUDE:",0
	alignhe
	dd nfa_17
	dd _load
_load:

   ; mov           eax,fileptr ;for debug
 ;  int 3
   ;call _push_asciiz
	;
	push dword [file_pos]
	;push dword [fileptr] ;block number
	push dword [bytes_to_read] ; size of buffer
	push dword [buffer] ;address of buffer

	call _parse
	push dword [_in_value]
	mov   eax,[here_value]
	inc   eax
	mov   [fileptr],eax
    call  _push_asciiz
	call _rdfile

	xor ebx,ebx
	mov [_in_value],ebx
	mov dword [bytes_to_read],8192
	call _interpret

	pop dword [_in_value]
	pop dword [buffer]
	pop dword [bytes_to_read]
	;pop dword [fileptr]
	pop dword [file_pos]
;        int 3
;        int 3
	call _pop_asciiz
	mov	eax,[here_value]
	mov [fileptr],eax
	call _rdfile
	ret

_push_asciiz:
;int 3
	xor	ecx,ecx
	mov esi,[fileptr]
	mov edi,[push_ascii_stack]
	cld
_push_asciiz1:
	lodsb
	stosb
	inc	ecx
	test al,al
	jne _push_asciiz1
	mov	[edi-1],cl

	mov  [push_ascii_stack],edi
      sub edi,ecx
	mov  [pop_ascii_stack],edi
	ret

_pop_asciiz:
;int 3
	mov edi,[here_value]
	dec edi
	mov esi,[pop_ascii_stack]
	dec esi
;        cmp     esi,
;        jb      _bye
	movzx	ecx, byte [esi]
	xor	al,al

	add	edi,ecx
	mov	edx,ecx
	mov	ebp,edi

_pop_asciiz1:
	std
	rep movsb
	mov	[ebp],al
	inc	esi
	mov  [pop_ascii_stack],esi
	add	esi,edx
 ;       dec   esi
	mov  [push_ascii_stack],esi

	ret

	push_ascii_stack dd return_stack
	pop_ascii_stack dd return_stack+8
;----------------------------
	align 4
nfa_19:
	db 6,"BUFFER",0
	alignhe
	dd nfa_18
buffer_:
	dd _constant
	dd buffer ;buffer_base
;----------------------------
	align 4
nfa_20:
	db 6,"rdfile",0
	alignhe
	dd nfa_19
	dd _rdfile
_rdfile:

	mcall 70,  filestruc

	test	eax,eax
	je     _rdok
	cmp	eax,6
	je	_rdok
	mov	eax,msg_err
       call    _push
       call    _typez
_rdok:
       mov     eax,msg_load
       call    _push
       call    _typez
       mov eax,[fileptr]
       call  _push
       call _typez
	ret
 msg_err db 10,13, " Filesystem error!  ",0
 msg_load db 10,13, "  Loading file:",0

;----------------------------
	align 4
nfa_21:
	db 7,"wrblock",0
	alignhe
	dd nfa_20
	dd _wrblock
_wrblock:
  ret
;----------------------------
	align 4
nfa_22:
	 db	   7,"dbgmsgz",0
	 alignhe
	 dd nfa_21
	 dd _typez
_typez:
;int 3
	 call	_pop
	 mov esi,eax
	 mov	cl,' '

 typez3:
	 mcall 63,1
	 mov cl,[esi]
	 inc	esi
	 test cl,cl
	 jne	typez3
	 ret

	 ;mov   edx,eax
	 ;mov   edi,eax
	 ;xor   eax,eax
	 ;xor   ecx,ecx
	 ;dec   ecx
	 ;cld
	 ;repne   scasb ;what is length?
	 ;neg   ecx
	 ;dec   ecx
	 ;dec   ecx

  ;       int    3

typez2:
	; shl   ecx,3+16
	; mov   eax,[position]
	; mov   ebx,eax
;        rol    eax,16
	; add   eax,ecx
;        rol    eax,16
    ; cmp eax,win_width*65536
	; jb  nonew_string
	; add eax,16
	; and eax,0ffffh
	; mov   ebx,eax
	 ;rol   eax,16
	; add   eax,ecx
	 ;rol   eax,16
nonew_string:
	; mov   [position],eax
	; mov ecx,0d0ffffffh ;color and attributes
	; mov edi,0 ; background color
	; mcall 4
	 ret


symbols dd 0
position	dd 0


	align	8
value:		dq	0;1234567890abcdefh
		dq	0 ;012345678h

zeroes: 	dq	3030303030303030h
		dq	3030303030303030h

sixes:		dq	0606060606060606h
		dq	0606060606060606h

fes:		dq	0x0f0f0f0f0f0f0f0f
		dq	0x0f0f0f0f0f0f0f0f

lowupmask:	dq	0xdfdfdfdfdfdfdfdf
		dq	0xdfdfdfdfdfdfdfdf


;-----------------------
	align 4
nfa_23:
	db	  3,"0xd",0
	alignhe
	dd nfa_22
	dd _0xd1
_0xd1:
	call	_number
	call	_0xd
	ret

_0xd:
	call		_pop
	mov		ebx,[eax+8]
	mov		ecx,[eax+12]
	bswap		ebx
	mov		edx,[eax+4]
	bswap		ecx
	mov		ebp,[eax]
	bswap		edx
	bswap		ebp
	mov		[eax+8],edx
	mov		[eax+12],ebp
	mov		[eax+4],ebx
	mov		[eax],ecx
	movdqu		xmm0,[eax]
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
	mov		eax, dword  [value]
	call		_push
	mov		eax,dword[value+4]
	call		_push
	ret
;----------------------------
	align 4
nfa_24:
	db	  2,"0x",0
	alignhe
	dd nfa_23
	dd _0x
_0x:
	call	_0xd1
	call	_pop

	ret

bytemask:	dq	0ff00ff00ff00ffh
		dq	0ff00ff00ff00ffh

;----------------------------
	align 4
nfa_25:
	db	  6,"number",0
	alignhe
	dd nfa_24
	dd _number
_number:
   ;     int 3
	mov	esi,[buffer]
	xor	edx,edx
	add	esi,[_in_value]
	mov	edi,[here_value]
	mov	ebx,edi
	; fill 32 bytes with zeroes
	mov	eax,30303030h
	mov	ecx,8
	cld
	rep	stosd


	mov	edi,ebx
	mov	ecx,[bytes_to_read] ; [nkey]
	cmp	ecx,edx ; edx=0
	jl	number2

	inc	edi
_skip_delimeters2:

	sub	dword [bytes_to_read],1 ; [nkey],1
	je	number2
	lodsb
	inc	dword [_in_value]
	cmp	al,21h
	jb     _skip_delimeters2

	mov		edi,[here_value]
	add		edi,16
number3:
	; move to here +15
	stosb
	inc	edx
	sub	dword [bytes_to_read],1 ; [nkey],1
	jb	number4
	lodsb
	inc	dword [_in_value]
	cmp	al,20h
	ja     number3

number4:
	;normalize number
	; edx - count of digits
	sub		edi,16
	mov		eax,edi
	call	_push
	ret

number2:

	; empty string
   ;     mov     dword [ebx],2 ;dl
	mov	dword [_in_value],0
	ret
;--------------------
	align 4

nfa_26:
	db	1,",",0
	alignhe
	dd nfa_25
	dd _comma
_comma:
	mov	edx,[here_value]
	call	_pop
	mov	[edx],eax
	add	dword [here_value],cell_size
	ret

;--------------------
	align 4

nfa_27:
	db	8,"(HEADER)",0
	alignhe
	dd nfa_26
	dd _hheader
_hheader:
	mov	[esi],eax	;fill link field
	mov	ebx,[here_value]
	mov	eax,[current_value]
	mov	[eax],ebx	; here to latest
	add	esi,cell_size
	mov	[here_value],esi
	ret

;--------------------
	align 4

nfa_28:
	db	6,"N>LINK",0
	alignhe
	dd	nfa_27
nlink_:
	dd	_nlink
_nlink:
	call	_pop
	mov	esi,eax
	call	nlink2
	mov	eax,esi
	call	_push
	ret

nlink2:
	movzx	ebx,byte [esi]
	inc	bl
	and	bl,07Ch
	add	esi,ebx
	add	esi,cell_size
	ret

;--------------------
	align 4

nfa_29:
	db	6,"LATEST",0
	alignhe
	dd	nfa_28
latest_:
	dd	_latest

_latest:
	call	latest_code2
	call	_push
	ret

latest_code2:
	mov	eax,[current_value]
	mov	eax,[eax] ; eax = latest nfa of curent vocabulary
	ret
;--------------------
	align 4
nfa_30:
	db	1,"'",0
	alignhe
	dd	nfa_29
	dd	_addr_interp
	dd	parse_
	dd	context_
	dd	fetch_
	dd	sfind_
	dd	ret_

;----------------------------
	align 4

nfa_31:
	db 7,"CURRENT",0
	alignhe
	dd nfa_30
current_:
	dd _variable_code
current_value:
	dd f32_list
;--------------------------------
	align 4
nfa_32:
	db	10,"interpret#",0
	alignhe
	dd	nfa_31
	dd	_constant
	dd	_addr_interp
_addr_interp:
	add eax,4
	push eax
	mov eax,[eax]
	call near dword [eax]
	pop eax
	jmp _addr_interp

;--------------------------------
	align 4

nfa_33:
	db	5,"CELL+",0
	alignhe
	dd	nfa_32
cellp_:
	dd	_cellp
_cellp:
	call	_pop
	add	eax,cell_size
	call	_push
	ret
;--------------------------------
	align 4

nfa_34:
	db	5,"ALIGN",0
	alignhe
	dd	nfa_33
align_:
	dd	_align

_align:
	mov	eax,[here_value]
	and    eax,3
	setne  al
	and    dword [here_value],0fffffffch
	shl    al,2
	add    [here_value],eax
	ret
;----------------------------

_align2:
	xor	ebx,ebx
	and    eax,3
	setne  bl
	and    eax,0fffffffch
	shl    bl,2
	add    eax,ebx
	ret

;----------------------------
	align 4

nfa_35:
	db	1,"!",0
	alignhe
	dd	nfa_34
	dd	_store

_store:
	call	_pop	; address
	mov		edx,eax
	call	_pop	;data
	mov		[edx],eax
	ret
;--------------------------------
	align 4

nfa_36:
	db	9,"ASSEMBLER",0
	alignhe
	dd     nfa_35
	dd     _vocabulary
	dd     _nfa_assembler_last
;----------------------------
	align 4
nfa_37:
	db 7,"BADWORD",0
	alignhe
	dd nfa_last ; zero LFA. End of search or link winth another vocabulary if not zero
	dd _vect
	dd abort_

;----------------------------
	align 4
nfa_38:

	db 4,"EXIT",0
	alignhe
	dd nfa_37
	dd _ret
;----------------------------
	align 4
_nfa_assembler_last:
nfa_39:
	db	6,"opcode",0
	alignhe
	dd	nfa_38
	dd	_opcode_code
_opcode_code:
	call	_header
	mov	eax,[here_value]
	mov	dword [eax],op_compile_code
	call _pop
	mov cl,al
      ;  int 3
	mov edx,[here_value]
	add edx,4
	mov [edx],al
	inc edx
	and ecx,0ffh
	add dword [here_value],16 ;ecx
       ; inc dword [here_value]
oc1:
	call _pop
	mov [edx],al
	inc edx
	loop oc1
	call _align
	ret

	align 4

op_compile_code:
	movzx ecx,byte [eax+cell_size]
	inc eax
	mov edx,[here_value]
	add [here_value],ecx
occ1:
	mov bl,[eax+cell_size]
	mov [edx],bl
	inc eax
	inc edx
	dec cl
	jne occ1
	ret
;----------------------------
	align 4

nfa_40:
	db	6,"UNLINK",0
	alignhe
	dd	nfa_36
	dd	_unlink

_unlink:
	call	_badword_xt
	call	_pop
	mov	 dword [eax-4],0
	ret

;----------------------------
	align 4

nfa_41:
	db	10,"BADWORD-xt",0
	alignhe
	dd	nfa_40
	dd	_badword_xt
_badword_xt:
	mov	edx,[here_value]
	mov	dword [edx], 44414207h
	mov	dword [edx+4],"WORD"
	mov	dword [edx+8],0
	call	_sfind
	ret
;----------------------------
	align 4

nfa_42:
	db	4,"LINK",0
	alignhe
	dd	nfa_41
	dd	_link
_link:
	call	_pop
	mov	ecx,[eax]
	push	ecx
	call	_badword_xt
	call	_pop
	pop	ebx
	mov	dword [eax-4],ebx
	ret
;----------------------------
	align 4

nfa_43:
	db 6,"(WORD)",0
	alignhe
	dd nfa_42
	dd _word
_word:
	call _pop ; to address
	mov edi,eax ;[here_value]
	call _pop ; from address
	mov esi,eax ;[block_value+8]
	call _pop	; symbol
	mov  [word_symb],al
	xor edx,edx
	add esi,[_in_value]
	mov ebx,edi
; clear 32 bytes
	xor eax,eax
	mov ecx,8
	cld
	rep stosd
	mov edi,ebx
	mov ecx,[bytes_to_read] ; size of buffer
	cmp ecx,edx
	jl _word42 ;jl
	inc edi
_word45:
	sub dword [bytes_to_read],1 ; [nkey],1
	jb _word42
	lodsb
	inc dword [_in_value]
	cmp al,[word_symb]
	je _word45
_word43:
	stosb
	inc edx
	sub dword [bytes_to_read],1 ; [nkey],1
	jb _word44
	lodsb
	inc dword [_in_value]
	cmp al,[word_symb]
	jne _word43
_word44:
; string to validate
	 mov [ebx],dl
	 ret
_word42:
; empty string
	 mov dword [ebx],49584504h ;4,"EXI"
	 mov dword [ebx+4],054h ;"T",0
	 ret
word_symb	db	20h
;--------------------------------
	align 4

nfa_44:
	db	6,"HEADER",0
	alignhe
	dd nfa_43
	dd _header
_header:
       ; call    _align
	call	_parse
	mov	esi,[here_value]
	call	nlink2		;esi - address of lf
	call	latest_code2	;eax - latest
	call	_hheader
	ret
;--------------------------------
	align 4
nfa_45:
	db 6,"dbgmsg",0
    alignhe
	dd nfa_44
	dd _type
 _type:
      ;type ascii with count
      call _pop
	  mov	esi,eax
      mov  ch,byte [esi]
type4:
      inc	esi
	  mov	cl,[esi]
	  mcall	63,1
	  dec	ch
	  jne	type4
	  ret
;--------------------
	align 4
nfa_last:
nfa_46:
	db 3,"BYE",0
    alignhe
	dd nfa_45
	dd _bye
_bye:
_quit_forth:
	mcall 5,1000
	mcall -1		; ���� ����� �ணࠬ��
	align 4
_here:
align 1024
;---------------------------------------------------------------------
;---  ������ ���������  ----------------------------------------------
;---------------------------------------------------------------------
START:
	mov	eax,_here
	;------------------
	;draw window
	;------------------
	mov ebx,win_width ;���� �� �=0 �ਭ�� 600
	mov ecx,win_height ;���� �� �=0 ���⮩ 300
	mov edx,030000000h   ;���� 䨪�஢����� ⨯ 1, �୮�
	mov esi,03f3f3fh ;梥� ���������
	mov edi,3f3f3fh ;梥� ࠬ��
       mcall 0
	;-----------------
	;parse home dir
	;-----------------
	std
	mov	edi,return_stack+1024
	mov ecx,1024
	rep scasb
	inc	edi
	mov	ecx,10
	xor	al,al
	rep	stosb
	cld
	;-----------------
	;set home dir
	;-----------------

	mcall	30,1,return_stack,1024

	mov	eax,return_stack
	call   _push
	call   _typez
	mov esi,filename
	mov edi,buffer_base
	cld
	mov ecx,5
	rep movsd
	;mov dword [fileptr],filename
	;call _rdfile

	xor ebx,ebx
	mov [_in_value],ebx
	mov dword [bytes_to_read],8192
	push	dword _quit_forth
	jmp _interpret

filename db   "INCLUDE: Loads.f",0





;---------------------------------------------------------------------

I_END:				 ; ��⪠ ���� �ணࠬ��
