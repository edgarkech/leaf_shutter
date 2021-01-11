// loading the base configuration
include <config.scad>;

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
vShutterBodyOuter_offsetX = 0;
vShutterBodyOuter_offsetY = 0;
vShutterBodyOuter_offsetZ = 0;

vShutterBodyInner_d = vShutterBodyOuter_d - (2*vWallStrength) - (2*vTolerance);
vShutterBodyInner_h = vWallStrength;
vShutterBodyInner_offsetX = 0;
vShutterBodyInner_offsetY = 0;
vShutterBodyInner_offsetZ = vWallStrength;

vShutterOpening_d = 40;
vShutterOpening_h = vShutterBodyOuter_h + vShutterBodyInner_h;

vBladeAxisHole_d = 4+vTolerance;
vBladeAxisHole_h = 5;
vBladeAxisHole_offsetR = 25;


vBladeStopPin_d = 4;
vBladeStopPin_h = 2.6;
vBladeStopPin_offsetX = vBladeAxisHole_offsetR - (vBladeStopPin_d/2) - 0.5;
vBladeStopPin_offsetY = (vBladeAxisHole_d/2) + 1 + (vBladeStopPin_d/2);
vBladeStopPin_offsetZ = vShutterOpening_h;
/*
vBladeStop_l = 3;
vBladeStop_w = 5;
vBladeStop_h = 2;
vBladeStop_offsetX = vBladeAxisHole_offsetR - vBladeStop_l;
vBladeStop_offsetY = (vBladeAxisHole_d/2) + 1;
vBladeStop_offsetZ = vShutterOpening_h;
*/
difference(){
union(){
        translate([vShutterBodyOuter_offsetX, vShutterBodyOuter_offsetY, vShutterBodyOuter_offsetZ])
        cylinder(d=vShutterBodyOuter_d, h=vShutterBodyOuter_h);
        
        translate([vShutterBodyInner_offsetX, vShutterBodyInner_offsetY, vShutterBodyInner_offsetZ])
            cylinder(d=vShutterBodyInner_d, h=vShutterBodyInner_offsetZ);
        
        /*
        for (a =[0:1:vNoOfBlades-1]){
            rotate([0, 0, a*vAngleIncrement])
                translate([vBladeStop_offsetX, vBladeStop_offsetY, vBladeStop_offsetZ])
                    cube([vBladeStop_l, vBladeStop_w, vBladeStop_h]);
        };
        */
        for (a =[0:1:vNoOfBlades-1]){
            rotate([0, 0, a*vAngleIncrement])
                translate([vBladeStopPin_offsetX, vBladeStopPin_offsetY, vBladeStopPin_offsetZ])
                    cylinder(d=vBladeStopPin_d, h=vBladeStopPin_h);
        };
    
    
    }
    
    
        cylinder(d=vShutterOpening_d, h = vShutterOpening_h);
        
        for (a =[0:1:vNoOfBlades-1]){
            rotate([0, 0, a*vAngleIncrement])
                translate([vBladeAxisHole_offsetR, 0, 0])
                    cylinder(d=vBladeAxisHole_d, h=vBladeAxisHole_h );
        };

}