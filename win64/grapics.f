

  VARIABLE hdc 
  
  ( *{ 0x 3 0x 3  0x 5 0x 18  0x 34 0x 88 }*  Points: mypoints ) 
  
  
  WORD: Points:  CREATE DUP ,   1 SWAP  Do  D,  D,  Loop  ;WORD 
  
  
  
WORD: Color:  CONSTANT ;WORD

 ( penStyle penWidth penColor Pen: mypen ) 
   WORD: Pen:   
                CreatePen   CONSTANT  
   ;WORD
   
 ( Color SolidBrush: mySolidBrush )
   WORD: SolidBrush: 
                CreateSolidBrush CONSTANT 
   ;WORD				

 
 (  Points cPoints PolyLine: mypolyline ) 
 
 WORD: (polilines)   @ >R  hdc @   R@ CELL+   R> @  ;WORD
 
   WORD: PolyLine:  
              	     CREATE , DOES> (polilines) Polyline  Pop  
   ;WORD 
   
 (  Points cPoints PolyBezier: mypolybezier ) 
   WORD: PolyBezier:  
                CREATE ,  DOES> (polilines)  PolyBezier Pop 
   ;WORD 
 (  nLeftRect nTopRect nRightRect nBottomRect nXStartArc nYStartArc nXEndArc nYEndrc Arc: myArc ) 
   WORD: Arc:  
                CREATE , , , , , , , , DOES>  >R hdc @ 
                                              R@ @ 
											  R@ CELL+ @  
											  R@ CELL+ CELL+ @ 
											  R@ CELL+ CELL+ CELL+ @
                                              R@  CELL+ CELL+ CELL+ CELL+ @   
											  R@  CELL+ CELL+ CELL+ CELL+ CELL+ @
                                              R@  CELL+ CELL+ CELL+ CELL+ CELL+ CELL+ @  
											  R>  CELL+ CELL+ CELL+ CELL+ CELL+ CELL+ CELL+ @  
											  Arc Pop
   ;WORD 
  
  ( nLeftRect nTopRect nRightRect nBottomRect ) 
  WORD: Ellipse:  
           CREATE , , , ,  
		   DOES>  >R  hdc @  
		          R@ @   
				  R@ CELL+ @  
				  R@ CELL+ CELL+ @ 
				  R> CELL+ CELL+ CELL+ @ 
			Ellipse Pop  ;WORD 
			
 
 
 
 EXIT
 CREATE  DUP ,  1 SWAP Do D, D, Loop  
				DOES>  >R hdc @   R@ CELL+   R> @ 
  (( DOES> DUP @ SWAP CELL+ ) 
 ( WORD: (polilines) ( CREATE ,  DOES> @ >R  hdc @   R@ CELL+   R> @  ;WORD )