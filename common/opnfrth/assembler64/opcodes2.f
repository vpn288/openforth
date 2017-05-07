ASSEMBLER CURRENT !  ASSEMBLER CONTEXT	!



0x D2 0x FF 0x 2 opcode call_rdx
0x 12 0x FF 0x 2 opcode call_[rdx]


0x 05 0x 48 0x 2 opcode add_rax,d#
0x 25 0x 48 0x 2 opcode and_rax,d#
0x C8 0x 21 0x 48 0x 3 opcode and_rax,rcx 
0x C8 0x 87 0x 48 0x 3 opcode xchg_rax,rcx

0x 48 0x 48 0x 2 opcode dec_rax

0x 50 0x 41 0x 2 opcode push_r8
0x 51 0x 41 0x 2 opcode push_r9
0x 53 0x 41 0x 2 opcode push_r11

0x 58 0x 41 0x 2 opcode pop_r8
0x 58 0x 41 0x 2 opcode pop_r9
0x 5B 0x 41 0x 2 opcode pop_r11

0x D9 0x F7 0x 48 0x 3 opcode neg_rcx


0x C9 0x 0F 0x 2 opcode bswap_ecx
0x CA 0x 0F 0x 2 opcode bswap_edx
0x 31 0x 0F 0x 2 opcode rdtsc
0x A2 0x 0F 0x 2 opcode cpuid
0x 32 0x 0F 0x 2 opcode rdmsr

0x 98 0x 48 0x 2 opcode cdqe 

0x C0 0x C1 0x 48 0x 3 opcode rol_rax,#

      0x E0 0x D1 0x 2 opcode shl_eax,1
      0x E0 0x C0 0x 2 opcode shl_al,#
      0x E2 0x C0 0x 2 opcode shl_dl,#
0x E0 0x C1 0x 48 0x 3 opcode shl_rax,#
      0x E1 0x C1 0x 2 opcode shl_ecx,#
0x E8 0x D1 0x 48 0x 3 opcode shr_rax,1

      0x E8 0x C0 0x 2 opcode shr_al,#
      0x EB 0x C1 0x 2 opcode shr_ebx,# 
0x E9 0x C1 0x 48 0x 3 opcode shr_rcx,#
      0x EE 0x C1 0x 2 opcode shr_esi,#
      0x E9 0x C0 0x 2 opcode shr_cl,#

0x C1 0x 88 0x 2 opcode mov_cl,al
0x E5 0x 88 0x 2 opcode mov_ch,ah
0x E0 0x 88 0x 2 opcode mov_al,ah
0x F8 0x 88 0x 2 opcode mov_al,bh 
0x C8 0x 88 0x 2 opcode mov_al,cl
0x E8 0x 88 0x 2 opcode mov_al,ch
0x C4 0x 88 0x 2 opcode mov_ah,al
0x E7 0x 88 0x 2 opcode mov_bh,ah 
0x CC 0x 88 0x 2 opcode mov_ah,cl
0x EC 0x 88 0x 2 opcode mov_ah,ch
0x 93 0x 88 0x 2 opcode mov_[ebx+],dl
0x C4 0x 86 0x 2 opcode xchg_al,ah
0x A5 0x 48 0x 2 opcode movsq
0x A4 0x F3 0x 2 opcode rep_movsb
0x AA 0x F3 0x 2 opcode rep_stosb
0x AB 0x 66 0x 2 opcode stosw
0x D8 0x 01 0x 2 opcode add_eax,ebx
0x C8 0x 01 0x 48 0x 3 opcode add_rax,rcx

0x C6 0x 01 0x 2 opcode add_esi,eax
0x C7 0x 01 0x 2 opcode add_edi,eax
0x CF 0x 01 0x 2 opcode add_edi,ecx
0x C1 0x 81 0x 2 opcode add_ecx,# 
0x C6 0x 81 0x 48 0x 3 opcode add_rsi,d#
0x C7 0x 83 0x 2 opcode add_edi,b#
0x 03 0x 01 0x 2 opcode add_[ebx],eax
0x 01 0x 01 0x 2 opcode add_[ecx],eax
0x 05 0x 01 0x 2 opcode add_[],eax
0x CB 0x 21 0x 2 opcode and_ebx,ecx
0x E3 0x 81 0x 2 opcode and_ebx,#
0x E1 0x 81 0x 48 0x 3 opcode and_rcx,d#

