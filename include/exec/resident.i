	IFND EXEC_RESIDENT_I
EXEC_RESIDENT_I SET 1
 IFND EXEC_TYPES_I
 INCLUDE "exec/types.i"
 ENDC
 STRUCTURE RT,0
 UWORD RT_MATCHWORD
 APTR RT_MATCHTAG
 APTR RT_ENDSKIP
 UBYTE RT_FLAGS
 UBYTE RT_VERSION
 UBYTE RT_TYPE
 BYTE RT_PRI
 APTR RT_NAME
 APTR RT_IDSTRING
 APTR RT_INIT
 LABEL RT_SIZE
RTC_MATCHWORD=$4AFC
 BITDEF RT,COLDSTART,0
 BITDEF RT,SINGLETASK,1
 BITDEF RT,AFTERDOS,2
 BITDEF RT,AUTOINIT,7
RTW_NEVER=0
RTW_COLDSTART=1
 ENDC
