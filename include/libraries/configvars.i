	IFND LIBRARIES_CONFIGVARS_I
LIBRARIES_CONFIGVARS_I SET 1
 IFND EXEC_NODES_I
 INCLUDE "exec/nodes.i"
 ENDC
 IFND LIBRARIES_CONFIGREGS_I
 INCLUDE "libraries/configregs.i"
 ENDC
 STRUCTURE ConfigDev,0
 STRUCT cd_Node,LN_SIZE
 UBYTE cd_Flags
 UBYTE cd_Pad
 STRUCT cd_Rom,ExpansionRom_SIZEOF
 APTR cd_BoardAddr
 ULONG cd_BoardSize
 UWORD cd_SlotAddr
 UWORD cd_SlotSize
 APTR cd_Driver
 APTR cd_NextCD
 STRUCT cd_Unused,4*4
 LABEL ConfigDev_SIZEOF
 BITDEF CD,SHUTUP,0
 BITDEF CD,CONFIGME,1
 BITDEF CD,BADMEMORY,2
 BITDEF CD,PROCESSED,3
 STRUCTURE CurrentBinding,0
 APTR cb_ConfigDev
 APTR cb_FileName
 APTR cb_ProductString
 APTR cb_ToolTypes
 LABEL CurrentBinding_SIZEOF
 ENDC
