FORTH32 CONTEXT !    FORTH32 CURRENT !

WINAPIS:
       LIB: Kernel32.dll
	           void   AllocConsole
			   void   GetLastError
	           1_int  GetStdHandle
			   1_int  Sleep
			   1_int  ExitProcess 
			   5_ints ReadConsoleA 
			   5_ints WriteConsoleA 
			   

;WINAPIS

EXIT  
