Scalable and adaptable leaf shutter

Seems you are interested in large format photography stuff, otherwise you wouldn't be here - right?
As the title of this project already suggests, this is all about my attempt to create an electronically controlled leaf shutter.

If I am not misinformed, large format shutters aren't produced any longer, so we are stuck with a limited number of available shutters on the second hand market. 
And since we can assume that the vast majority of the available shutters aren't serviced as they should be, the market for good and working shutters is shrinking and their prices are ascending.

But...
- ... we have 3D printers capable of printing quite precise parts.
- ... we have cheap and capable microcontrollers and other electronic components.

So why not building our own, electronically controlled large format leaf shutter...???

let's start with my very own project goals and requirements:
- leaf shutter design with 5 or 6 leaves as most of the classic Copal/Compur/Compound/Seiko/Rapax/Alphax/... shutters
- simple mechanics
- scalable and adaptable design, primarily as behind-the-lens-shutter, not necessarily as between-the-lens-shutter
- shutter opening of 30...70mm, maybe even larger
- electronically controlled by widely available microcontroller
- capable of most common large format shutter speeds 1/30 ... 30s
- all components either 3D printed or widely available from eBay, Aliexpress, Amazon or local DIY
- no expensive or exotic components
- besides 3D printer and soldering iron no need for special tools

Some project goals:
- rethinking old and established designs
- refining my OpenSCAD skills
- prototyping and showcasing a working shutter
- refresh some of my almost forgotten knowledge about basic electronics
- learn a little bit about microcontrollers and their programming

Early design decisions:
- completely 3D printed shutter leaves and gears
- in contrast to the existing leaf shutter designs I will use a gear ring and gears instead of levers and curves for opening/closing the shutter
- Arduino UNO Rev. 3 as microcontroller
- LCD and Keypad shield similar to this one: https://www.dfrobot.com/product-51.html
- Mechanics driven by a stepper motor similar to this one: https://www.omc-stepperonline.com/pancake-nema-11-bipolar-1-8deg-10ncm-14-164oz-in-0-5a-28x28x9-5mm-4-wires.html . Initial thoughts also included solenoid-driven opening/closing, but a stepper motor driven design seems to be easier. 
- Stepper driver similar to the EasyDriver https://www.schmalzhaus.com/EasyDriver/ 

Current Status:
- mechanics designs for the first prototype 90%
- electronic design for the first prototype 90%
- programming for the first prototype 90%

Next steps:
- test driving the first prototype
- bug fixing and optimizing the initial programing
- cleaning up the SCAD files
- cleaning up the Arduino sketch
- publishing the SCAD files and the Arduino sketch
- designing a case for the control unit
- adapt the shutter unit to one of my cameras
- real world testing with a barrel lens

Some very kind people asked me about the possibility to show their appreciation by donating to me.
If you really felt somehow obliged to do so, then you should use https://paypal.me/EdgarKech :-) .
But I am also happy if you post pictures of your build to https://www.facebook.com/groups/3dprinting.and.analog.photography/


