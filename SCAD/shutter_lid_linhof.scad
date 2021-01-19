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
vShutterBodyOuter_h = vWallStrength;
// the offset variables are depending on following variables, so we set them later  

vShutterBodyInner_d = vShutterBodyOuter_d - (2*vWallStrength) - (2*vTolerance);
vShutterBodyInner_h = vWallStrength;
// the offset variables are depending on following variables, so we set them later  

vShutterOpening_d = 40;
vShutterOpening_h = vShutterBodyOuter_h + vShutterBodyInner_h;

vBladeAxisHole_d = 4+vTolerance;
vBladeAxisHole_h = 10;

vBladeStopPin_d = 4;
vBladeStopPin_h = 2.6;




/*
adapter specific variables

// Linhof/Wista style
// caution: we are working with a slightly simplified geometry

*/
vLightSealOuter_d = 83;
vLightSealInner_d = vLightSealOuter_d-8;
vLightSeal_h = 3;
vLightSeal_offsetX = 0;
vLightSeal_offsetY = 0;
vLightSeal_offsetZ = 0;

vAdapterPlate_l = 99;
vAdapterPlate_w = 96;
vAdapterPlate_h = 2;
vAdapterPlate_offsetX = -48; // caution: lightseal and bore are off center!
vAdapterPlate_offsetY = -vAdapterPlate_w/2;
vAdapterPlate_offsetZ = vLightSeal_h;

vAdapterCone_d1 = vAdapterPlate_w - 8; // we need about 4mm space on the upper and lower side for the lensboard clamps
vAdapterCone_d2 = vShutterBodyOuter_d;
vAdapterCone_h = 6;
vAdapterCone_offsetX = 0;
vAdapterCone_offsetY = 0;
vAdapterCone_offsetZ = vLightSeal_h + vAdapterPlate_h;

vShutterBodyOuter_offsetX = 0;
vShutterBodyOuter_offsetY = 0;
vShutterBodyOuter_offsetZ = vLightSeal_h + vAdapterPlate_h + vAdapterCone_h;

vShutterBodyInner_offsetX = 0;
vShutterBodyInner_offsetY = 0;
vShutterBodyInner_offsetZ = vLightSeal_h + vAdapterPlate_h + vAdapterCone_h + vShutterBodyOuter_h;

vBladeAxisHole_offsetX = 25;
vBladeAxisHole_offsetY = 0;
vBladeAxisHole_offsetZ = vShutterBodyOuter_offsetZ - 2;

vBladeStopPin_offsetX = vBladeAxisHole_offsetX - (vBladeStopPin_d/2) - 0.3;
vBladeStopPin_offsetY = (vBladeAxisHole_d/2) + 1 + (vBladeStopPin_d/2);
vBladeStopPin_offsetZ = vLightSeal_h + vAdapterPlate_h + vAdapterCone_h + vShutterBodyOuter_h + vShutterBodyInner_h;

vShutterBore_d1 = vLightSealInner_d;
vShutterBore_d2 = vShutterOpening_d;
vShutterBore_h = vLightSeal_h + vAdapterPlate_h + vAdapterCone_h + vShutterBodyOuter_h + vShutterBodyInner_h;
vShutterBore_offsetX = 0;
vShutterBore_offsetY = 0;
vShutterBore_offsetZ = 0;

vLidScrewTube_d = 10;
vLidScrewHole_d = 4.5;
vLidScrewTube_h = vAdapterPlate_h + vAdapterCone_h + vShutterBodyOuter_h;
vLidScrewTube_offsetX = (vShutterBodyOuter_d + vLidScrewHole_d) / 2;
vLidScrewTube_offsetY = 0;
vLidScrewTube_offsetZ = vLightSeal_h;

vLidScrewNut_KW = 7.1;
vLidScrewNut_h = 3;




difference(){
union(){
        // light seal from the adapter plate
        translate([vLightSeal_offsetX, vLightSeal_offsetY, vLightSeal_offsetZ])
            cylinder(d=vLightSealOuter_d, h=vLightSeal_h);
    
        // adapter plate
        translate([vAdapterPlate_offsetX, vAdapterPlate_offsetY, vAdapterPlate_offsetZ])
            cube([vAdapterPlate_l, vAdapterPlate_w, vAdapterPlate_h]);
    
        // adapter cone
        translate([vAdapterCone_offsetX, vAdapterCone_offsetY, vAdapterCone_offsetZ])
            cylinder(d1=vAdapterCone_d1, d2=vAdapterCone_d2, h=vAdapterCone_h);
        
        // this is the "real" shutter lid 
        translate([vShutterBodyOuter_offsetX, vShutterBodyOuter_offsetY, vShutterBodyOuter_offsetZ])
            cylinder(d=vShutterBodyOuter_d, h=vShutterBodyOuter_h);
        
        // light seal for the lid
        translate([vShutterBodyInner_offsetX, vShutterBodyInner_offsetY, vShutterBodyInner_offsetZ])
            cylinder(d=vShutterBodyInner_d, h=vShutterBodyInner_h);
        
        // blade stop pins
        for (a =[0:1:vNoOfBlades-1]){
            rotate([0, 0, a*vAngleIncrement])
                translate([vBladeStopPin_offsetX, vBladeStopPin_offsetY, vBladeStopPin_offsetZ])
                    cylinder(d=vBladeStopPin_d, h=vBladeStopPin_h);
        };
        
        // tubes for the lid screws
        for (a =[0:1:3]){
            rotate([0, 0, (a*90)+45])
                translate([vLidScrewTube_offsetX, vLidScrewTube_offsetY, vLidScrewTube_offsetZ])
                    cylinder(d=vLidScrewTube_d, h=vLidScrewTube_h);
        };
    
    
    }
    
    
        cylinder(d1=vShutterBore_d1, d2=vShutterBore_d2, h=vShutterBore_h);
        
        // holes for the blade axis pins
        for (a =[0:1:vNoOfBlades-1]){
            rotate([0, 0, a*vAngleIncrement])
                translate([vBladeAxisHole_offsetX, vBladeAxisHole_offsetY, vBladeAxisHole_offsetZ])
                    cylinder(d=vBladeAxisHole_d, h=vBladeAxisHole_h );
        };
        
        // screw holes for the lid screws
        for (a =[0:1:3]){
            rotate([0, 0, (a*90)+45])
                translate([vLidScrewTube_offsetX, vLidScrewTube_offsetY, vLidScrewTube_offsetZ])
                    cylinder(d=vLidScrewHole_d, h=vLidScrewTube_h);
        };
        
        // hex cutouts for the lid screw nuts
        for (a =[0:1:3]){
            rotate([0, 0, (a*90)+45])
                translate([vLidScrewTube_offsetX, vLidScrewTube_offsetY, vLidScrewTube_offsetZ])
                    hex(vLidScrewNut_KW, h=vLidScrewNut_h);
        };
        
}