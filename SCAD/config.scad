
/*
EK 2021-01-13 this is currently work in progress, so use at your own risk!

CAUTION:
Don't play around with variables unless you really know what you are doing!


Some words about the used gears: 
# for our gears we take module 1 as the base module
# our gear ring will use exactly module 1 and its number of teeth has to be a multiple of the number of shutter blades - otherwise the shutter blades will not open/close synchronously.  
# the shutter blade gear will get 20 teeth and its module will be tweaked to get the optimal tolerance - typically its module should be around 0.985
# the power gear will also get 20 teeth and its module will be tweaked to get the optimal tolerance - typically its module should be around 0.985

*/


/*
##################################################
## some very general variables and includes
##################################################
*/

use <getriebe.scad>; // unfortunately the english version of this library is behind the original german one, so we stick to the german version

// we set this variable to 120 so we get quite nice circles
$fn = 120; // default is 120

// variable to control the tolerance of some measurements
vTolerance = 0.2; // default is 0.2

// general variables for the shutter layout
vNoOfBlades = 5; // default is 5
vAngleIncrement = 360/vNoOfBlades; // no need to ever change this!
vShutterOpening = 40; // initial version is 40, other measures are derived from this


/*
##################################################
## variables specifically for the shutter blades
##################################################
*/

// variables to control the leaves' shape
vBladeThickness = 0.3; // default is 0.3
vBladeOverlap = 2; // default is 2
vBladeAxis_d = 4; // default is 4
vBladeAxisEye = 10; // default is 10
vBladeAxisTube_d = vBladeAxis_d+2; // default is vBladeAxis_d+2
vBladeAxisCircle = vShutterOpening+10; // default is vShutterOpening+10
vBladeAxisHole_d = vBladeAxis_d + (2.5*vTolerance); // default is vBladeAxis_d + (2*vTolerance)
vBladeAxisHole_h = 10; // default is 10

vBladeBase_d = vBladeAxisCircle; // DO NOT CHANGE
vBladeBasePlusOverlap_d = vBladeAxisCircle+vBladeOverlap; // DO NOT CHANGE
vBladeBaseMinusOverlap_d = vBladeAxisCircle-vBladeOverlap; // DO NOT CHANGE
vBladeOuter_d = vBladeAxisCircle + vBladeAxisEye; // DO NOT CHANGE

vBladeOffset = vBladeAxisCircle/2; // DO NOT CHANGE

vBladeGearModule = 0.965; // default is 0.985, german meaning is Modul
vBladeGearNoOfTeeth = 20; // default is 20, german meaning is Zahnzahl
vBladeGear_w = 3 + vBladeThickness; // default is 3 + vBladeThickness, german meaning is Zahnbreite
vBladeGearHole_d = vBladeAxisHole_d; // default is vBladeAxisHole_d, german meaning is Zahnradbohrung
vBladeGearAngle = 20; // default is 20, german meaning is Eingriffswinkel
vBladeGearHelicalAngle = 0; // is 0, german meaning is Schrägungswinkel
vBladeGearOptimization = false; // default is false

vBladeGear_offsetX = vBladeOffset; // DO NOT CHANGE
vBladeGear_offsetY = 0; // DO NOT CHANGE
vBladeGear_offsetZ = 0; // DO NOT CHANGE

vBladeGearBase_d = 27; // default is 27, this should be about 2mm larger than the gear's diameter
vBladeGearBase_h = vBladeThickness; // DO NOT CHANGE

vBladeGearCutoff_l = vBladeGearBase_d; // DO NOT CHANGE
vBladeGearCutoff_w = vBladeGearBase_d; // DO NOT CHANGE
vBladeGearCutoff_h = vBladeGear_w; // DO NOT CHANGE
vBladeGearCutoff_offsetX = -vBladeGearCutoff_l/2; // DO NOT CHANGE
vBladeGearCutoff_offsetY = 0; // DO NOT CHANGE
vBladeGearCutoff_offsetZ = 0; // DO NOT CHANGE

/*
##################################################
## variables specifically for the gear ring
##################################################
*/

vGearRingOuter_d = 89.5;
vGearRing_w = 2.6;

vGearRingInnerGearModule = 1.008; // default is 1.008 (due to printing tolerances)
vGearRingInnerGearNoOfTeeth = 70; // default is 70, CAUTION: this has to be a multiple of the number of blades!

vGearRingInnerGearRim = 8.29; // default is 8.29, the gears library calculates the outer diameter based on this  
vGearRingInnerGearAngle = 20; // default is 20
vGearRingInnerGearHelicalAngle = 0; // default is 0

vGearRingOuterGearModule = 0.98; // default is 0.98
vGearRingOuterGearNoOfTeeth = 87; // default is 87. we want to get an outer diameter slightly smaller than vGearRingOuter_d
vGearRingOuterGearHole_d = 76; // default is 76
vGearRingOuterGearAngle = 20; // default is 20
vGearRingOuterGearHelicalAngle = 0; // default is 0
vGearRingOuterGearOptimization = false; // default is false

vGearRingCutout_l = 6; // default is 6
vGearRingCutout_w = 34; // default is 35
vGearRingCutout_h = vGearRing_w; // DO NOT CHANGE
vGearRingCutout_offsetX = -vGearRingOuter_d/2; // DO NOT CHANGE
vGearRingCutout_offsetY = -vGearRingCutout_w/2; // DO NOT CHANGE
vGearRingCutout_offsetZ = 0; // DO NOT CHANGE

/*
##################################################
## variables specifically for the power gear
##################################################
*/

/*
##################################################
## variables specifically for the shutter body
##################################################
*/


