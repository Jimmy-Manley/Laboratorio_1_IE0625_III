;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.0.0 #11528 (Linux)
;--------------------------------------------------------
; PIC port for the 14-bit core
;--------------------------------------------------------
;	.file	"dice.c"
	list	p=12f675
	radix dec
	include "p12f675.inc"
;--------------------------------------------------------
; external declarations
;--------------------------------------------------------
	extern	_ANSEL
	extern	_VRCON
	extern	_TRISIO
	extern	_ADCON0
	extern	_CMCON
	extern	_GPIO
	extern	_GPIObits
	extern	__sdcc_gsinit_startup
;--------------------------------------------------------
; global declarations
;--------------------------------------------------------
	global	_main
	global	_check_pushbutton
	global	_setup
	global	_data
	global	_delay

	global PSAVE
	global SSAVE
	global WSAVE
	global STK12
	global STK11
	global STK10
	global STK09
	global STK08
	global STK07
	global STK06
	global STK05
	global STK04
	global STK03
	global STK02
	global STK01
	global STK00

sharebank udata_ovr 0x0020
PSAVE	res 1
SSAVE	res 1
WSAVE	res 1
STK12	res 1
STK11	res 1
STK10	res 1
STK09	res 1
STK08	res 1
STK07	res 1
STK06	res 1
STK05	res 1
STK04	res 1
STK03	res 1
STK02	res 1
STK01	res 1
STK00	res 1

;--------------------------------------------------------
; global definitions
;--------------------------------------------------------
;--------------------------------------------------------
; absolute symbol definitions
;--------------------------------------------------------
;--------------------------------------------------------
; compiler-defined variables
;--------------------------------------------------------
UDL_dice_0	udata
r0x100E	res	1
r0x100F	res	1
r0x1010	res	1
r0x1011	res	1
r0x1007	res	1
r0x1006	res	1
r0x1008	res	1
r0x1009	res	1
r0x100A	res	1
r0x100B	res	1
r0x100C	res	1
r0x100D	res	1
;--------------------------------------------------------
; initialized data
;--------------------------------------------------------

IDD_dice_0	idata
_data
	db	0x01	; 1
	db	0x02	; 2
	db	0x03	; 3
	db	0x06	; 6
	db	0x07	; 7
	db	0x16	; 22

;--------------------------------------------------------
; initialized absolute data
;--------------------------------------------------------
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
;	udata_ovr
;--------------------------------------------------------
; reset vector 
;--------------------------------------------------------
STARTUP	code 0x0000
	nop
	pagesel __sdcc_gsinit_startup
	goto	__sdcc_gsinit_startup
;--------------------------------------------------------
; code
;--------------------------------------------------------
code_dice	code
;***
;  pBlock Stats: dbName = M
;***
;has an exit
;functions called:
;   _setup
;   _delay
;   _delay
;   _setup
;   _delay
;   _delay
;5 compiler assigned registers:
;   STK00
;   r0x100E
;   r0x100F
;   r0x1010
;   r0x1011
;; Starting pCode block
S_dice__main	code
_main:
; 2 exit points
;	.line	46; "dice.c"	setup();
	PAGESEL	_setup
	CALL	_setup
	PAGESEL	$
;	.line	48; "dice.c"	delay(time);
	MOVLW	0xfa
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_delay
	CALL	_delay
	PAGESEL	$
_00132_DS_:
;	.line	52; "dice.c"	for(int i=0;i<6;i++)
	CLRF	r0x100E
	CLRF	r0x100F
;;signed compare: left < lit(0x6=6), size=2, mask=ffff
_00125_DS_:
	MOVF	r0x100F,W
	ADDLW	0x80
	ADDLW	0x80
	BTFSS	STATUS,2
	GOTO	_00145_DS_
	MOVLW	0x06
	SUBWF	r0x100E,W
_00145_DS_:
	BTFSC	STATUS,0
	GOTO	_00132_DS_
;;genSkipc:3307: created from rifx:0x7ffc18b5af00
;	.line	55; "dice.c"	if(push_button == 0)
	BANKSEL	_GPIObits
	BTFSC	_GPIObits,5
	GOTO	_00126_DS_
;	.line	58; "dice.c"	GPIO = data[i];
	MOVF	r0x100E,W
	ADDLW	(_data + 0)
	MOVWF	r0x1010
	MOVLW	high (_data + 0)
	MOVWF	r0x1011
	MOVF	r0x100F,W
	BTFSC	STATUS,0
	INCFSZ	r0x100F,W
	ADDWF	r0x1011,F
	MOVF	r0x1010,W
	MOVWF	FSR
	BCF	STATUS,7
	BTFSC	r0x1011,0
	BSF	STATUS,7
	MOVF	INDF,W
	MOVWF	_GPIO
