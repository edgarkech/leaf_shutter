
use <getriebe.scad>;

$fn = 120;



vLever_l = 25;
vLever_w = 6;
vLever_h = 2.6;
vLever_offsetX = 32;
vLever_offsetY = -vLever_w/2;
vLever_offsetZ = 0;



hohlrad (modul=0.81, zahnzahl=75, breite=2.6, randbreite=4, eingriffswinkel=20, schraegungswinkel=0);

translate([vLever_offsetX, vLever_offsetY, vLever_offsetZ])
    cube([vLever_l, vLever_w, vLever_h]);

