	IFND EXEC_TYPES_I
EXEC_TYPES_I SET 1
INCLUDE_VERSION=40
EXTERN_LIB MACRO
 XREF _LVO\1
 ENDM
STRUCTURE MACRO
\1= 0
SOFFSET SET \2
 ENDM
FPTR MACRO
\1= SOFFSET
SOFFSET SET SOFFSET+4
 ENDM
BOOL MACRO
\1= SOFFSET
SOFFSET SET SOFFSET+2
 ENDM
BYTE MACRO
\1= SOFFSET
SOFFSET SET SOFFSET+1
 ENDM
UBYTE MACRO
\1= SOFFSET
SOFFSET SET SOFFSET+1
 ENDM
WORD MACRO
\1= SOFFSET
SOFFSET SET SOFFSET+2
 ENDM
UWORD MACRO
\1= SOFFSET
SOFFSET SET SOFFSET+2
 ENDM
SHORT MACRO
\1= SOFFSET
SOFFSET SET SOFFSET+2
 ENDM
USHORT MACRO
\1= SOFFSET
SOFFSET SET SOFFSET+2
 ENDM
LONG MACRO
\1= SOFFSET
SOFFSET SET SOFFSET+4
 ENDM
ULONG MACRO
\1= SOFFSET
SOFFSET SET SOFFSET+4
 ENDM
FLOAT MACRO
\1= SOFFSET
SOFFSET SET SOFFSET+4
 ENDM
DOUBLE MACRO
\1= SOFFSET
SOFFSET SET SOFFSET+8
 ENDM
APTR MACRO
\1= SOFFSET
SOFFSET SET SOFFSET+4
 ENDM
CPTR MACRO
\1= SOFFSET
SOFFSET SET SOFFSET+4
 ENDM
RPTR MACRO
\1= SOFFSET
SOFFSET SET SOFFSET+2
 ENDM
LABEL MACRO
\1= SOFFSET
 ENDM
STRUCT MACRO
\1= SOFFSET
SOFFSET SET SOFFSET+\2
 ENDM
ALIGNWORD MACRO
SOFFSET SET (SOFFSET+1)&$fffffffe
 ENDM
ALIGNLONG MACRO
SOFFSET SET (SOFFSET+3)&$fffffffc
 ENDM
ENUM MACRO
 IFC '\1',''
EOFFSET SET 0
 ENDC
 IFNC '\1',''
EOFFSET SET \1
 ENDC
 ENDM
EITEM MACRO
\1= EOFFSET
EOFFSET SET EOFFSET+1
 ENDM
BITDEF MACRO
 BITDEF0 \1,\2,B_,\3
\@BITDEF SET 1<<\3
 BITDEF0 \1,\2,F_,\@BITDEF
 ENDM
BITDEF0 MACRO
\1\3\2= \4
 ENDM
LIBRARY_MINIMUM=33
 ENDC