0x E1 0x 80 0x 2 opcode and_cl,#
0x D8 0x 29 0x 2 opcode sub_eax,ebx
0x F8 0x 29 0x 2 opcode sub_eax,edi

0x 05 0x 2B 0x 2 opcode sub_eax,[]
0x E9 0x 83 0x 2 opcode sub_ecx,b#

0x C1 0x 29 0x 2 opcode sub_ecx,eax
0x 05 0x 29 0x 2 opcode sub_[],eax

0x EC 0x 81 0x 48 0x 3 opcode sub_rsp,w# 

0x 05 0x FF 0x 2 opcode inc_d[]
0x 0D 0x FF 0x 2 opcode dec_d[]

0x C0 0x 30 0x 2 opcode xor_al,al
0x DB 0x 31 0x 2 opcode xor_ebx,ebx
0x C9 0x 31 0x 2 opcode xor_ecx,ecx

0x F6 0x 31 0x 48 0x 3 opcode xor_rsi,rsi
0x D8 0x 31 0x 2 opcode xor_eax,ebx
0x E8 0x 31 0x 2 opcode xor_eax,ebp
0x D2 0x 30 0x 2 opcode xor_dl,dl
0x 35 0x 81 0x 2 opcode xor_d[],#
0x C8 0x 09 0x 48 0x 3 opcode or_rax,rcx
0x E8 0x 09 0x 2 opcode or_eax,ebp
0x C3 0x 09 0x 2 opcode or_ebx,eax 
0x C1 0x 09 0x 48 0x 3 opcode or_rcx,rax
0x C2 0x 08 0x 2 opcode or_dl,al
0x C9 0x 80 0x 2 opcode or_cl,#
0x 05 0x 09 0x 2 opcode or_[],eax
0x 0D 0x 81 0x 2 opcode or_d[],#
0x 25 0x 81 0x 2 opcode and_d[],#

0x F8 0x 39 0x 2 opcode cmp_eax,edi

0x F0 0x 39 0x 48 0x 3 opcode cmp_rax,rsi
0x FB 0x 81 0x 2 opcode cmp_ebx,#

