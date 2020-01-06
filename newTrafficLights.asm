title  "TrafficLightsVTwo"
;
; A program which uses one button input to control the speed
; of three LEDs flashing. The concept of subroutines are introduced here.
;
;  Hardware Notes:
;   PIC16F684 running at 4 MHz
;   Inputs:
;		RA5 - button, when pressed, sends a LOW
;		    - when not pressed, sends a HIGH
;	Outputs:
;		RC2, RC3, RC4 - two red LEDs, each through a 680 resistor, to ground		
;
; North
; Nov. 7, 2007
;--------------------------------------------------------------------------
; Setup
    LIST R=DEC				
    INCLUDE "p16f684.inc" 
    INCLUDE "asmDelay.inc"

 __CONFIG _FCMEN_OFF & _IESO_OFF & _BOD_OFF & _CPD_OFF & _CP_OFF & _MCLRE_OFF & _PWRTE_ON & _WDT_OFF & _INTOSCIO

;  Variables
    CBLOCK 0x020 

    ENDC 
;--------------------------------------------------------------------------
PAGE
;  Mainline of "TrafficLightsVTwo"

org    0
    movlw   7				;turn off Comparators
    movwf   CMCON0

    bsf     STATUS, RP0			;going into Bank 1
    clrf    ANSEL ^ 0x080		;all PORTS are Digital

    clrf    TRISC ^ 0X080		;teach all of PORT C to be outputs
    
    movlw   b'00001000'			;making RA4 and RA5 outputs and leaving RA3 as in input
    movwf   TRISA ^ 0x080		;moving binary value into TRISA to correspond with RA values
    
    bcf	    STATUS, RPO			;going back into Bank 0
    
loop:
    nop
    call seqOne
    call seqTwo
    call seqThree
    call seqFour
    call seqFive
    call seqSix
    goto loop
    
;--------------------------------------------------------------------------
PAGE
;Subroutines
 
seqOne:
    movlw b'00100100'		;RC0, RC1, RC3, RC4 are off. RC2 and RC5 are on
    movwf PORTC			;applying that to RA bits
    Dlay 20000000		;delay of 20 seconds
    nop
    return
    
seqTwo:
    movlw b'00100000'		;RC5 is on, rest are off
    movwf PORTC			
    Dlay 15000000		;delay of 15 seconds
    nop
    return 
	
seqThree:
    movlw b'00100001'		;RC0, RC5 are on. Rest are off
    movwf PORTC
    Dlay 1000000		;delay of 1 second
    nop
    return

seqFour:
    movlw b'00001001'			;RC0, RC3 are on. Rest are off
    movwf PORTC
    Dlay 20000000			;delay of 20 seconds
    nop
    return

seqFive:
    movlw b'00010001'		;RC0, RC4 are on. Rest are off
    movwf PORTC
    Dlay 15000000			;delay of 15 seconds
    nop
    return  

seqSix:
    movlw b'00100001'		;RC0, RC5 are on. Rest are off
    movwf PORTC
    Dlay 2000000			;delay of 2 seconds
    nop
    return	

end


