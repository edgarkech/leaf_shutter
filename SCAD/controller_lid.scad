
// loading the base configuration
// include <config.scad>;

// some modules such as hex, countersunk screws, roof, wedge are available in a module file
use <modules.scad>;
//use <threads.scad>;

$fn=120;

vWallStrength = 2;
vTolerance = 0.2;



// for easier vizualization
vController_l = 80;
vController_w = 60;
vController_h = 26;
vController_offsetX = 0;
vController_offsetY = 0;
vController_offsetZ = 4;

// not a real object here, but needed for calculating some offsets
vDriver_l = 22;
vDriver_w = 50;
vDriver_h = 10;
vDriver_offsetX = vController_l + 5;
vDriver_offsetY = 0;
vDriver_offsetZ = 4;

// not a real object here, but needed for calculating some offsets
vBattery_l = 18;
vBattery_w = 50;
vBattery_h = 28;
vBattery_offsetX = vDriver_offsetX + vDriver_l + 5;
vBattery_offsetY = 0;
vBattery_offsetZ = 2;

vEdgeCylinder_d = 12;
vEdgeCylinder_h = vWallStrength;
vEdgeCylinder_offsetX1 = -vEdgeCylinder_d/2;
vEdgeCylinder_offsetX2 = vBattery_offsetX + vBattery_l + vEdgeCylinder_d/2;
vEdgeCylinder_offsetY1 = vEdgeCylinder_d/2 - vWallStrength - 1 ;
vEdgeCylinder_offsetY2 = vController_w - vEdgeCylinder_offsetY1;
vEdgeCylinder_offsetZ = 0;

vSealCylinder_d = 12 - (2*vWallStrength) - (2*vTolerance);
vSealCylinder_h = vWallStrength;
vSealCylinder_offsetX1 = vEdgeCylinder_offsetX1;
vSealCylinder_offsetX2 = vEdgeCylinder_offsetX2;
vSealCylinder_offsetY1 = vEdgeCylinder_offsetY1;
vSealCylinder_offsetY2 = vEdgeCylinder_offsetY2;
vSealCylinder_offsetZ = vWallStrength;

vDisplayCutout_l = 68;
vDisplayCutout_w = 16;
vDisplayCutout_h = vWallStrength;
vDisplayCutout_offsetX = 7;
vDisplayCutout_offsetY = 23;
vDisplayCutout_offsetZ = 0; 

vDisplayFrameCutout_l = 74;
vDisplayFrameCutout_w = 26;
vDisplayFrameCutout_h = vWallStrength;
vDisplayFrameCutout_offsetX = 4;
vDisplayFrameCutout_offsetY = 18;
vDisplayFrameCutout_offsetZ = vWallStrength;

vBrightnessPotCutout_l = 12;
vBrightnessPotCutout_w = 6;
vBrightnessPotCutout_h = vWallStrength;
vBrightnessPotCutout_offsetX = 3;
vBrightnessPotCutout_offsetY = 51;
vBrightnessPotCutout_offsetZ = vWallStrength;

vScrewHole_d = 4.5;
vScrewHole_h = 2*vWallStrength;
vScrewHole_offsetX1 = vEdgeCylinder_offsetX1;
vScrewHole_offsetX2 = vEdgeCylinder_offsetX2;
vScrewHole_offsetY1 = vEdgeCylinder_offsetY1;
vScrewHole_offsetY2 = vEdgeCylinder_offsetY2;
vScrewHole_offsetZ = 0;

vButtonHole_d = 4.4;
vButtonHole_h = 2*vWallStrength;

vButtonHole_offsetX1 = 4.5;
vButtonHole_offsetY1 = 6;

vButtonHole_offsetX2 = 12;
vButtonHole_offsetY2 = 6;

vButtonHole_offsetX3 = 21.5;
vButtonHole_offsetY3 = 3.5;

vButtonHole_offsetX4 = 21.5;
vButtonHole_offsetY4 = 10;

vButtonHole_offsetX5 = 31;
vButtonHole_offsetY5 = 6;

vButtonHole_offsetX6 = 38.5;
vButtonHole_offsetY6 = 6;

vButtonHole_offsetZ = 0;

