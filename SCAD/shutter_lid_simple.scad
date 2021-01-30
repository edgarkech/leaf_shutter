// loading the base configuration
include <config.scad>;



difference(){
union(){
        translate([vShutterLidOuter_offsetX, vShutterLidOuter_offsetY, vShutterLidOuter_offsetZ])
        cylinder(d=vShutterLidOuter_d, h=vShutterLidOuter_h);
        
        translate([vShutterLidInner_offsetX, vShutterLidInner_offsetY, vShutterLidInner_offsetZ])
            cylinder(d=vShutterLidInner_d, h=vShutterLidInner_offsetZ);
        
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
    
    
        cylinder(d=vShutterLidOpening_d, h = vShutterLidOpening_h);
        
        for (a =[0:1:vNoOfBlades-1]){
            rotate([0, 0, a*vAngleIncrement])
                translate([vShutterLidBladeAxisHole_offsetR, 0, 0])
                    cylinder(d=vShutterLidBladeAxisHole_d, h=vShutterLidBladeAxisHole_h );
        };

}