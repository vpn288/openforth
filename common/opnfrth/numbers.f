FORTH32 CONTEXT ! FORTH32 CURRENT !

 

WORD: (bHEX)     @  b(swap_ab)  ;WORD 
 
WORD: (wHEX)    DUP  1+ 1+ (bHEX)  >R  (bHEX)  R>   ;WORD 

WORD: 2h.        (hex_pop2)    (hex_pop)    (hex_convert)    inverse_hexstr    
                  hexstr    TYPEZ  ;WORD  
				
WORD: h.         (clear_hex)   (hex_pop)    (hex_convert)    inverse_hexstr    
                 hexstr   CELL+  CELL+  TYPEZ  ;WORD  
				
WORD: bh.        (clear_hex)  (hex_pop) (hex_convert) inverse_hexstr hexstr  hex, 1e + @  
                 hex, 2 nEMIT SPACE  ;WORD 
WORD: wh.        (clear_hex)  (hex_pop) (hex_convert) inverse_hexstr hexstr  hex, 1c +  @
                 hex, 4 nEMIT SPACE  ;WORD 
				
WORD: dh.        (clear_hex)  (hex_pop) (hex_convert) inverse_hexstr hexstr  hex, 18 +  @
                hex, 8 nEMIT SPACE  ;WORD 
				
WORD: d.         (dec_pop) (d.) HERE TYPEZ ;WORD 
WORD: 2d.        (dec_pop2) (dec_pop)  (d.) HERE TYPEZ ;WORD 

WORD: (dump)   0 hex, 10 Do hexstr R@ + (bHEX) EMIT SPACE R> 1+ >R Loop  ;WORD 

WORD: DUMP    CRLF DUP 2@ (hex_pop2) (hex_pop) (hex_convert) (dump) ." - "  
              CELL+ CELL+ 2@ (hex_pop2) (hex_pop) (hex_convert) (dump) ;WORD 

WORD: (0d)        PARSE (2d) decimalv  ;WORD 
WORD: 0d          (0d) @ ;WORD     

IMMEDIATES CURRENT ! 

WORD: 0d,     0d ;WORD

FORTH32 CURRENT !


EXIT   
 WORD: 2d   (0d) 2@ ;WORD 
