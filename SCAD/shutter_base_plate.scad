// loading the base configuration
include <config.scad>;

// some modules such as hex, countersunk screws, roof, wedge are available in a module file
use <modules.scad>;



union(){
    difference(){
        cylinder(d=94, h=8);
        
        translate([0,0,2])
            cylinder(d=90, h=6);
        
        cylinder(d=42, h = 2);
        
        translate([25,0,0.6])
        rotate([0,0,-128])
            translate([25,0,0])
                cylinder(d=6, h=2);
        translate([25,0,0])
        rotate([0,0,-130])
            translate([25,0,0.6])
                cylinder(d=6, h=2);
        
        translate([40, -15, 4])
            cube([20, 30, 4]);
        }
    
    for (a =[0:1:vNoOfBlades-1]){
            rotate([0, 0, a*vBladeAngle])
                translate([25, 0, 0])
                    cylinder(d=3.7, h=8 );
        };

}