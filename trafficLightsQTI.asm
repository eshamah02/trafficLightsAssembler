title  "trafficLightsQTI"
;
; A program which uses a QTI sensor to sense whether or not someone is on 
; a platform
;
; Hardware Notes:
;   PIC16F684 running at 4 MHz
;   
;	Inputs:
;	RA5		- QTI Sensor
;		
;	Outputs:
;	RC0, RC1, RC2	- 3 LED's 
;			- Turn on when QTI senses something
;
; Esha Maheshwari
; 12/14/2019
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
;  Mainline of "trafficLights"

org    0
    movlw   7				;turn off Comparators
    movwf   CMCON0

    bsf     STATUS, RP0			;going into Bank 1
    clrf    ANSEL ^ 0x080		;all PORTS are Digital

    clrf    TRISC ^ 0X080		;teach all of PORT C to be outputs
    
    movlw   b'00101000'			;making RA5 and RA3 inputs
    movwf   TRISA ^ 0x080		;moving binary value into TRISA to correspond with RA values
    
    bcf	    STATUS, RP0			;going back into Bank 0
    
loop:
    nop
    btfss PORTA, 5		    ;if sensor senses something then call sensorOn
	call sensorOn
    btfsc PORTA, 5		    ;if sensor does not sense something then call sensorOff
    	call sensorOff
    goto loop
    
;--------------------------------------------------------------------------
PAGE
;Subroutines
 
sensorOn:
    Dlay 200000
	movlw b'00000001'		    ;flash LED in port RC0 on and off (3x)
	movwf PORTC
	nop
    Dlay 200000
	clrf PORTC
	nop
    Dlay 200000
	movlw b'00000001'
	movwf PORTC
	nop
    Dlay 200000
	clrf PORTC
	nop
    Dlay 200000
	movlw b'00000001'
	movwf PORTC
	nop
    Dlay 5000000		    ;delay 5 seconds
	nop
	return
    
sensorOff:
    clrf PORTC			    ;turn off LEDs
    nop
    return

end





