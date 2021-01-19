/*
 * this is derived from 
 * https://wiki.dfrobot.com/Arduino_LCD_KeyPad_Shield__SKU__DFR0009_
 * as well as from the basic examples from
 * http://www.schmalzhaus.com/EasyDriver/Examples/EasyDriverExamples.html
*/

//we re using the LiquidCrystal library, so make sure it is available in the correct place
#include <LiquidCrystal.h>

// select the pins used on the LCD panel
LiquidCrystal lcd(8, 9, 4, 5, 6, 7);

// define the pins for the EasyDriver stepper driver
int DIR = 3;          // PIN  3 = DIR
int STEP = 2;        // PIN  2 = STEP
// currently not used - maybe we need them later.
// int SLEEP = 1;      // maybe we enable this later bring down the power consumption
// MS1 and MS2 will be hard wired to GND to enable full step mode, otherwise we would have 1/8th steps

// some variables need initial values
int StepDistance = 50; // with full steps we should have 50 steps; adapt to your very own stepper motor
int StepCounter = 0; // we have to count the number of already executed steps
int StepDelay = 500; // we are using a minimal delay between our HIGH/LOW signals
int triggerOpen = false; // initial state should be false, so no action is triggered 
int triggerClose = false; // initial state should be false, so no action is triggered
int triggerFire = false; // initial state should be false, so no action is triggered



// define some values used by the panel and buttons
int lcd_key     = 0;
int adc_key_in  = 0;
#define btnRIGHT  0
#define btnUP     1
#define btnDOWN   2
#define btnLEFT   3
#define btnSELECT 4
#define btnNONE   5
int btnDelay = 200; // with this we are slow down the code execution to get a clean event for a short button action.

// initial values (picked from the two arrays below) - make sure that their values are consistent
int shutterIndex = 7; // 7 should point to the initial shutter speed of 1s
int shutterSpeed = 1000; // this should correspond to our shutterIndex for 1s 
String shutterText = String("1s"); // this should also correspond to our initial shutter speed

// array for showing the selected shutter speeds in the most common way
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

// array for the shutter speeds in seconds the variable shutterSpeed will be picked and calculated from this array
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
    // setting the correct direction for opening
    digitalWrite(DIR, HIGH); 
    
    // the EasyDriver stepper driver needs a change from the input signal, so we give a HIGH and a LOW signal on the STEP pin
    digitalWrite(STEP, LOW);
    delayMicroseconds(StepDelay);         
    digitalWrite(STEP, HIGH);
    delayMicroseconds(StepDelay);

    StepCounter = StepCounter + 1; // counting the steps
    
    // after reaching the StepDistance, we print a new message on the LCD and set our trigger variables and reset the StepCounter
    if (StepCounter == StepDistance) 
    {
      lcd.setCursor(0,0);
      lcd.print("Shutter opened");
      StepCounter = 0;
      triggerOpen = false;
      
      // if our opening was triggered by the firing (SELECT) button, we print a new message, wait as long as our current shutterspeed 
      // then print another message and re(set) our trigger variables
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

  // shutter closing action is similar to our opening action, but a little bit easier
  // as we don't have to take care about how the closing was triggered
  if (triggerClose == true)
  {
    digitalWrite(DIR, LOW); 
    digitalWrite(STEP, LOW);
    delayMicroseconds(StepDelay);         
    digitalWrite(STEP, HIGH);
    delayMicroseconds(StepDelay);

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

 // depending on which button was pushed, we set some variables and show corresponding messages on the LCD
 // we are using a small delay (set via btnDelay) to get single button events
 switch (lcd_key)               
 {
   case btnRIGHT:
     {
     // go to the next shutter speed (and text) in our arrays
     // caution: we have to limit this so we stay within our defined array
     delay(btnDelay);
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
     delay(btnDelay);
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
     delay(btnDelay);
     
     // set the open & close triggers
     triggerOpen = true;
     triggerClose = false; 
     triggerFire = false;
     
     break;
     }
   case btnDOWN:
     {
     // close the shutter
     delay(btnDelay);

     // set the open & close triggers
     triggerOpen = false;
     triggerClose = true; 
     triggerFire = false;
     
     break;
     }
   case btnSELECT:
     {
     // fire the shutter
     delay(btnDelay); 

     // set the open & close triggers
     triggerOpen = true;
     triggerClose = false; 
     triggerFire = true;
     
     break;
     }
     case btnNONE:
     {
     // just do nothing
     
     break;
     }
 }

}
