
use <getriebe.scad>;

$fn = 120;

vAussendurchmesser = 89.5;

vModul_innen = 1.008; // empirisch ermittelt
vZahnzahl_innen = 70;
vBreite = 2.6;
vRandbreite = 8.29; // empirisch ermittelt anhand des errechneten Außendurchmessers
vEingriffswinkel = 20;
vSchraegungswinkel = 0;

vModul_aussen = 0.985; // muss ggf. noch angepasst werden
vZahnzahl_aussen = 87; // muss angepasst werden, damit wir einen Aussendurchmesser von 89 bekommen
vBohrung = 76;

vAusschnittZahnkranz_l = 6;
vAusschnittZahnkranz_w = 34;
vAusschnittZahnkranz_h = vBreite;

vAusschnittZahnkranz_offsetX = -vAussendurchmesser/2;
vAusschnittZahnkranz_offsetY = -vAusschnittZahnkranz_w/2;
vAusschnittZahnkranz_offsetZ = 0;

/*
vLever_l = 20;
vLever_w = 6;
vLever_h = 2.6;
vLever_offsetX = 40;
vLever_offsetY = -vLever_w/2;
vLever_offsetZ = 0;
*/

difference(){
    hohlrad (modul=vModul_innen, zahnzahl=vZahnzahl_innen, breite=vBreite, randbreite=vRandbreite, eingriffswinkel=vEingriffswinkel, schraegungswinkel=vSchraegungswinkel);
    translate([vAusschnittZahnkranz_offsetX, vAusschnittZahnkranz_offsetY,  vAusschnittZahnkranz_offsetZ])
        cube([vAusschnittZahnkranz_l, vAusschnittZahnkranz_w, vAusschnittZahnkranz_h]);
}

stirnrad(modul=vModul_aussen, zahnzahl=vZahnzahl_aussen, breite=vBreite, bohrung=vBohrung, eingriffswinkel=vEingriffswinkel, schraegungswinkel=vSchraegungswinkel, optimiert=true);



/*
translate([vLever_offsetX, vLever_offsetY, vLever_offsetZ])
    cube([vLever_l, vLever_w, vLever_h]);
*/
