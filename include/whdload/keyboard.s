;*---------------------------------------------------------------------------
;  :Modul.	keyboard.s
;  :Contents.	routine to setup an keyboard handler
;  :Version.	$Id: keyboard.s 1.3 1999/01/03 23:41:17 jah Exp $
;  :History.	30.08.97 extracted from some slave sources
;		17.11.97 _keyexit2 added
;		23.12.98 _key_help added
;		07.10.99 some cosmetic changes, documentation improved
;  :Requires.	_keydebug	byte variable containing rawkey code
;		_keyexit	byte variable containing rawkey code
;  :Optional.	_keyexit2	byte variable containing rawkey code
;		_key_help	function to execute on help pressed
;		_debug		function to quit with debug
;		_exit		function to quit
;  :Copyright.	Public Domain
;  :Language.	68000 Assembler
;  :Translator.	Barfly 2.9
;  :To Do.
;---------------------------------------------------------------------------*
; this routine setups a keyboard handler, realizing quit and quit-with-debug
; feature by pressing the appropriate key. the following variables must be
; defined:
;	_keyexit
;	_keydebug
; the labels should refer to the Slave structure, so user definable quit- and
; debug-key will be supported
; the optional variable:
;	_keyexit2
; can be used to specify a second quit-key, if a quit by two different keys
; should be supported
; the optional function:
;	_key_help
; will be called when the 'help' key is pressed, the fuction must return via
; 'rts' and must not change any registers
;
; IN:	-
; OUT:	-

_SetupKeyboard
	;set the interrupt vector
		pea	(.int,pc)
		move.l	(a7)+,($68)
	;allow interrupts from the keyboard
		move.b	#CIAICRF_SETCLR|CIAICRF_SP,(ciaicr+_ciaa)
	;clear all ciaa-interrupts
		tst.b	(ciaicr+_ciaa)
	;set input mode
		and.b	#~(CIACRAF_SPMODE),(ciacra+_ciaa)
	;clear ports interrupt
		move.w	#INTF_PORTS,(intreq+_custom)
	;allow ports interrupt
		move.w	#INTF_SETCLR|INTF_INTEN|INTF_PORTS,(intena+_custom)
		rts

.int		movem.l	d0-d1/a1,-(a7)
		lea	(_ciaa),a1
	;check if keyboard has caused interrupt
		btst	#CIAICRB_SP,(ciaicr,a1)
		beq	.end
	;read keycode
		move.b	(ciasdr,a1),d0
	;set output to low and output mode (handshake)
		clr.b	(ciasdr,a1)
		or.b	#CIACRAF_SPMODE,(ciacra,a1)
	;calculate rawkeycode
		not.b	d0
		ror.b	#1,d0

		cmp.b	(_keydebug),d0
		bne	.1
		movem.l	(a7)+,d0-d1/a1
		move.w	(a7),(6,a7)			;sr
		move.l	(2,a7),(a7)			;pc
		clr.w	(4,a7)				;ext.l sr
	IFD _debug
		bra	_debug
	ELSE
		bra	.debug
	ENDC

.1		cmp.b	(_keyexit),d0
	IFD _exit
		beq	_exit
	ELSE
		beq	.exit
	ENDC

	IFD _keyexit2
		cmp.b	(_keyexit2),d0
	IFD _exit
		beq	_exit
	ELSE
		beq	.exit
	ENDC
	ENDC

	IFD _key_help
		cmp.b	#$5f,d0
		bne	.2
		bsr	_key_help
.2
	ENDC

	;better would be to use the cia-timer to wait, but we arn't know if
	;they are otherwise used, so using the rasterbeam
	;required minimum waiting is 75 �s, one rasterline is 63.5 �s
	;a loop of 3 results in min=127�s max=190.5�s
		moveq	#3-1,d1
.wait1		move.b	(_custom+vhposr),d0
.wait2		cmp.b	(_custom+vhposr),d0
		beq	.wait2
		dbf	d1,.wait1

	;set input mode
		and.b	#~(CIACRAF_SPMODE),(ciacra,a1)
.end		move.w	#INTF_PORTS,(intreq+_custom)
		movem.l	(a7)+,d0-d1/a1
		rte

	IFND _exit
.debug		pea	TDREASON_DEBUG.w
.quit		move.l	(_resload),-(a7)
		addq.l	#resload_Abort,(a7)
		rts
.exit		pea	TDREASON_OK.w
		bra	.quit
	ENDC

