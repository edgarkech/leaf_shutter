// loading the base configuration
include <baseconfig.scad>;

// some modules such as hex, countersunk screws, roof, wedge are available in a module file
use <modules.scad>;


// focusing rod axis is set to -63mm to the lid center
// rail block total width is 100mm
// inner total width is 160mm



vFocusingBlock_l = 35; //OK


//vFocusingBlock_w = 30;
vFocusingBlock_w = (vBodyOuter_w - 2*vWall_strength - vLowerRail_w - 2*vDoveTail_w)/2; 
vFocusingBlock_h = 10;
vFocusingBlock_offsetX = 0;
vFocusingBlock_offsetY = -(vBodyOuter_w - 2*vWall_strength)/2; // we are shifting to -Y so we can use the same measurements as on the lid 
vFocusingBlock_offsetZ = 0;

vFrontWallExtension_l = 5;
vFrontWallExtension_w = vFocusingBlock_w - vWall_strength;
vFrontWallExtension_h = 5;
vFrontWallExtension_offsetX = vFocusingBlock_l;
vFrontWallExtension_offsetY = vFocusingBlock_offsetY + vFocusingBlock_w - vFrontWallExtension_w;
vFrontWallExtension_offsetZ = 0;

vFrontEdgeCutout_d = 10+vTolerance;
vFrontEdgeCutout_h = vFocusingBlock_h;
vFrontEdgeCutout_offsetX = vFocusingBlock_l;
vFrontEdgeCutout_offsetY = vFocusingBlock_offsetY;
vFrontEdgeCutout_offsetZ = 0;

vBackEdgeCutout_l = 10;
vBackEdgeCutout_w = 10;
vBackEdgeCutout_h = vFocusingBlock_h;
vBackEdgeCutout_offsetX = 0;
vBackEdgeCutout_offsetY = vFocusingBlock_offsetY+vFocusingBlock_w;
vBackEdgeCutout_offsetZ = 0;

vFocusingRodHole_d = 6+vTolerance;
vFocusingRodHole_h = vFocusingBlock_l+vFrontWallExtension_l;
vFocusingRodHole_offsetX = 0;
vFocusingRodHole_offsetY = -(vBodyOuter_w/2)+10+7;//-68;
//vFocusingRodHole_offsetZ = vFocusingBlock_h/2;
vFocusingRodHole_offsetZ = 6;

vFocusingKnobCutout_d = 26;
vFocusingKnobCutout_h = 20+vTolerance;
vFocusingKnob_offsetX = 10-vTolerance;
vFocusingKnob_offsetY = vFocusingRodHole_offsetY;
vFocusingKnob_offsetZ = vFocusingRodHole_offsetZ;

vLeftUpperEdgeCutout_l = vFocusingBlock_l;
vLeftUpperEdgeCutout_w = vFocusingBlock_h/2;
vLeftUpperEdgeCutout_h = vFocusingBlock_h/2;
vLeftUpperEdgeCutout_offsetX = 0;
vLeftUpperEdgeCutout_offsetY = vFocusingBlock_offsetY+vFocusingBlock_w;
vLeftUpperEdgeCutout_offsetZ = vFocusingBlock_h;

vRightUpperEdgeCutout_l = vFocusingBlock_l;
vRightUpperEdgeCutout_w = vFocusingBlock_h-vFrontWallExtension_h;
vRightUpperEdgeCutout_h = vRightUpperEdgeCutout_w;
vRightUpperEdgeCutout_offsetX = 0;
vRightUpperEdgeCutout_offsetY = vFocusingBlock_offsetY;
vRightUpperEdgeCutout_offsetZ = vFocusingBlock_h;

vScrewHole_d = 2;
vScrewHole_h = 10;
vScrewHole1_offsetX = 5;
vScrewHole2_offsetX = vFocusingBlock_l;
vScrewHole3_offsetX = vFocusingBlock_l;
vScrewHole1_offsetY = vFocusingRodHole_offsetY-8;
vScrewHole2_offsetY = vFocusingRodHole_offsetY-8;
vScrewHole3_offsetY = vFocusingRodHole_offsetY+8;
vScrewHole1_offsetZ = 0;
vScrewHole2_offsetZ = 0;
vScrewHole3_offsetZ = 0;

//wedge(vUpperEdgeCutout_l, -vUpperEdgeCutout_w, -vUpperEdgeCutout_h);


 difference(){   
     union(){
         translate([vFocusingBlock_offsetX, vFocusingBlock_offsetY, vFocusingBlock_offsetZ])
            cube([vFocusingBlock_l, vFocusingBlock_w, vFocusingBlock_h]);
         translate([vFrontWallExtension_offsetX, vFrontWallExtension_offsetY, vFrontWallExtension_offsetZ])
            cube([vFrontWallExtension_l, vFrontWallExtension_w, vFrontWallExtension_h]);
         }
     // front edge cutout
     translate([vFrontEdgeCutout_offsetX, vFrontEdgeCutout_offsetY, vFrontEdgeCutout_offsetZ])
         cylinder(d=vFrontEdgeCutout_d, h= vFrontEdgeCutout_h);
     // hole for focusing_rod
     translate([vFocusingRodHole_offsetX, vFocusingRodHole_offsetY, vFocusingRodHole_offsetZ])
            rotate([0, 90, 0])
                cylinder(d=vFocusingRodHole_d, h=vFocusingRodHole_h);
     // cutout for the focusing knob
     translate([vFocusingKnob_offsetX, vFocusingKnob_offsetY, vFocusingKnob_offsetZ])
            rotate([0, 90, 0])
                cylinder(d=vFocusingKnobCutout_d, h=vFocusingKnobCutout_h);  
     // back edge cut
     translate([vBackEdgeCutout_offsetX, vBackEdgeCutout_offsetY, vBackEdgeCutout_offsetZ])
        rotate([0, -90, 180])
            wedge(vBackEdgeCutout_h, vBackEdgeCutout_w, vBackEdgeCutout_l);
         
     // upper edge cutoff
     translate([vLeftUpperEdgeCutout_offsetX, vLeftUpperEdgeCutout_offsetY, vLeftUpperEdgeCutout_offsetZ])
            wedge(vLeftUpperEdgeCutout_l, -vLeftUpperEdgeCutout_w, -vLeftUpperEdgeCutout_h);
     translate([vRightUpperEdgeCutout_offsetX, vRightUpperEdgeCutout_offsetY, vRightUpperEdgeCutout_offsetZ])
            wedge(vRightUpperEdgeCutout_l, vRightUpperEdgeCutout_w, -vRightUpperEdgeCutout_h);
     // screw holes
     translate([vScrewHole1_offsetX, vScrewHole1_offsetY, vScrewHole1_offsetZ])
        cylinder(d=vScrewHole_d, h=vScrewHole_h);
    /*translate([vScrewHole2_offsetX, vScrewHole2_offsetY, vScrewHole2_offsetZ])
        cylinder(d=vScrewHole_d, h=vScrewHole_h);*/
    translate([vScrewHole3_offsetX, vScrewHole3_offsetY, vScrewHole3_offsetZ])
        cylinder(d=vScrewHole_d, h=vScrewHole_h);
 }