/** this is derived from 
 * https://wiki.dfrobot.com/Arduino_LCD_KeyPad_Shield__SKU__DFR0009_
 *    
 *  For german explanation visit 
 *  http://www.fambach.net
 */

//Sample using LiquidCrystal library
#include <LiquidCrystal.h>

/*******************************************************
This program will test the LCD panel and the buttons
Mark Bramwell, July 2010
********************************************************/

// select the pins used on the LCD panel
LiquidCrystal lcd(8, 9, 4, 5, 6, 7);

// define the pins for the EasyDriver stepper driver
int DIR = 3;          // PIN  3 = DIR
int STEP = 2;        // PIN  2 = STEP

int StepDistance = 50; // with full steps we should have 50 steps
int StepCounter = 0;
int StepDelay = 1;
int triggerOpen = false;
int triggerClose = false;
int triggerFire = false;

// currently not used - maybe we need them later.
// int SLEEP = 1;      // PIN 13 = SLP

// define some values used by the panel and buttons
int lcd_key     = 0;
int adc_key_in  = 0;
#define btnRIGHT  0
#define btnUP     1
#define btnDOWN   2
#define btnLEFT   3
#define btnSELECT 4
#define btnNONE   5

// initial values (picked from the arrays below)
int shutterIndex = 7;
int shutterSpeed = 1000;
String shutterText = String("1s");

// array for showing the selected shutter speeds in the most usual way
char textarray[][8] = {
  "1/125s", 
  "1/60s ", 
  "1/30s ", 
  "1/15s ", 
  "1/8s  ",
  "1/4s  ",
  "1/2s  ",
  "1s    ",
  "2s    ",
  "3s    ",
  "4s    ",
  "6s    ",
  "8s    ",
  "10s   ",
  "15s   ",
  "20s   ",
  "25s   ",
  "30s   ",
  "40s   ",
  "50s   ",
  "60s   ",
  "90s   ",
  "120s  ",
  "180s  ",
  "240s  ",
  "300s  ",
  "360s  ",
  "420s  ",
  "480s  ",
  "540s  ",
  "600s  "
  };

// array for the shutter speeds
float speedarray[] = {
  0.008,
  0.01667,
  0.03333,
  0.06667,
  0.125,
  0.25,
  0.5,
  1,
  2,
  3,
  4,
  6,
  8,
  10,
  15,
  20,
  25,
  30,
  40,
  50,
  60,
  90,
  120,
  180,
  240,
  300,
  360,
  420,
  480,
  540,
  600
  };  


// read the buttons
int read_LCD_buttons()
{
 adc_key_in = analogRead(0);      // read the value from the sensor 
 // my buttons when read are centered at these valies: 0, 144, 329, 504, 741
 // we add approx 50 to those values and check to see if we are close
 if (adc_key_in > 1000) return btnNONE; // We make this the 1st option for speed reasons since it will be the most likely result
 // For V1.1 us this threshold
 if (adc_key_in < 50)   return btnRIGHT;  
 if (adc_key_in < 250)  return btnUP; 
 if (adc_key_in < 450)  return btnDOWN; 
 if (adc_key_in < 650)  return btnLEFT; 
 if (adc_key_in < 850)  return btnSELECT;  

 return btnNONE;  // when all others fail, return this...
}

void setup()
{
 lcd.begin(16, 2);              // start the library
 lcd.setCursor(0,0);
 lcd.print("Shutter closed"); // print a simple message
 lcd.setCursor(0,1);
 lcd.print(String(shutterText));
 pinMode(DIR, OUTPUT);
 pinMode(STEP, OUTPUT);
 digitalWrite(DIR, LOW);
 digitalWrite(STEP, LOW);
}
 
void loop()
{
   
  // shutter opening action
  if (triggerOpen == true)
  {
    digitalWrite(DIR, HIGH); 
    digitalWrite(STEP, HIGH);
    delay(StepDelay);         
    digitalWrite(STEP, LOW);
    delay(StepDelay);

    StepCounter = StepCounter + 1;

    if (StepCounter == StepDistance)
    {
      lcd.setCursor(0,0);
      lcd.print("Shutter opened");
      StepCounter = 0;
      triggerOpen = false;

      if (triggerFire == true)
      {
        lcd.setCursor(0,0);
        lcd.print("Exposing......");
        
        delay(shutterSpeed);
        
        triggerClose = true;
        triggerFire = false;
        
      }
    }
  }

  // shutter closing action
  if (triggerClose == true)
  {
    digitalWrite(DIR, LOW); 
    digitalWrite(STEP, HIGH);
    delay(StepDelay);         
    digitalWrite(STEP, LOW);
    delay(StepDelay);

    StepCounter = StepCounter + 1;

    if (StepCounter == StepDistance)
    {
      StepCounter = 0;
      triggerClose = false;
      lcd.setCursor(0,0);
      lcd.print("Shutter closed");
    }
  }
 
 lcd_key = read_LCD_buttons();  // read the buttons

 switch (lcd_key)               // depending on which button was pushed, we perform an action
 {
   case btnRIGHT:
     {
     // go to the next shutter speed (and text) in our arrays
     // caution: we have to limit this so we stay within our defined array
     delay(200);
     shutterIndex = shutterIndex+1;
     shutterSpeed = 1000*speedarray[shutterIndex];
     shutterText = textarray[shutterIndex]; 
     
     lcd.setCursor(0,1);
     lcd.print(String(shutterText));
     
     break;
     }
   case btnLEFT:
     {
     // go to the previous shutter speed (and text) in our arrays
     // caution: we have to limit this so we stay within our defined array
     delay(200);
     shutterIndex = shutterIndex-1; 
     shutterSpeed = 1000*speedarray[shutterIndex];
     shutterText = textarray[shutterIndex]; 
     
     lcd.setCursor(0,1);
     lcd.print(String(shutterText));
     
     break;
     }
   case btnUP:
     {
     // open the shutter
     delay(200);
     
     
     // some logic for opening the shutter

     // set the open & close triggers
     triggerOpen = true;
     triggerClose = false; 
     triggerFire = false;
     
     break;
     }
   case btnDOWN:
     {
     // close the shutter
     delay(200);

     // set the open & close triggers
     triggerOpen = false;
     triggerClose = true; 
     triggerFire = false;
     
     break;
     }
   case btnSELECT:
     {
     // fire the shutter
     delay(200); 

     // set the open & close triggers
     triggerOpen = true;
     triggerClose = false; 
     triggerFire = true;
     
     break;
     }
     case btnNONE:
     {
     
     //reset 
     //lcd.print("NONE  ");
     break;
     }
 }

}
