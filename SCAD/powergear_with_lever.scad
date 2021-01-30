include <config.scad>;

difference(){
    union(){
        // the gear itself
        stirnrad (modul=vPowerGearModule, zahnzahl=vPowerGearNoOfTeeth, breite=vPowerGearThickness, bohrung=vPowerGearHole_d, eingriffswinkel=vPowerGearAngle, schraegungswinkel = vPowerGearHelicalAngle, optimiert=vPowerGearOptimization);
        
        // we add a lever/angle indicator to the gear
        translate([vPowerGearLever_offsetX, vPowerGearLever_offsetY, vPowerGearLever_offsetZ])
            cube([vPowerGearLever_l, vPowerGearLever_w, vPowerGearLever_h]);

        // we add a tube to fit onto the stepper motor axis/gear
        translate([vPowerGearTube_offsetX, vPowerGearTube_offsetY, vPowerGearTube_offsetZ])
            cylinder(d=vPowerGearTube_d, h=vPowerGearTube_h);
}
// because we added that tube, we have to drill a hole into it
    translate([vPowerGearTube_offsetX, vPowerGearTube_offsetY, vPowerGearTube_offsetZ])
        cylinder(d=vPowerGearHole_d, h=vPowerGearTube_h);
}