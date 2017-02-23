

WORD: innerloop   0 Begin Pop msg hwnd @ 0 0  GetMessageA DUP  Until  ;WORD 

defines FORTH32 LINK  
WORD: MessageLoop  
          Begin innerloop 1+  ?break  
		  
		        msg TranslateMessage Pop  	msg DispatchMessageA Pop
 
          Again   ;WORD

FORTH32 CONTEXT !

0 GetModuleHandleA  CONSTANT hInstance .( winclass ) 

CREATE wc   0x 50 D, 0 D, ' winproc @ , 0 D, 0 D, hInstance , 
 0 0d 32512 LoadIconA  0 ,
 0 0d 32512 LoadCursorA  , 
 defines FORTH32 LINK  defines CONTEXT !  
 COLOR_BTNFACE , 0 , _class , 0 ,
 
 FORTH32 CONTEXT ! 
.( Registering class:) 
  wc   RegisterClassExA  h.  GetLastError h. CRLF

CRLF .( creating window )

.(  ww1 file is here ) 

WORD: opwn 
   0 _class title [ CONTEXT @ defines CONTEXT ! ]  WS_VISIBLE WS_DLGFRAME WS_SYSMENU [ CONTEXT ! ] + +    0 0 hex, 150 hex, 100  0 0 hInstance 0   CreateWindowExA ."  Hwnd:" DUP hwnd !   hwnd @ GetDC hex, ffffffff AND DUP hdc !    hdc @ mybrush SelectObject Pop   
   
;WORD 

WORD: anb  opwn MessageLoop ;WORD 

EXIT 
