
use <getriebe.scad>;
use <modules.scad>;

$fn = 120;


vTolerance = 0.2;
vNoOfBlades = 5;
vAngleIncrement = 360/vNoOfBlades;
vShutterOpening = 40;


vBladeThickness = 0.3;
vBladeOverlap = 2;
vBladeAxis_d = 4;
vBladeAxisEye = 10;
vBladeAxisTube_d = vBladeAxis_d+2;
vBladeAxisCircle = vShutterOpening+10;
vBladeAxisHole_d = vBladeAxis_d + vTolerance;
vBladeAxisHole_h = 10;

vBladeBase_d = vBladeAxisCircle;
vBladeBase_d1 = vBladeAxisCircle+vBladeOverlap;
vBladeBase_d2 = vBladeAxisCircle-vBladeOverlap;
vBladeOuter_d = vBladeAxisCircle + vBladeAxisEye;

vBladeOffset = vBladeAxisCircle/2;

vModul = 1;
vZahnZahl = 20;
vZahnBreite = 3 + vBladeThickness;
vBohrung = vBladeAxisHole_d;
vEingriffswinkel = 20;
vSchraegungswinkel = 0;
vOptimiert = false;

vGear_offsetX = vBladeOffset;
vGear_offsetY = 0;
vGear_offsetZ = 0;

vGearBase_d = 27;
vGearBase_h = vBladeThickness;

vGearCutoff_l = vGearBase_d;
vGearCutoff_w = vGearBase_d;
vGearCutoff_h = vZahnBreite;
vGearCutoff_offsetX = -vGearCutoff_l/2;
vGearCutoff_offsetY = 0;
vGearCutoff_offsetZ = 0;


intersection(){
    difference(){
        union(){
            // base half circle
            difference(){
                translate([vBladeOffset, 0, 0])
                    //cylinder(d=vBladeBase_d, h=vBladeThickness);
                    cylinder(d=vBladeBase_d1, h=vBladeThickness);
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
                cylinder(d=vBladeBase_d2, h=vBladeThickness);
        
    }
    cylinder(d=vBladeOuter_d, h=vBladeThickness);
}




translate([vGear_offsetX, vGear_offsetY, vGear_offsetZ])
    rotate([0, 0, 0])
        difference(){
            
            union(){
                stirnrad (modul=vModul, zahnzahl=vZahnZahl, breite=vZahnBreite, bohrung=vBohrung, eingriffswinkel=vEingriffswinkel, schraegungswinkel=vSchraegungswinkel, optimiert=vOptimiert);
                cylinder(d=vGearBase_d, h=vGearBase_h);
                }
            // we can only use a quarter of the gear, the rest will be useless/hindering
            // so we cut it off    
            translate([vGearCutoff_offsetX, vGearCutoff_offsetY, vGearCutoff_offsetZ])
                cube([vGearCutoff_l, vGearCutoff_w, vGearCutoff_h]);
            translate([-vGearCutoff_l, -vGearCutoff_w/2, vGearCutoff_offsetZ])
                cube([vGearCutoff_l, vGearCutoff_w, vGearCutoff_h]);
            // since our gearbase is solid, we have to drill through it
            cylinder(d=vBladeAxisHole_d, h=vZahnBreite);
            



        }
// adding a little tube for guiding the blade better on its axis
difference(){
    translate([vBladeAxisCircle/2, 0, 0])
        cylinder(d=vBladeAxisTube_d, h=vZahnBreite);
    translate([vBladeAxisCircle/2, 0, 0])
        cylinder(d=vBladeAxisHole_d, h=vZahnBreite);
}
