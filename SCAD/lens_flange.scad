// loading the base configuration
// include <config.scad>;

// some modules such as hex, countersunk screws, roof, wedge are available in a module file
use <modules.scad>;
use <threads.scad>;

$fn=120;

vWallStrength = 2;
vTolerance = 0.2;

vNoOfBlades = 5;
vAngleIncrement = 360/vNoOfBlades;
vBladeThickness = 0.3;

vShutterBodyOuter_d = 94;
vShutterBodyOuter_h = 8;
vShutterBodyOuter_offsetX = 0;
vShutterBodyOuter_offsetY = 0;
vShutterBodyOuter_offsetZ = 0;

vShutterOpening_d = 40;
vShutterOpening_h = vShutterBodyOuter_h;

vLensThread_d = 52.3; // Lomo RF3
vLensThread_h = 9; // Lomo RF3
//vLensThread_d = 60.3; // Lomo RF4
//vLensThread_h = 11; // Lomo RF4
vLensThreadPitch = 0.75;
vLensThread_offsetX = 0;
vLensThread_offsetY = 0;
vLensThread_offsetZ = 7;

vLensBore_d = 51+(2*vTolerance); // Lomo RF3
//vLensBore_d = 58+(2*vTolerance); // Lomo RF4
vLensBore_h = 7;
vLensBore_offsetX = 0;
vLensBore_offsetY = 0;
vLensBore_offsetZ = 0;

vLensRing_d1 = vLensThread_d + 28;
vLensRing_d2 = vLensThread_d + 6;
vLensRing_h = vLensBore_h + vLensThread_h;



vLidScrewTube_d = 10;
vLidScrewHole_d = 4.5;
vLidScrewTube_h = 8;
vLidScrewTube_offsetX = (vShutterBodyOuter_d + vLidScrewHole_d) / 2;
vLidScrewTube_offsetY = 0;
vLidScrewTube_offsetZ = 0;

vRib_l = (vShutterBodyOuter_d + vLidScrewHole_d);
vRib_w = vLidScrewTube_d;
vRib_h = vLidScrewTube_h;
vRib_offsetX = -vRib_l/2;
vRib_offsetY = -vRib_w/2;
vRib_offsetZ = 0;

vStepperCutout_l = 40;
vStepperCutout_w = 30;
vStepperCutout_h = vLensRing_h;
vStepperCutout_offsetX = 38;
vStepperCutout_offsetY = -vStepperCutout_w/2;
vStepperCutout_offsetZ = 0;

    difference(){
        union(){
            // lens ring
            cylinder(d1=vLensRing_d1, d2=vLensRing_d2, h=vLensRing_h);
            
            // we add a box for the power gear
            for (a =[0:1:3]){
                rotate([0, 0, (a*90)+45])
                    translate([vRib_offsetX, vRib_offsetY, vRib_offsetZ])
                        cube([vRib_l, vRib_w, vRib_h]);
            };
            
            // tubes for the lid screws
            for (a =[0:1:3]){
                rotate([0, 0, (a*90)+45])
                    translate([vLidScrewTube_offsetX, vLidScrewTube_offsetY, vLidScrewTube_offsetZ])
                        cylinder(d=vLidScrewTube_d, h=vLidScrewTube_h);
            };
        };
        // subtracting the lens thread
        translate([vLensThread_offsetX, vLensThread_offsetY, vLensThread_offsetZ])
            metric_thread(diameter=vLensThread_d, pitch=vLensThreadPitch, length=vLensThread_h, internal=true, n_starts=1,
                      thread_size=-1, groove=false, square=false, rectangle=0,
                      angle=30, taper=0, leadin=2, leadfac=1.0, test=false);
        
        // lens bore
        translate([vLensBore_offsetX, vLensBore_offsetY, vLensBore_offsetZ])
        cylinder(d=vLensBore_d, h = vLensBore_h);
        
        
        // cutout for stepper motor
        translate([vStepperCutout_offsetX, vStepperCutout_offsetY, vStepperCutout_offsetZ])
                        cube([vStepperCutout_l, vStepperCutout_w, vStepperCutout_h]);
        
         
        // screw holes for the lid screws
        for (a =[0:1:3]){
            rotate([0, 0, (a*90)+45])
                translate([vLidScrewTube_offsetX, vLidScrewTube_offsetY, vLidScrewTube_offsetZ])
                    cylinder(d=vLidScrewHole_d, h=vLidScrewTube_h);
        };
};