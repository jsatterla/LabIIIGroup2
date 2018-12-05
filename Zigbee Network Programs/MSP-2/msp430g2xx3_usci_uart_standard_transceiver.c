#include <msp430.h>
#include <stdint.h>

/*Program for Controller of Zigbee Test Network,
 * adapted from msp430g2xx3_usci_uart_standard_transceiver.c example
 * by Nima Eskandari at Texas Instruments
 */
/******************************************************************************
**************************UART Initialization *********************************
******************************************************************************/

#define SMCLK_11500     0
#define SMCLK_9600      1
#define ACLK_9600       2

#define UART_MODE       SMCLK_9600

char buffer[400];
int x = 0;

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

/*******************************************************************************
***************************Device Initialization *******************************
********************************************************************************/

void initClockTo16MHz()
{
    if (CALBC1_16MHZ==0xFF)                  // If calibration constant erased
    {
        while(1);                            // do not load, trap CPU!!
    }
    DCOCTL = 0;                              // Select lowest DCOx and MODx settings
    BCSCTL1 = CALBC1_16MHZ;                  // Set DCO
    DCOCTL = CALDCO_16MHZ;
}

void initGPIO()
{
    P1SEL = BIT1 + BIT2;                      // P1.1 = RX, P1.2=TX
    P1SEL2 = BIT1 + BIT2;
    P1DIR |= 0x01;                            // Set P1.0 to output direction
    P2DIR |= BIT0 + BIT1 + BIT2 +BIT3;                     // port 2 all outputs
    P2SEL |= BIT1;

}

/******************************************************************************
***********************************Main ***************************************
****Enters LPM0 if SMCLK is used and waits for UART interrupts. The UART RX****
**********interrupt handles the received character and echoes it.**************
******************************************************************************/

void main()
{
    WDTCTL = WDTPW + WDTHOLD;                 // Stop WDT
    initClockTo16MHz();
    initGPIO();
    initUART();

    TA1CCR0 |= 640 - 1;
    TA1CCTL1 |= OUTMOD_7;
    TA1CCR1 |= 10;
    TA1CTL |= TASSEL_2 + MC_1;

    __bis_SR_register(GIE);       // Since ACLK is source, enter LPM3, interrupts enabled

}

/******************************************************************************
***************************UART RX Interrupt **********************************
******************************************************************************/

void __attribute__ ((interrupt(USCIAB0RX_VECTOR))) USCI0RX_ISR (void)
{
    if (IFG2 & UCA0RXIFG)
        {
            char rx_val = UCA0RXBUF; //Must read UCxxRXBUF to clear the flag
            buffer[x] = rx_val;         //place received value into buffer
            SendUCA0Data(buffer[x]);

            switch (buffer[x]){
                case '1':                   //turn off LED 1
                    P1OUT &= ~BIT0;
                    break;
                case '2':                   //turn on LED 1
                    P1OUT |= BIT0;
                    break;
                case '3':                   //turn off LED 2
                    P2OUT &= ~BIT0;
                    break;
                case '4':                   //turn on LED 2
                    P2OUT |= BIT0;
                    break;
                case '5':                   //turn off LED 3
                    P2OUT &= ~BIT2;
                    break;
                case '6':                   //turn on LED 3
                    P2OUT |= BIT2;
                    break;
                case '7':                   //turn off LED 4
                    P2OUT &= ~BIT3;
                    break;
                case '8':                   //turn on LED 4
                    P2OUT |= BIT3;
                    break;
                case 'G':                   //set fan to low
                    TA1CCR1 = 400;
                    break;
                case 'H':                   //set fan to high
                    TA1CCR1 = 600;
                    break;
                case 'I':                   //set fan to idle
                    TA1CCR1 = 0;
                    break;
            }
            x++;
        }

}
