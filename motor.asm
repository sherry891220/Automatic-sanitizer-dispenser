#include "p18f4520.inc"
    
CONFIG  OSC = INTIO67
CONFIG WDT = OFF
CONFIG PWRT = OFF
CONFIG BOREN = ON
CONFIG PBADEN = OFF
CONFIG LVP = OFF
CONFIG CPD = OFF

L1 equ 0x14
L2 equ 0x15
org 0x00
NOP
  
goto start
delay macro num1,num2
    local LOOP1
    local LOOP2
    MOVLW num2
    MOVWF L2
    LOOP2:
	MOVLW num1
	MOVWF L1
    LOOP1:
	NOP
	NOP
	NOP
	NOP
	NOP
	DECFSZ L1,1
	BRA LOOP1
	DECFSZ L2,1
	BRA LOOP2
endm

ISR:
    org 0x08
    BCF  INTCON , INT0IE
    BCF  INTCON , INT0IF
    BSF btn,0
    RETFIE    
    
start:
    ;CLRF TRISD
    ;BSF TRISD,0
    BCF PORTD,0
    BSF  INTCON , GIE
    BSF  RCON , IPEN
    BSF TRISB , 0
    MOVLW 0x00
    MOVWF btn
    btn EQU 0x00
    BSF  INTCON , INT0IE
    MOVLW b'00000101'
    MOVWF T2CON
    MOVLW b'00010000'
    MOVWF OSCCON
    MOVLW b'00011100'
    MOVWF CCP1CON
    CLRF TRISC
    CLRF LATC
    MOVLW 0x9b
    MOVWF PR2
state0:
    ;clrf btn
    MOVLW 0x04
    MOVWF CCPR1L
    BSF INTCON , INT0IE
    BTFSS PORTD,0 ;PORTD = 1
    goto state0
    goto state1
state1:
    ;clrf btn
    MOVLW d'8'
    MOVWF 0x01
loop1:
    incf CCPR1L
    delay d'25',d'10'
    DECFSZ 0x01
    goto loop1
    delay d'25',d'100'
    goto state2
    
state2:
    ;clrf btn
    MOVLW d'8'
    MOVWF 0x01
    ;decf CCPR1L
loop2:
    decf CCPR1L
    delay d'25',d'10'
    DECFSZ 0x01
    goto loop2
    goto state0

end


