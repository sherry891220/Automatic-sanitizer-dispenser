#include <xc.h>
#include <pic18f4520.h>

#pragma config OSC = INTIO67
#pragma config WDT = OFF
#pragma config LVP = OFF
#pragma config PWRT = OFF
#pragma config BOREN = ON
#pragma config PBADEN = OFF
#pragma config CPD = OFF

void delay(int num){
    for(int i=0;i<num;i++){
        num=num-1;
    }
}

void main(void) {
    //------------------------SR04-------------------------------------------
    //CMCONbits.CM = 0b111;
    ADCON1bits.PCFG=0b1111;   //all digital
    T1CONbits.RD16 = 1;    //Enables register Read/Write of Timer1 in one 16-bit operation
    TMR1L = 0;  
    // Ultrasonic sensor pins
    TRISAbits.TRISA0 = 0;  // TRIG pin
    TRISAbits.TRISA1 = 1;  // ECHO pin
    TRISD = 0;
    // TIMER1 Configuration
    // Prescaler = 1:8
    T1CONbits.T1CKPS = 0b11;
    // Select internal clock (FOSC/4)
    //T1CONbits.TMR1CS = 0;
    OSCCONbits.IRCF = 0b100;
    int timer;
    LATD = 0;
    //--------------------------------------------------------------------
    while(1) {
        // Reset TIMER1 values
        LATD = 0;
        TMR1L = 0;  
        PORTAbits.RA0 = 1;
        delay(25);
        PORTAbits.RA0 = 0;
        //PORTAbits.RA1 = 1;
        // Wait for ECHO pin goes to HIGH
        while(PORTAbits.RA1 == 0);    
        T1CONbits.TMR1ON = 1;   // Enable TIMER1 module 
        // Wait for ECHO pin goes to LOW
        while(PORTAbits.RA1);
        T1CONbits.TMR1ON = 0;   // Disable TIMER1 module
        timer =TMR1L;
        if(timer > 30){
            PORTD = 0;
        }else{
            PORTD = 1;
        }
        delay(50);
    }
}
