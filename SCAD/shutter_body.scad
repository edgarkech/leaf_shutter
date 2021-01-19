// loading the base configuration
// include <config.scad>;

// some modules such as hex, countersunk screws, roof, wedge are available in a module file
use <modules.scad>;

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

vShutterBodyInner_d = vShutterBodyOuter_d - (2*vWallStrength);
vShutterBodyInner_h = vShutterBodyOuter_h - vWallStrength;
vShutterBodyInner_offsetX = 0;
vShutterBodyInner_offsetY = 0;
vShutterBodyInner_offsetZ = vWallStrength;

vShutterOpening_d = 40;
vShutterOpening_h = vShutterBodyOuter_h;

vStepperMotorAxis_d = 5;
vStepperMotorAxis_h = vShutterBodyOuter_h;
vStepperMotorAxis_offsetX = 53.5;
vStepperMotorAxis_offsetY = 0;
vStepperMotorAxis_offsetZ = 0;

vStepperMotorScrewHole_d = 3.5;
vStepperMotorScrewHole_h = vShutterBodyOuter_h;
vStepperMotorScrewHole_offsetX = vStepperMotorAxis_offsetX;
vStepperMotorScrewHole_offsetY = 17;
vStepperMotorScrewHole_offsetZ = 0;


vPowerGearBox_l = vStepperMotorAxis_offsetX+10;
vPowerGearBox_w = 2*(vStepperMotorScrewHole_offsetY+vStepperMotorScrewHole_d);
vPowerGearBox_h = vShutterBodyOuter_h;
vPowerGearBox_offsetX = 0;
vPowerGearBox_offsetY = -vPowerGearBox_w/2;
vPowerGearBox_offsetZ = 0;

vPowerGearCutout_l = vPowerGearBox_l;
vPowerGearCutout_w = 2*(vStepperMotorScrewHole_offsetY-vStepperMotorScrewHole_d); // assuming a gear with 20 teeth and module 1, we need about 25mm
vPowerGearCutout_h = vShutterBodyInner_h;
vPowerGearCutout_offsetX = 0;
vPowerGearCutout_offsetY = -vPowerGearCutout_w/2;
vPowerGearCutout_offsetZ = vWallStrength+vBladeThickness+(2*vTolerance);



vBladeAxisHole_d = 4.4;
vBladeAxisHole_h = 5;
vBladeAxisHole_offsetR = 25; 

vBladeAxisPin_d = 4-(2*vTolerance);
vBladeAxisPin_h = vShutterBodyOuter_h + vWallStrength;
vBladeAxisPin_offsetR = 25;

vOuterGearBasePad_d = 6;
vOuterGearBasePad_h = vWallStrength+vBladeThickness+(2*vTolerance);
vOuterGearBasePad_offsetR = 42.5;

vLidScrewTube_d = 10;
vLidScrewHole_d = 4.5;
vLidScrewTube_h = vShutterBodyOuter_h;
vLidScrewTube_offsetX = (vShutterBodyOuter_d + vLidScrewHole_d) / 2;
vLidScrewTube_offsetY = 0;
vLidScrewTube_offsetZ = 0;



union(){
    difference(){
        union(){
            // outer cylinder
            cylinder(d=vShutterBodyOuter_d, h=vShutterBodyOuter_h);
            
            // we add a box for the power gear
            translate([vPowerGearBox_offsetX, vPowerGearBox_offsetY, vPowerGearBox_offsetZ])
            cube([vPowerGearBox_l, vPowerGearBox_w, vPowerGearBox_h]);
            
            // tubes for the lid screws
            for (a =[0:1:3]){
                rotate([0, 0, (a*90)+45])
                    translate([vLidScrewTube_offsetX, vLidScrewTube_offsetY, vLidScrewTube_offsetZ])
                        cylinder(d=vLidScrewTube_d, h=vLidScrewTube_h);
            };
        };
        // subtracting the inner cylinder
        translate([vShutterBodyInner_offsetX, vShutterBodyInner_offsetY, vShutterBodyInner_offsetZ])
            cylinder(d=vShutterBodyInner_d, h=vShutterBodyInner_h);
        
        // shutter opening
        translate([0,0,0])
        cylinder(d=vShutterOpening_d, h = vShutterOpening_h);
        
        
        
        // cutout for power gear
        translate([vPowerGearCutout_offsetX, vPowerGearCutout_offsetY, vPowerGearCutout_offsetZ])
            cube([vPowerGearCutout_l, vPowerGearCutout_w, vPowerGearCutout_h]);
        
        // Stepper motor axis hole
        translate([vStepperMotorAxis_offsetX, vStepperMotorAxis_offsetY, vStepperMotorAxis_offsetZ])
            cylinder(d=vStepperMotorAxis_d, h=vStepperMotorAxis_h);
        
        // stepper motor screw holes
        translate([vStepperMotorScrewHole_offsetX, vStepperMotorScrewHole_offsetY, vStepperMotorScrewHole_offsetZ])
            cylinder(d=vStepperMotorScrewHole_d, h= vStepperMotorScrewHole_h);
        translate([vStepperMotorScrewHole_offsetX, -vStepperMotorScrewHole_offsetY, vStepperMotorScrewHole_offsetZ])
            cylinder(d=vStepperMotorScrewHole_d, h= vStepperMotorScrewHole_h);
         
        // screw holes for the lid screws
        for (a =[0:1:3]){
            rotate([0, 0, (a*90)+45])
                translate([vLidScrewTube_offsetX, vLidScrewTube_offsetY, vLidScrewTube_offsetZ])
                    cylinder(d=vLidScrewHole_d, h=vLidScrewTube_h);
        };
//        };
    /*
    // this is for using screws instead of pins
    for (a =[0:1:vNoOfBlades-1]){
            rotate([0, 0, a*vAngleIncrement])
                translate([vBladeAxisHole_offsetR, 0, 0])
                    cylinder(d=vBladeAxisHole_d, h=vBladeAxisHole_h );
        };
    */
}
// Auflage für den Zahnkranz
for (a =[0:1:vNoOfBlades-1]){
            rotate([0, 0, a*vAngleIncrement])
                translate([vOuterGearBasePad_offsetR, 0, 0])
                    cylinder(d=vOuterGearBasePad_d, h=vOuterGearBasePad_h );
        };

// Pins for the shutter blades
for (a =[0:1:vNoOfBlades-1]){
            rotate([0, 0, a*vAngleIncrement])
                translate([vBladeAxisPin_offsetR, 0, 0])
                    cylinder(d=vBladeAxisPin_d, h=vBladeAxisPin_h );
        };

};