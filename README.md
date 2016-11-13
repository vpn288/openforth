# openforth

FORTH system loading and deploying from it's one source code. 

Versions:
1) Baremetal 32-bit system will rebuild
2) Real-mode 32-bit version includes built-in editor and symplest assembler.
3) Kolibry-OS 32-bit will rebuild
4) Win64 system in rebuild

Difference wint traditional Forths:

1) Symplest interpretator.
1.1) No STATE
1.2) No compilation mode
1.3) No immediates (no IMMEDIATE flag in counter)
1.4) No automatic numbers
2) Number translation withdrawn from interpretator to special word 0x - interpret next word as hex number.
3) Minimal kernel of system written in assembler. Remain system developping out of forth source code. 

...

Minimal-debug version working system. It has not obligatory words used for debugging  ( HEX. DUMP )
