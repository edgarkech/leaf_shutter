
include <config.scad>;




difference(){
    // inner gear
    hohlrad (modul=vGearRingInnerGearModule, zahnzahl=vGearRingInnerGearNoOfTeeth, breite=vGearRing_w, randbreite=vGearRingInnerGearRim, eingriffswinkel=vGearRingInnerGearAngle, schraegungswinkel=vGearRingInnerGearHelicalAngle);
    
    // cutout for the outer gear
    translate([vGearRingCutout_offsetX, vGearRingCutout_offsetY,  vGearRingCutout_offsetZ])
        cube([vGearRingCutout_l, vGearRingCutout_w, vGearRingCutout_h]);
}

// outer gear
stirnrad(modul=vGearRingOuterGearModule, zahnzahl=vGearRingOuterGearNoOfTeeth, breite=vGearRing_w, bohrung=vGearRingOuterGearHole_d, eingriffswinkel=vGearRingOuterGearAngle, schraegungswinkel=vGearRingOuterGearHelicalAngle, optimiert=vGearRingOuterGearOptimization);



/*
translate([vLever_offsetX, vLever_offsetY, vLever_offsetZ])
    cube([vLever_l, vLever_w, vLever_h]);
*/
