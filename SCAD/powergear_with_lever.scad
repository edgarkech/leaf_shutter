
use <getriebe.scad>;

$fn = 120;

vModul = 0.985; // empirisch ermittelt, damit wir "genau das richtige Spiel" für einen leichten, aber dennoch hinreichend präzisen Lauf bekommen
vZahnzahl = 20;
vBreite = 3;
vBohrung = 4.1; 
vEingriffswinkel = 20;
vSchraegungswinkel = 0;

vLever_l = 15;
vLever_w = 4;
vLever_h = vBreite;
vLever_offsetX = vBohrung/2 + 0.2;
vLever_offsetY = -vLever_w/2;
vLever_offsetZ = 0;


stirnrad (modul=vModul, zahnzahl=vZahnzahl, breite=vBreite, bohrung=vBohrung, eingriffswinkel=vEingriffswinkel, schraegungswinkel = vSchraegungswinkel);

translate([vLever_offsetX, vLever_offsetY, vLever_offsetZ])
    cube([vLever_l, vLever_w, vLever_h]);