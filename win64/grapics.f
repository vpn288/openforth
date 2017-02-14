

  VARIABLE hdc 
  
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
   WORD: PolyLine:  
                CREATE  DUP ,  1 SWAP Do D, D, Loop  
				DOES>  >R hdc @   R@ CELL+   R> @   Polyline Pop 
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
 
 
