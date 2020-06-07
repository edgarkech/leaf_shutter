
use <getriebe.scad>;
use <modules.scad>;

$fn = 120;


vTolerance = 0.2;
vNoOfBlades = 5;
vAngleIncrement = 360/vNoOfBlades;

vBladeThickness = 2;

vBladeAxis_d = 4;
vBladeAxisEye = 10;
vBladeAxisEye_d1 = vBladeAxisEye-(2*vBladeThickness);
vBladeAxisEye_d2 = vBladeAxisEye;
vBladeAxisCircle = 50;
vBladeAxisHole_d = vBladeAxis_d + 2*vTolerance;
vBladeAxisHole_h = 10;

vBladeBase_d = vBladeAxisCircle;
vBladeBase_d1 = vBladeAxisCircle+vBladeThickness;
vBladeBase_d2 = vBladeAxisCircle-vBladeThickness;
vBladeOuter_d = vBladeAxisCircle + vBladeAxisEye;

vBladePin_d = 4;
vBladePin_h = 2*vBladeThickness;

vBladeOffset = vBladeAxisCircle/2;

vGear_offsetX = vBladeOffset;
vGear_offsetY = 0;
vGear_offsetZ = vBladeThickness;


intersection(){
    difference(){
        union(){
            // base half circle
            difference(){
                translate([vBladeOffset, 0, 0])
                    //cylinder(d=vBladeBase_d, h=vBladeThickness);
                    cylinder(d1=vBladeBase_d1, d2=vBladeBase_d2, h=vBladeThickness);
                translate([vBladeAxisEye,0,0])
                    cube([vBladeBase_d, vBladeBase_d/2, vBladeThickness]);
                }
            // adding a bit to the half circle
            translate([vBladeAxisEye,0,0])
                cube([vBladeBase_d/2-vBladeAxisEye, vBladeAxisEye/2, vBladeThickness]);
            // adding the final axis eye
            translate([vBladeOffset, 0, 0])
                //cylinder(d=vBladeAxisEye, h=vBladeThickness);
                cylinder(d1=vBladeAxisEye_d1, d2=vBladeAxisEye_d2, h=vBladeThickness);
            }
        // axis hole
        translate([vBladeOffset, 0, 0])
            cylinder(d=vBladeAxisHole_d, h=vBladeAxisHole_h);
        
        // cutoff from next blade
        rotate([0,0, vAngleIncrement])
            translate([vBladeOffset, 0, 0])
                //cylinder(d=vBladeBase_d, h=vBladeThickness);
                cylinder(d1=vBladeBase_d1, d2=vBladeBase_d2, h=vBladeThickness);
            
        // cutoff axis eye
            translate([vBladeAxisEye,vBladeAxisEye/2,0])
            wedge(vBladeBase_d/2-vBladeAxisEye, -vBladeThickness, vBladeThickness);        
            //cube([vBladeBase_d/2-vBladeAxisEye, vBladeAxisEye/2, vBladeThickness]);
        
    }
    cylinder(d=vBladeOuter_d, h=vBladeThickness);
}



translate([vGear_offsetX, vGear_offsetY, vGear_offsetZ])
    stirnrad (modul=0.78, zahnzahl=12, breite=3, bohrung=vBladeAxisHole_d, eingriffswinkel=20, schraegungswinkel=0, optimiert=false);

//hohlrad (modul=0.8, zahnzahl=75, breite=4, randbreite=2, eingriffswinkel=20, schraegungswinkel=0);

/*

// blade pin
rotate([0,0,-12])
    translate([vBladeOffset, 0, 0])
        cylinder(d=vBladePin_d, h=vBladePin_h);

*/