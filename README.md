Scalable and adaptable leaf shutter

Seems you are interested in large format photography stuff, otherwise you wouldn't be here - right?
As the title of this project already suggests, this is all about my attempt to create an electronically controlled leaf shutter.

If I am not misinformed, large format shutters aren't produced any longer, so we are stuck with a limited number of available shutters on the second hand market. 
And since we can assume that the vast majority of the available shutters aren't serviced as they should be, the market for good and working shutters is shrinking and their prices are ascending.

But...
- ... we have 3D printers capable of printing quite precise parts.
- ... we have cheap and capable microcontrollers and other electronic components.

So why not building our own, electronically controlled large format leaf shutter...???

Let's start with my very own project goals and requirements:
- leaf shutter design with 5 or 6 leaves as most of the classic Copal/Compur/Compound/Seiko/Rapax/Alphax/... shutters
- simple mechanics
- scalable and adaptable design, primarily as behind-the-lens-shutter, not necessarily as between-the-lens-shutter
- shutter opening of 30...70mm, maybe even larger
- electronically controlled by widely available microcontroller
- capable of most common large format shutter speeds 1/30 ... 30s
- all components either 3D printed or widely available from eBay, Aliexpress, Amazon or local hardware/DIY shops
- no expensive or exotic components
- besides 3D printer and soldering iron no need for special tools

Some project goals:
- rethinking old and established designs
- refining my OpenSCAD skills
- prototyping and showcasing a working shutter
- refresh some of my almost forgotten knowledge about basic electronics
- learn a little bit about microcontrollers and their programming
- design good and easy enough to be just a blueprint for less experienced people to just make their own builds.
- design universal and modular enough to be adaptable to different components (different microcontrollers, steppers, stepper drivers, battery holders, connectors, screws, ...)


Early design decisions:
- completely 3D printed shutter leaves and gears. Although thin steel leaves with about 0.1mm were a nice choice, they would be quite difficult to cut and drill precisely - at least at the kitchen table (which is my workshop). After some initial testing I found out that printed shutter leaves with about 0.3 mm seem to be sufficient and quite easy to make, including a partial gear. 
- in contrast to the existing leaf shutter designs I will use a gear ring and gears instead of levers and curves for opening/closing the shutter. In my opinion this should be superior in terms of friction and keeping tolerances.
- Arduino UNO Rev. 3 as microcontroller. Maybe also a version with an Arduino NANO.
- LCD and Keypad shield similar to this one: https://www.dfrobot.com/product-51.html
- Mechanics driven by a stepper motor similar to this one: https://www.omc-stepperonline.com/pancake-nema-11-bipolar-1-8deg-10ncm-14-164oz-in-0-5a-28x28x9-5mm-4-wires.html . Initial thoughts also included solenoid-driven opening/closing, but a stepper motor driven design seems to be easier and superior in terms of longer shutter speeds (and keeping the shutter open for setting up). 
- Stepper driver similar to the EasyDriver https://www.schmalzhaus.com/EasyDriver/ 

Current status:
- mechanics designs for the first prototype 90%
- electronic design for the first prototype 90%
- programming for the first prototype 90%

Next steps or the long way to version 1.0:
- test driving the first prototype
- bug fixing and optimizing the initial programing
- cleaning up the SCAD files
- cleaning up the Arduino sketch
- designing a case for the control unit
- adapt the shutter unit to a lensboard and a (barrel) lens
- some real world testing
- releasing version 1.0 :-)
- make Marc Morel happy with a self timer :-) (still one button unassigned...)

Some very kind people asked me about the possibility to show their appreciation by donating to me.
If you really felt somehow obliged to do so, then you should use https://paypal.me/EdgarKech :-) .
But I am also happy if you post pictures of your build to https://www.facebook.com/groups/3dprinting.and.analog.photography/

Update 2021-01-16:
- Added some pictures of the mechanics.
- With some minor tweaking I was able to reduce the overall friction which also allowed me to reduce the delays between the steps to the half. So for now (with a 1.8° per step stepper motor) opening and closing the shutter takes about 1/10s. A different stepper (7.5° per step) will reduce the number of necessary steps from 50 to 10 and thus the opening and closing time to about 1/50s. There's also the chance that I will get enough torque from that (already ordered) stepper to be able to change the gear ratio (and hopefully keep my current delay settings without losing steps)... let's wait and see. 

Update 2021-01-24:
- still waiting for the faster stepper motors, so no updates to the shutter mechanics
- changed the shutter body: added "ears" for screwing the shutter to lid and lens adapter
- added integrated shutter lid / lensboard (Linhof/Wista style)
- added lens flange for adapting threaded barrel or process lenses (in this case for LOMO RF-3 or RF-4 process lenses)
- added controller case (buttons currently missing!)
- some SCAD code consolidation in progress
- re-created the STLs to match the current SCAD files

Update 2021-01-30:
- modified all direct shutter .scad files to use the config.scad as configuration file. This makes scaling up/down easier and helps getting proper/fitting/consistent parts. Please be aware that there might be some bugs, as I didn't recreate, test and print all changed STLs.
