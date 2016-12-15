 FORTH32 CONTEXT !   FORTH32 CURRENT !
 INCLUDE: frames.f
 
  WORD: ?KEY   SF_GET_KEY ;WORD
  WORD: KEY    0 Begin SF_WAIT_EVENT Pop SF_GET_KEY DUP 1 <> Until   ;WORD
  
  WORD: KEY>ASCII     hex, 8 Rshift  hex, ff AND ;WORD 
  
  0d 60 CONSTANT tib# 
  CREATE tib  tib h.  tib# ALLOT   0x 20202020 , 0x 49584520 ,  0x 20202054 ,
  
  
 
  WORD: position-    position @	 hex, 80000 - 1st @ MAX	position ! ;WORD
  
  WORD: backspace   position-  SPACE  position-	   ;WORD
			   
 WORD: tib-  2nd @ 1-  2nd !   2nd @  tib MAX  2nd !    2nd @ 0! ;WORD
  
  WORD: EXPECT    tib  position @    fix_frame   
                     Begin    KEY 
                           Case
(( enter )      DUP  hex, 1c0d00 = Of Pop -1 EndOf
(( backspace)   DUP  hex, 0e0800 = Of Pop  backspace   tib-   0 EndOf
(( CAPS on  )   DUP  hex, 3a0400 = Of Pop  0 EndOf
(( CAPS off )   DUP  hex, ba0400 = Of Pop  0 EndOf
				DUP  hex, 4bb000 = Of Pop cursor_left  0 EndOf
				DUP  hex, 4db300 = Of Pop cursor_right 0 EndOf
					 KEY>ASCII (EMIT)      2nd @ C!   
					 2nd @ 1+ 2nd !   2nd @ tib tib# + <    
					       EndCase 
						   Until Pop Pop 
  ;WORD
					 
					 
					 EXIT    
