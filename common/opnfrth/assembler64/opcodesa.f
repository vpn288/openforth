
ASSEMBLER CURRENT !  ASSEMBLER CONTEXT	!

          0x C0 0x 83 0x 48 0x 3 opcode add_rax,b# 
	  0x D8 0x 01 0x 48 0x 3 opcode add_rax,rbx
	  0x C8 0x 01 0x 48 0x 3 opcode add_rax,rcx
	  0x C1 0x 83 0x 48 0x 3 opcode add_rcx,b#
	  0x CC 0x 01 0x 48 0x 3 opcode add_rsp,rcx
          0x 02 0x 83 0x 48 0x 3 opcode add_[rdx],b# 
          0x 02 0x 01 0x 48 0x 3 opcode add_[rdx],rax
    0x 24 0x 44 0x 83 0x 48 0x 4 opcode add_q[rsp+b#],b#

                      0x 24 0x 1 opcode and_al,# 
          0x E0 0x 83 0x 48 0x 3 opcode and_rax,b# 
	        0x 25 0x 48 0x 2 opcode and_rax,d#
	  0x C8 0x 21 0x 48 0x 3 opcode and_rax,rcx 
          0x E3 0x 83 0x 48 0x 3 opcode and_rbx,b#
	  
	  0x C8 0x 0F 0x 48 0x 3 opcode bswap_rax
	  0x CB 0x 0F 0x 48 0x 3 opcode bswap_rbx
	  0x CA 0x 0F 0x 48 0x 3 opcode bswap_rdx
	  0x CE 0x 0F 0x 48 0x 3 opcode bswap_rsi

                      0x CC 0x 1 opcode int3
			
                0x D2 0x FF 0x 2 opcode call_rdx
			 
	              0x FC 0x 1 opcode cld
				   
    0x C6 0x 42 0x 0F 0x 48 0x 4 opcode cmovc_rax,rsi 					   
    0x CE 0x 44 0x 0F 0x 48 0x 4 opcode cmove_rcx,rsi
    0x CA 0x 43 0x 0F 0x 48 0x 4 opcode cmovnc_rcx,rdx
    0x CE 0x 45 0x 0F 0x 48 0x 4 opcode cmovne_rcx,rsi
 
          0x F0 0x 39 0x 48 0x 3 opcode cmp_rax,rsi
	  0x D1 0x 39 0x 48 0x 3 opcode cmp_rcx,rdx
 
                0x 48 0x 48 0x 2 opcode dec_rax
          0x C9 0x FF 0x 48 0x 3 opcode dec_rcx
	   
	  0x 23 0x DF 0x 41 0x 3 opcode fbld_[r11]
	  0x 33 0x DF 0x 41 0x 3 opcode fbstp_[r11]
	  0x 2B 0x DF 0x 41 0x 3 opcode fild_[r11] 
          0x 3B 0x DF 0x 41 0x 3 opcode fistp_[r11]  	   
	        0x EE 0x D9 0x 2 opcode fldz  
	   
          0x C0 0x FF 0x 48 0x 3 opcode inc_rax				   
	  0x C3 0x FF 0x 48 0x 3 opcode inc_rbx
          0x C1 0x FF 0x 48 0x 3 opcode inc_rcx		   
	  0x 02 0x FF 0x 48 0x 3 opcode inc_[rdx] 
	   
	        0x 82 0x 0F 0x 2 opcode jb 
                0x 83 0x 0F 0x 2 opcode jnb  			 
	   
	              0x AC 0x 1 opcode lodsb
				   
	        0x E0 0x 88 0x 2 opcode mov_al,ah
	        0x E8 0x 88 0x 2 opcode mov_al,ch
	        0x C4 0x 88 0x 2 opcode mov_ah,al
	        0x B8 0x 48 0x 2 opcode mov_rax,#			 
	  0x C8 0x 89 0x 48 0x 3 opcode mov_rax,rcx 
	  0x F0 0x 89 0x 48 0x 3 opcode mov_rax,rsi 
          0x D0 0x 89 0x 4C 0x 3 opcode mov_rax,r10
                0x A1 0x 48 0x 2 opcode mov_rax,[] 
          0x 00 0x 8B 0x 48 0x 3 opcode mov_rax,[rax]	   
	  0x 40 0x 8B 0x 48 0x 3 opcode mov_rax,[rax+b#]  
	  0x 01 0x 8B 0x 48 0x 3 opcode mov_rax,[rcx] 
    0x 24 0x 44 0x 8B 0x 48 0x 4 opcode mov_rax,[rsp+b#]
          0x CB 0x 89 0x 48 0x 3 opcode mov_rbx,rcx 
          0x 59 0x 8B 0x 48 0x 3 opcode mov_rbx,[rcx+b#]
                0x E5 0x 88 0x 2 opcode mov_ch,ah 
          0x C1 0x C7 0x 48 0x 3 opcode mov_rcx,d#	 
	        0x B9 0x 48 0x 2 opcode mov_rcx,#
          0x C1 0x 89 0x 48 0x 3 opcode mov_rcx,rax
    0x 24 0x 4C 0x 8B 0x 48 0x 4 opcode mov_rcx,[rsp+b#]
	  0x C7 0x 89 0x 48 0x 3 opcode mov_rdi,rax

	        0x BA 0x 48 0x 2 opcode mov_rdx,#
	  0x 51 0x 8B 0x 48 0x 3 opcode mov_rdx,[rcx+b#]	
			 
	         0x BE 0x 48 0x 2 opcode mov_rsi,#
       0x C6 0x 89 0x 48 0x 3 opcode mov_rsi,rax
       0x 71 0x 8B 0x 48 0x 3 opcode mov_rsi,[rcx+b#]
             0x BB 0x 49 0x 2 opcode mov_r11,#	   
	   0x 1A 0x 8B 0x 4C 0x 3 opcode mov_r11,[rdx]
	               0x A2 0x 1 opcode mov_[],al 
	         0x A3 0x 48 0x 2 opcode mov_[],rax
       0x 08 0x 89 0x 48 0x 3 opcode mov_[rax],rcx		   		  
 0x 1B 0x 14 0x 88 0x 42 0x 4 opcode mov_[rbx+r11],dl 
       0x 31 0x 89 0x 48 0x 3 opcode mov_[rcx],rsi
	   0x 41 0x 89 0x 48 0x 3 opcode mov_[rcx+b#],rax
	   0x 59 0x 89 0x 48 0x 3 opcode mov_[rcx+b#],rbx
       0x 51 0x 89 0x 48 0x 3 opcode mov_[rcx+b#],rdx 	   
             0x 06 0x 88 0x 2 opcode mov_[rsi],al  
 0x 24 0x 44 0x 89 0x 48 0x 4 opcode mov_[rsp+b#],rax
 0x 24 0x 4C 0x 89 0x 48 0x 4 opcode mov_[rsp+b#],rcx
	   0x 03 0x 88 0x 41 0x 3 opcode mov_[r11],al  
 0x 03 0x 89 0x 41 0x 66 0x 4 opcode mov_[r11],ax
       0x 03 0x 89 0x 41 0x 3 opcode mov_[r11],eax 
	   
 0x C8 0x 6F 0x 0F 0x 66 0x 4 opcode movdqa_xmm1,xmm0
 0x EE 0x 7F 0x 0F 0x 66 0x 4 opcode movdqa_xmm6,xmm5
 0x 00 0x 6F 0x 0F 0x F3 0x 4 opcode movdqu_xmm0,[rax]
 0x 08 0x 6F 0x 0F 0x F3 0x 4 opcode movdqu_xmm1,[rax]
 0x 10 0x 6F 0x 0F 0x F3 0x 4 opcode movdqu_xmm2,[rax]
 0x 20 0x 6F 0x 0F 0x F3 0x 4 opcode movdqu_xmm4,[rax]
 0x 68 0x 6F 0x 0F 0x F3 0x 4 opcode movdqu_xmm5,[rax+b#]
 0x 00 0x 7F 0x 0F 0x F3 0x 4 opcode movdqu_[rax],xmm0
 0x 68 0x 7F 0x 0F 0x F3 0x 4 opcode movdqu_[rax+b#],xmm5

             0x A5 0x 48 0x 2 opcode movsq	   

 0x 00 0x B6 0x 0F 0x 48 0x 4 opcode movzx_rax,b[rax]
 0x 58 0x B6 0x 0F 0x 48 0x 4 opcode movzx_rbx,b[rax+b#] 
 0x 08 0x B6 0x 0F 0x 48 0x 4 opcode movzx_rcx,b[rax]
 0x 0E 0x B6 0x 0F 0x 48 0x 4 opcode movzx_rcx,b[rsi]
 
       0x D8 0x F7 0x 48 0x 3 opcode neg_rax
	   0x D9 0x F7 0x 48 0x 3 opcode neg_rcx
	   
	               0x 90 0x 1 opcode nop 
	   0x D0 0x F7 0x 48 0x 3 opcode not_rax
	   
               
            0x F0 0x 09 0x 48 0x 3 opcode or_rax,rsi
                  0x C2 0x 08 0x 2 opcode or_dl,al			
			
	  0x C2 0x FC 0x 0F 0x 66 0x 4 opcode paddb_xmm0,xmm2	
	  0x C3 0x FC 0x 0F 0x 66 0x 4 opcode paddb_xmm0,xmm3
	  0x CC 0x FC 0x 0F 0x 66 0x 4 opcode paddb_xmm1,xmm4
	  0x EA 0x FC 0x 0F 0x 66 0x 4 opcode paddb_xmm5,xmm2
	  0x EF 0x FC 0x 0F 0x 66 0x 4 opcode paddb_xmm5,xmm7
      0x F4 0x FC 0x 0F 0x 66 0x 4 opcode paddb_xmm6,xmm4	  
	  
      0x C2 0x DB 0x 0F 0x 66 0x 4 opcode pand_xmm0,xmm2	   
      0x CA 0x DB 0x 0F 0x 66 0x 4 opcode pand_xmm1,xmm2
	  0x DA 0x DB 0x 0F 0x 66 0x 4 opcode pand_xmm3,xmm2
	  0x EA 0x DB 0x 0F 0x 66 0x 4 opcode pand_xmm5,xmm2
      0x F2 0x DB 0x 0F 0x 66 0x 4 opcode pand_xmm6,xmm2
	  0x FA 0x DB 0x 0F 0x 66 0x 4 opcode pand_xmm7,xmm2
	  
	                    0x 58 0x 1 opcode pop_rax
                        0x 5B 0x 1 opcode pop_rbx
                        0x 59 0x 1 opcode pop_rcx
						
	  0x C1 0x EB 0x 0F 0x 66 0x 4 opcode por_xmm0,xmm1
	  0x EE 0x EB 0x 0F 0x 66 0x 4 opcode por_xmm5,xmm6
	  

0x 04 0x F0 0x 73 0x 0F 0x 66 0x 5 opcode psllq_xmm0,4
0x 04 0x F5 0x 73 0x 0F 0x 66 0x 5 opcode psllq_xmm5,4
0x 04 0x D1 0x 73 0x 0F 0x 66 0x 5 opcode psrlq_xmm1,4
0x 04 0x D6 0x 73 0x 0F 0x 66 0x 5 opcode psrlq_xmm6,4

      0x D9 0x F8 0x 0F 0x 66 0x 4 opcode psubb_xmm3,xmm1
	  0x FE 0x F8 0x 0F 0x 66 0x 4 opcode psubb_xmm7,xmm6
			
      0x C1 0x 60 0x 0F 0x 66 0x 4 opcode punpcklbw_xmm0,xmm1
      0x E9 0x 60 0x 0F 0x 66 0x 4 opcode punpcklbw_xmm5,xmm1

                  0x 50 0x 1 opcode push_rax
			      0x 53 0x 1 opcode push_rbx
			      0x 51 0x 1 opcode push_rcx
			      0x 52 0x 1 opcode push_rdx
			
0x C0 0x EF 0x 0F 0x 66 0x 4 opcode pxor_xmm0,xmm0
0x C9 0x EF 0x 0F 0x 66 0x 4 opcode pxor_xmm1,xmm1
0x DB 0x EF 0x 0F 0x 66 0x 4 opcode pxor_xmm3,xmm3
0x FF 0x EF 0x 0F 0x 66 0x 4 opcode pxor_xmm7,xmm7
			
			0x F3 0x 1 opcode rep
			0x F2 0x 1 opcode repne
            0x C3 0x 1 opcode ret
			
		0x C0 0x 97 0x 0F 0x 3 opcode seta_al	
		0x C0 0x 94 0x 0F 0x 3 opcode sete_al	
		0x C0 0x 95 0x 0F 0x 3 opcode setne_al
	    0x C3 0x 95 0x 0F 0x 3 opcode setne_bl 
		            0x AE 0x 1 opcode scasb
		
		      0x E0 0x C0 0x 2 opcode shl_al,#
        0x E0 0x C1 0x 48 0x 3 opcode shl_rax,#
		0x E0 0x D3 0x 48 0x 3 opcode shl_rax,cl
		0x E3 0x C1 0x 48 0x 3 opcode shl_rbx,#
		      0x E2 0x C0 0x 2 opcode shl_dl,#
		 
		0x E8 0x D1 0x 48 0x 3 opcode shr_rax,1
		0x E8 0x D3 0x 48 0x 3 opcode shr_rax,cl
		0x EB 0x D1 0x 48 0x 3 opcode shr_rbx,1
        0x E9 0x C1 0x 48 0x 3 opcode shr_rcx,# 		
		
		            0x FD 0x 1 opcode std
		        	0x AA 0x 1 opcode stosb
					
					0x 2C 0x 1 opcode sub_al,# 
        0x E8 0x 83 0x 48 0x 3 opcode sub_rax,b#  
        0x C8 0x 29 0x 48 0x 3 opcode sub_rax,rcx 	
        0x E9 0x 83 0x 48 0x 3 opcode sub_rcx,b# 		
		
		0x C0 0x 85 0x 48 0x 3 opcode test_rax,rax
			
            0x C4 0x 86 0x 2 opcode xchg_al,ah	
      0x C8 0x 87 0x 48 0x 3 opcode xchg_rax,rcx
	  
        0x C0 0x 31 0x 48 0x 3 opcode xor_rax,rax	  
        0x C9 0x 31 0x 48 0x 3 opcode xor_rcx,rcx
		      0x D2 0x 30 0x 2 opcode xor_dl,dl
		0x D2 0x 31 0x 48 0x 3 opcode xor_rdx,rdx
		0x F6 0x 31 0x 48 0x 3 opcode xor_rsi,rsi

EXIT          
