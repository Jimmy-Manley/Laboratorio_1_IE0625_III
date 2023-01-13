#include <pic14/pic12f675.h>
// Interfacing 74HC95 Serial Shift Register
#define push_button GP5	//push button
#define LED_A GP0	//serial data in pin 14
#define LED_B GP1
#define LED_C GP2
#define LED_D GP4

/*========= Globals=========*/
char data[6] = {0x01,0x02,0x03,0X06,0x07,0X16};
/* ======== Function space ==========*/
/* setup function*/
void setup (void)
{
	ADCON0 = 0x00;
	ANSEL = 0x00;
	CMCON = 0x07; //shut off comparator
	VRCON = 0X00;
	TRISIO = 0X20;	// set all GPIOs as outputs, except GP5= push button
	GPIO = 0x20;	// set all pins low except GP5 
}

/* Delay function */
void delay (unsigned int tiempo);

/*check_pushbutton is pressed on startup, if so turn on all leds*/
void check_pushbutton(void)
{
	if(push_button == 0)// switch pressed
	{
	delay(250);
	if(push_button == 0)// switch pressed
		{
			GPIO = data[5];
		
		}
	}
}

 /*======= Main loop ========*/
void main(void)
{

    unsigned int time = 250;
    
    setup();

    delay(time);

    while(1)
    {	
    	for(int i=0;i<6;i++)
	{
		
		if(push_button == 0)
		{
		
		   GPIO = data[i];
		   //break;
		   delay(time);		

		}
		
	}
    }
    return;
}

void delay(unsigned int tiempo)
{
	unsigned int i;
	unsigned int j;

	for(i=0;i<tiempo;i++)
	  for(j=0;j<1275;j++);
}