;	.line	60; "dice.c"	delay(time);		
	MOVLW	0xfa
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_delay
	CALL	_delay
	PAGESEL	$
_00126_DS_:
;	.line	52; "dice.c"	for(int i=0;i<6;i++)
	INCF	r0x100E,F
	BTFSC	STATUS,2
	INCF	r0x100F,F
	GOTO	_00125_DS_
;	.line	67; "dice.c"	}
	RETURN	
; exit point of _main

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;9 compiler assigned registers:
;   r0x1006
;   STK00
;   r0x1007
;   r0x1008
;   r0x1009
;   r0x100A
;   r0x100B
;   r0x100C
;   r0x100D
;; Starting pCode block
S_dice__delay	code
_delay:
; 2 exit points
;	.line	69; "dice.c"	void delay(unsigned int tiempo)
	MOVWF	r0x1006
	MOVF	STK00,W
	MOVWF	r0x1007
;	.line	74; "dice.c"	for(i=0;i<tiempo;i++)
	CLRF	r0x1008
	CLRF	r0x1009
_00156_DS_:
	MOVF	r0x1006,W
	SUBWF	r0x1009,W
	BTFSS	STATUS,2
	GOTO	_00177_DS_
	MOVF	r0x1007,W
	SUBWF	r0x1008,W
_00177_DS_:
	BTFSC	STATUS,0
	GOTO	_00158_DS_
;;genSkipc:3307: created from rifx:0x7ffc18b5af00
;	.line	75; "dice.c"	for(j=0;j<1275;j++);
	MOVLW	0xfb
	MOVWF	r0x100A
	MOVLW	0x04
	MOVWF	r0x100B
_00154_DS_:
	MOVLW	0xff
	ADDWF	r0x100A,W
	MOVWF	r0x100C
	MOVLW	0xff
	MOVWF	r0x100D
	MOVF	r0x100B,W
	BTFSC	STATUS,0
	INCFSZ	r0x100B,W
	ADDWF	r0x100D,F
	MOVF	r0x100C,W
	MOVWF	r0x100A
	MOVF	r0x100D,W
	MOVWF	r0x100B
	MOVF	r0x100D,W
	IORWF	r0x100C,W
	BTFSS	STATUS,2
	GOTO	_00154_DS_
;	.line	74; "dice.c"	for(i=0;i<tiempo;i++)
	INCF	r0x1008,F
	BTFSC	STATUS,2
	INCF	r0x1009,F
	GOTO	_00156_DS_
_00158_DS_:
;	.line	76; "dice.c"	}
	RETURN	
; exit point of _delay

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;functions called:
;   _delay
;   _delay
;1 compiler assigned register :
;   STK00
;; Starting pCode block
S_dice__check_pushbutton	code
_check_pushbutton:
; 2 exit points
;	.line	29; "dice.c"	if(push_button == 0)// switch pressed
	BANKSEL	_GPIObits
	BTFSC	_GPIObits,5
	GOTO	_00113_DS_
;	.line	31; "dice.c"	delay(250);
	MOVLW	0xfa
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_delay
	CALL	_delay
	PAGESEL	$
;	.line	32; "dice.c"	if(push_button == 0)// switch pressed
	BANKSEL	_GPIObits
	BTFSC	_GPIObits,5
	GOTO	_00113_DS_
;	.line	34; "dice.c"	GPIO = data[5];
	MOVF	(_data + 5),W
	MOVWF	_GPIO
_00113_DS_:
;	.line	38; "dice.c"	}
	RETURN	
; exit point of _check_pushbutton

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;; Starting pCode block
S_dice__setup	code
_setup:
; 2 exit points
;	.line	15; "dice.c"	ADCON0 = 0x00;
	BANKSEL	_ADCON0
	CLRF	_ADCON0
;	.line	16; "dice.c"	ANSEL = 0x00;
	BANKSEL	_ANSEL
	CLRF	_ANSEL
;	.line	17; "dice.c"	CMCON = 0x07; //shut off comparator
	MOVLW	0x07
	BANKSEL	_CMCON
	MOVWF	_CMCON
;	.line	18; "dice.c"	VRCON = 0X00;
	BANKSEL	_VRCON
	CLRF	_VRCON
;	.line	19; "dice.c"	TRISIO = 0X20;	// set all GPIOs as outputs, except GP5= push button
	MOVLW	0x20
	MOVWF	_TRISIO
;	.line	20; "dice.c"	GPIO = 0x20;	// set all pins low except GP5 
	MOVLW	0x20
	BANKSEL	_GPIO
	MOVWF	_GPIO
;	.line	21; "dice.c"	}
	RETURN	
; exit point of _setup


;	code size estimation:
;	  103+   16 =   119 instructions (  270 byte)

	end
