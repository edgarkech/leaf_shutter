include <config.scad>;

// all variables are defined in config.scad!

intersection(){
    difference(){
        union(){
            // base half circle
            difference(){
                translate([vBladeOffset, 0, 0])
                    //cylinder(d=vBladeBase_d, h=vBladeThickness);
                    cylinder(d=vBladeBasePlusOverlap_d, h=vBladeThickness);
                translate([vBladeAxisEye,0,0])
                    cube([vBladeBase_d, vBladeBase_d/2, vBladeThickness]);
                }
            // adding a bit to the half circle
            translate([vBladeAxisEye,0,0])
                cube([vBladeBase_d/2-vBladeAxisEye, vBladeAxisEye/2, vBladeThickness]);
            // adding the final axis eye
            translate([vBladeOffset, 0, 0])
                cylinder(d=vBladeAxisEye, h=vBladeThickness);
            }
        // axis hole
        translate([vBladeOffset, 0, 0])
            cylinder(d=vBladeAxisHole_d, h=vBladeThickness);
        
        // cutoff from next blade
        rotate([0,0, vAngleIncrement])
            translate([vBladeOffset, 0, 0])
                //cylinder(d=vBladeBase_d, h=vBladeThickness);
                cylinder(d=vBladeBaseMinusOverlap_d, h=vBladeThickness);
        
    }
    cylinder(d=vBladeOuter_d, h=vBladeThickness);
}




translate([vBladeGear_offsetX, vBladeGear_offsetY, vBladeGear_offsetZ])
    rotate([0, 0, 0])
        difference(){
            
            union(){
                stirnrad (modul=vBladeGearModule, zahnzahl=vBladeGearNoOfTeeth, breite=vBladeGear_w, bohrung=vBladeGearHole_d, eingriffswinkel=vBladeGearAngle, schraegungswinkel=vBladeGearHelicalAngle, optimiert=vBladeGearOptimization);
                // we extend our blade contour and add a cylinder below the gear. this will prevent the gear ring to slip down and block the blades movement.
                cylinder(d=vBladeGearBase_d, h=vBladeGearBase_h);
                }
            // we can only use a quarter of the gear, the rest will be useless/hindering
            // so we cut it off    
            translate([vBladeGearCutoff_offsetX, vBladeGearCutoff_offsetY, vBladeGearCutoff_offsetZ])
                cube([vBladeGearCutoff_l, vBladeGearCutoff_w, vBladeGearCutoff_h]);
            translate([-vBladeGearCutoff_l, -vBladeGearCutoff_w/2, vBladeGearCutoff_offsetZ])
                cube([vBladeGearCutoff_l, vBladeGearCutoff_w, vBladeGearCutoff_h]);
            // since our gearbase is solid, we have to drill through it
            cylinder(d=vBladeAxisHole_d, h=vBladeGear_w);
            



        }
// adding a little tube for guiding the blade better on its axis
difference(){
    translate([vBladeAxisCircle/2, 0, 0])
        cylinder(d=vBladeAxisTube_d, h=vBladeGear_w);
    translate([vBladeAxisCircle/2, 0, 0])
        cylinder(d=vBladeAxisHole_d, h=vBladeGear_w);
}