mirror([1,0,0])
difference(){
    union(){
        // outer shape
        hull(){
            translate([vEdgeCylinder_offsetX1, vEdgeCylinder_offsetY1, vEdgeCylinder_offsetZ])
                cylinder(d=vEdgeCylinder_d, h=vEdgeCylinder_h);
            translate([vEdgeCylinder_offsetX2, vEdgeCylinder_offsetY1, vEdgeCylinder_offsetZ])
                cylinder(d=vEdgeCylinder_d, h=vEdgeCylinder_h);
            translate([vEdgeCylinder_offsetX1, vEdgeCylinder_offsetY2, vEdgeCylinder_offsetZ])
                cylinder(d=vEdgeCylinder_d, h=vEdgeCylinder_h);
            translate([vEdgeCylinder_offsetX2, vEdgeCylinder_offsetY2, vEdgeCylinder_offsetZ])
                cylinder(d=vEdgeCylinder_d, h=vEdgeCylinder_h);
        }


        // seal
        hull(){
            translate([vSealCylinder_offsetX1, vSealCylinder_offsetY1, vSealCylinder_offsetZ])
                cylinder(d=vSealCylinder_d, h=vSealCylinder_h);
            translate([vSealCylinder_offsetX2, vSealCylinder_offsetY1, vSealCylinder_offsetZ])
                cylinder(d=vSealCylinder_d, h=vSealCylinder_h);
            translate([vSealCylinder_offsetX1, vSealCylinder_offsetY2, vSealCylinder_offsetZ])
                cylinder(d=vSealCylinder_d, h=vSealCylinder_h);
            translate([vSealCylinder_offsetX2, vSealCylinder_offsetY2, vSealCylinder_offsetZ])
                cylinder(d=vSealCylinder_d, h=vSealCylinder_h);
        }
    }

    
    
    // display cutout
    translate([vDisplayCutout_offsetX, vDisplayCutout_offsetY, vDisplayCutout_offsetZ])
        cube([vDisplayCutout_l, vDisplayCutout_w, vDisplayCutout_h]);
    
    // display frame cutout
    translate([vDisplayFrameCutout_offsetX, vDisplayFrameCutout_offsetY, vDisplayFrameCutout_offsetZ])
        cube([vDisplayFrameCutout_l, vDisplayFrameCutout_w, vDisplayFrameCutout_h]);
    
    // cutout for brightness potentiometer
    translate([vBrightnessPotCutout_offsetX, vBrightnessPotCutout_offsetY, vBrightnessPotCutout_offsetZ])
        cube([vBrightnessPotCutout_l, vBrightnessPotCutout_w, vBrightnessPotCutout_h]);
    
    // screw holes
    translate([vScrewHole_offsetX1, vScrewHole_offsetY1, vScrewHole_offsetZ])
        cylinder(d=vScrewHole_d, h=vScrewHole_h);
    translate([vScrewHole_offsetX2, vScrewHole_offsetY1, vScrewHole_offsetZ])
        cylinder(d=vScrewHole_d, h=vScrewHole_h);
    translate([vScrewHole_offsetX1, vScrewHole_offsetY2, vScrewHole_offsetZ])
        cylinder(d=vScrewHole_d, h=vScrewHole_h);
    translate([vScrewHole_offsetX2, vScrewHole_offsetY2, vScrewHole_offsetZ])
        cylinder(d=vScrewHole_d, h=vScrewHole_h);
    
    // button holes
    translate([vButtonHole_offsetX1, vButtonHole_offsetY1, vButtonHole_offsetZ])
        cylinder(d=vButtonHole_d, h=vButtonHole_h);
    translate([vButtonHole_offsetX2, vButtonHole_offsetY2, vButtonHole_offsetZ])
        cylinder(d=vButtonHole_d, h=vButtonHole_h);
    translate([vButtonHole_offsetX3, vButtonHole_offsetY3, vButtonHole_offsetZ])
        cylinder(d=vButtonHole_d, h=vButtonHole_h);
    translate([vButtonHole_offsetX4, vButtonHole_offsetY4, vButtonHole_offsetZ])
        cylinder(d=vButtonHole_d, h=vButtonHole_h);
    translate([vButtonHole_offsetX5, vButtonHole_offsetY5, vButtonHole_offsetZ])
        cylinder(d=vButtonHole_d, h=vButtonHole_h);
    translate([vButtonHole_offsetX6, vButtonHole_offsetY6, vButtonHole_offsetZ])
        cylinder(d=vButtonHole_d, h=vButtonHole_h);


}