0x 3D 0x 81 0x 2 opcode cmp_d[],#
0x C0 0x 84 0x 2 opcode test_al,al
0x C0 0x 85 0x 2 opcode test_eax,eax
0x 60 0x E4 0x 2 opcode in_al,60h                
                0x 64 0x E4 0x 2 opcode in_al,64h                
                0x 64 0x E6 0x 2 opcode out_64h,al               
                0x EF 0x 66 0x 2 opcode out_dx,ax                
                0x ED 0x 66 0x 2 opcode in_ax,dx                 


                0x 82 0x 0F 0x 2 opcode jb                       
                0x 83 0x 0F 0x 2 opcode jnb                      
                0x 84 0x 0F 0x 2 opcode je                       
                0x 85 0x 0F 0x 2 opcode jne                      


                           
                0x EE 0x D9 0x 2 opcode fldz                     
                         
 0x 00 0x 6F 0x 0F 0x F3 0x 4 opcode movdqu_xmm0,[rax]
	0x 08 0x 6F 0x 0F 0x F3 0x 4 opcode movdqu_xmm1,[rax]
	0x 10 0x 6F 0x 0F 0x F3 0x 4 opcode movdqu_xmm2,[rax]
	0x 20 0x 6F 0x 0F 0x F3 0x 4 opcode movdqu_xmm4,[rax]
	0x 68 0x 6F 0x 0F 0x F3 0x 4 opcode movdqu_xmm5,[rax+b#]
	0x 35 0x 6F 0x 0F 0x F3 0x 4 opcode movdqu_xmm6,[]
	0x 3D 0x 6F 0x 0F 0x F3 0x 4 opcode movdqu_xmm7,[]
	
	0x 00 0x 7F 0x 0F 0x F3 0x 4 opcode movdqu_[rax],xmm0
	0x 08 0x 7F 0x 0F 0x F3 0x 4 opcode movdqu_[rax],xmm1
	0x 08 0x 7F 0x 0F 0x F3 0x 4 opcode movdqu_[rax],xmm2
	
	0x 68 0x 7F 0x 0F 0x F3 0x 4 opcode movdqu_[rax+b#],xmm5
	
	0x C0 0x EF 0x 0F 0x 66 0x 4 opcode pxor_xmm0,xmm0
	0x C9 0x EF 0x 0F 0x 66 0x 4 opcode pxor_xmm1,xmm1
	0x DB 0x EF 0x 0F 0x 66 0x 4 opcode pxor_xmm3,xmm3
	0x FF 0x EF 0x 0F 0x 66 0x 4 opcode pxor_xmm7,xmm7
	
	
	0x C1 0x EB 0x 0F 0x 66 0x 4 opcode por_xmm0,xmm1
	0x EE 0x EB 0x 0F 0x 66 0x 4 opcode por_xmm5,xmm6
	
	0x D9 0x F8 0x 0F 0x 66 0x 4 opcode psubb_xmm3,xmm1
	0x FE 0x F8 0x 0F 0x 66 0x 4 opcode psubb_xmm7,xmm6
	
	0x D1 0x FA 0x 0F 0x 66 0x 4 opcode psubd_xmm2,xmm1 
	
	0x C3 0x FC 0x 0F 0x 66 0x 4 opcode paddb_xmm0,xmm3
	0x EA 0x FC 0x 0F 0x 66 0x 4 opcode paddb_xmm5,xmm2
	0x EF 0x FC 0x 0F 0x 66 0x 4 opcode paddb_xmm5,xmm7
	
	0x C1 0x 60 0x 0F 0x 66 0x 4 opcode punpcklbw_xmm0,xmm1
	0x E9 0x 60 0x 0F 0x 66 0x 4 opcode punpcklbw_xmm5,xmm1
	0x C8 0x 6F 0x 0F 0x 66 0x 4 opcode movdqa_xmm1,xmm0
	0x EE 0x 7F 0x 0F 0x 66 0x 4 opcode movdqa_xmm6,xmm5
	0x 00 0x 6F 0x 0F 0x 66 0x 4 opcode movdqa_xmm0,[eax]
	0x 83 0x 7F 0x 0F 0x 66 0x 4 opcode movdqa_[ebx][],xmm0
	0x 0D 0x DB 0x 0F 0x 66 0x 4 opcode pand_xmm1,[]
	0x CA 0x DB 0x 0F 0x 66 0x 4 opcode pand_xmm1,xmm2
	0x 05 0x DB 0x 0F 0x 66 0x 4 opcode pand_xmm0,[]
	0x C2 0x DB 0x 0F 0x 66 0x 4 opcode pand_xmm0,xmm2
	0x 1D 0x DB 0x 0F 0x 66 0x 4 opcode pand_xmm3,[]
	0x DA 0x DB 0x 0F 0x 66 0x 4 opcode pand_xmm3,xmm2
	0x EA 0x DB 0x 0F 0x 66 0x 4 opcode pand_xmm5,xmm2
	0x F2 0x DB 0x 0F 0x 66 0x 4 opcode pand_xmm6,xmm2
	0x FA 0x DB 0x 0F 0x 66 0x 4 opcode pand_xmm7,xmm2
	
	0x 0D 0x FC 0x 0F 0x 66 0x 4 opcode paddb_xmm1,[]
	0x CC 0x FC 0x 0F 0x 66 0x 4 opcode paddb_xmm1,xmm4
	0x 05 0x FC 0x 0F 0x 66 0x 4 opcode paddb_xmm0,[]
	0x C2 0x FC 0x 0F 0x 66 0x 4 opcode paddb_xmm0,xmm2
    0x F4 0x FC 0x 0F 0x 66 0x 4 opcode paddb_xmm6,xmm4
              
	0x CA 0x 1E 0x 38 0x 0F 0x 66 0x 5 opcode pabsd_xmm1,xmm2 
    0x CA 0x 02 0x 38 0x 0F 0x 66 0x 5 opcode phaddd_xmm1,xmm2 	
	
EXIT  
