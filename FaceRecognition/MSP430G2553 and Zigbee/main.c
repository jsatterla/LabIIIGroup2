#include <msp430.h>
#include <stdint.h>
#include "math.h"

/*Program for Controller of Zigbee Test Network,
 * adapted from msp430g2xx3_usci_uart_standard_transceiver.c example
 * by Nima Eskandari at Texas Instruments
 */
/******************************************************************************
**************************UART Initialization *********************************
******************************************************************************/


//------------------------------------------------------------------------------
// Definition of Constants
//------------------------------------------------------------------------------
//#define LED       0x01       //  %00000001    ; Port pin position P1.0
//#define RX       0x02       //  %00000010    ; Port pin position P1.1
//#define TX     0x04       //  %00000100    ; Port pin position P1.2

#define STEP     0x08       //    %00001000    ; Port pin position P1.3
#define DIR      0x10       //    %00010000    ; Port pin position P1.4

//#define MS1      0x20       //    %00100000    ; Port pin position P1.5
//#define MS2      0x40       //    %01000000    ; Port pin position P1.6
//#define ENABLE   0x80       //    %10000000    ; Port pin position P1.7

//#define PB_CW   0x01         // %00000001    ; Port pin position P2.0
//#define PB_ACW  0x02         // %00000010    ; Port pin position P2.1

//#define PB_CW_N   0x10       // %00010000    ; Port pin position P2.4
//#define PB_ACW_N 0x20        // %00100000    ; Port pin position P2.5

#define SMCLK_11500     0
#define SMCLK_9600      1
#define ACLK_9600       2

#define UART_MODE       SMCLK_9600

//------------------------------------------------------------------------------
// Definition of Variables
//-----------------------------------------------------------------------------
// RAM variables go here (word = int/short, byte = char)
unsigned int j;
unsigned int z;
unsigned int y;
unsigned int counter;
unsigned int count;
unsigned int stepNumber;
unsigned int DELAY_COUNT=0;

char buffer[0];
char doorClosed='B';
int x = 0;

//------------------------------------------------------------------------------
// Function prototypes
void setup()
{
    // Set up Port 1
    P1DIR |= STEP+DIR; // set P1.3, P1.4 as output

    // Set up Port 2 (all pin input)
    //P2REN |= PB_ACW+PB_CW; // enable internal resistance
    //P2OUT |= PB_ACW+PB_CW; // set internal resistance as pull-down

    P1SEL = BIT1 + BIT2;       // P1.1 = RXD, P1.2=TXD
    P1SEL2 = BIT1 + BIT2;

    // Set up calibrated DCO clock
    DCOCTL = 0;             // Select lowest DCOx and MODx settings
    BCSCTL1 = CALBC1_16MHZ;  // Set range
    DCOCTL = CALDCO_16MHZ;   // Set DCO step + modulation
}
void delay()
{
    // Load count constant and decrement until 0
    count = DELAY_COUNT;
    for(j=100;j>0;j--)
    {
        for(counter=DELAY_COUNT;counter>0;counter--)
        {
            do
            {
                count--;
            } while(count != 0);
            count=DELAY_COUNT;
        }
    }

}


void SendUCA0Data(uint8_t data)
{
    while (!(IFG2&UCA0TXIFG));                // USCI_A0 TX buffer ready?
    UCA0TXBUF = data;
}
void initUART()
{
    UCA0CTL1 |= UCSSEL_2;                     // SMCLK
    UCA0BR0 = 104;                            // 16MHz 9600
    UCA0BR1 = 0;                              // 16MHz 9600
    UCA0MCTL = UCBRS_0 + UCOS16 + UCBRF_3;    // Modulation UCBRSx = 0
    UCA0CTL1 &= ~UCSWRST;                     // **Initialize USCI state machine**
    IFG2 &= ~(UCA0RXIFG);
    IE2 |= UCA0RXIE;                          // Enable USCI_A0 RX interrupt
}

//******************************************************************************
// Main ************************************************************************
// Enters LPM0 if SMCLK is used and waits for UART interrupts. If ACLK is used *
// then the device will enter LPM3 mode instead. The UART RX interrupt handles *
// the received character and echoes it.                                       *
//******************************************************************************

void main()
{
    WDTCTL = WDTPW + WDTHOLD;                 // Stop WDT
    setup();
    initUART();



#if UART_MODE == ACLK_9600
    __bis_SR_register(LPM3_bits + GIE);       // Since ACLK is source, enter LPM3, interrupts enabled
#else
    __bis_SR_register(LPM0_bits + GIE);       // Since SMCLK is source, enter LPM0, interrupts enabled
#endif
}

//******************************************************************************
// UART RX Interrupt ***********************************************************
//******************************************************************************

#if defined(__TI_COMPILER_VERSION__) || defined(__IAR_SYSTEMS_ICC__)
#pragma vector=USCIAB0RX_VECTOR
__interrupt void USCI0RX_ISR(void)
#elif defined(__GNUC__)
void __attribute__ ((interrupt(USCIAB0RX_VECTOR))) USCI0RX_ISR (void)
#else
#error Compiler not supported!
#endif
{
    if (IFG2 & UCA0RXIFG)
    {
        uint8_t rx_val = UCA0RXBUF; //Must read UCxxRXBUF to clear the flag
       // SendUCA0Data(rx_val);
        buffer[x] = rx_val;
        if (buffer[x] == 'A'){
            P1OUT &= 0x00; //Pull direction pin low to move "FORWARD"
            DELAY_COUNT=10;
            for(z=13600;z>0;z--) //Loop the stepping enough times for motion to be visible
            {
                P1OUT|=STEP; //Trigger one step forward
                delay();
                P1OUT = ~STEP; //Pull step pin low so it can be triggered again
                delay();
            }
           delay();
            P1OUT |= DIR; //Pull direction pin high to move "REVERSE"
            DELAY_COUNT=10;
            for(y=13600;y>0;y--) //Loop the stepping enough times for motion to be visible
            {
                P1OUT |= STEP+DIR; //Trigger one step forward
                delay();
                P1OUT = ~STEP+DIR; //Pull step pin low so it can be triggered again
                delay();
            }

            SendUCA0Data(doorClosed);
        }
        x++;
    }
}
