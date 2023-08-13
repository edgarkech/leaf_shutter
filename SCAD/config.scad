
/*
EK 2021-01-13 this is currently work in progress, so use at your own risk!
EK 2021-01-30 added section for powergear and shutter body

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

use <modules.scad>; // some modules such as hex, countersunk screws, roof, wedge are available in a module file

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

vPowerGearModule = 0.98; // starting with a base Module of 1, we have to finetune this to get the best tolerance
vPowerGearNoOfTeeth = 20;
vPowerGearThickness = 3;
vPowerGearHole_d = 5.7; 
vPowerGearAngle = 20;
vPowerGearHelicalAngle = 0;
vPowerGearOptimization = false; // default is false

vPowerGearLever_l = 15;
vPowerGearLever_w = 4;
vPowerGearLever_h = vPowerGearThickness;
vPowerGearLever_offsetX = vPowerGearHole_d/2 + vTolerance;
vPowerGearLever_offsetY = -vPowerGearLever_w/2;
vPowerGearLever_offsetZ = 0;

vPowerGearTube_d = 10;
vPowerGearTube_h = vPowerGearThickness + 3;
vPowerGearTube_offsetX = 0;
vPowerGearTube_offsetY = 0;
vPowerGearTube_offsetZ = 0;

/*
##################################################
## variables specifically for the shutter body
##################################################
*/

vWallStrength = 2;

vShutterBodyOuter_d = 94;
vShutterBodyOuter_h = 8;
vShutterBodyOuter_offsetX = 0;
vShutterBodyOuter_offsetY = 0;
vShutterBodyOuter_offsetZ = 0;

vShutterBodyInner_d = vShutterBodyOuter_d - (2*vWallStrength);
vShutterBodyInner_h = vShutterBodyOuter_h - vWallStrength;
vShutterBodyInner_offsetX = 0;
vShutterBodyInner_offsetY = 0;
vShutterBodyInner_offsetZ = vWallStrength;

vShutterOpening_d = vShutterOpening;
vShutterOpening_h = vShutterBodyOuter_h;

vStepperMotorAxis_d = 10;
vStepperMotorAxis_h = vShutterBodyOuter_h;
vStepperMotorAxis_offsetX = 53.5; // empirical!
vStepperMotorAxis_offsetY = 0;
vStepperMotorAxis_offsetZ = 0;

vStepperMotorScrewHole_d = 3.5;
vStepperMotorScrewHole_h = vShutterBodyOuter_h;
vStepperMotorScrewHole_offsetX = vStepperMotorAxis_offsetX;
vStepperMotorScrewHole_offsetY = 21;
vStepperMotorScrewHole_offsetZ = 0;

vPowerGearBox_l = vStepperMotorAxis_offsetX+10;
vPowerGearBox_w = 2*(vStepperMotorScrewHole_offsetY+vStepperMotorScrewHole_d);
vPowerGearBox_h = vShutterBodyOuter_h;
vPowerGearBox_offsetX = 0;
vPowerGearBox_offsetY = -vPowerGearBox_w/2;
vPowerGearBox_offsetZ = 0;

vPowerGearCutout_l = vPowerGearBox_l;
vPowerGearCutout_w = 2*(vStepperMotorScrewHole_offsetY-vStepperMotorScrewHole_d); // assuming a gear with 20 teeth and module 1, we need about 25mm
vPowerGearCutout_h = vShutterBodyInner_h;
vPowerGearCutout_offsetX = 0;
vPowerGearCutout_offsetY = -vPowerGearCutout_w/2;
vPowerGearCutout_offsetZ = vWallStrength+vBladeThickness+(2*vTolerance);

vBladeAxisPin_d = 4-(2*vTolerance);
vBladeAxisPin_h = vShutterBodyOuter_h + vWallStrength;
vBladeAxisPin_offsetR = vBladeAxisCircle/2;

vOuterGearBasePad_d = 6;
vOuterGearBasePad_h = vWallStrength+vBladeThickness+(2*vTolerance);
vOuterGearBasePad_offsetR = 42.5;

vLidScrewTube_d = 10;
vLidScrewHole_d = 4.5;
vLidScrewTube_h = vShutterBodyOuter_h;
vLidScrewTube_offsetX = (vShutterBodyOuter_d + vLidScrewHole_d) / 2;
vLidScrewTube_offsetY = 0;
vLidScrewTube_offsetZ = 0;

/*
##################################################
## variables specifically for the shutter lid
##################################################
*/

vShutterLidOuter_d = vShutterBodyOuter_d;
vShutterLidOuter_h = vWallStrength;
vShutterLidOuter_offsetX = 0;
vShutterLidOuter_offsetY = 0;
vShutterLidOuter_offsetZ = 0;

vShutterLidInner_d = vShutterLidOuter_d - (2*vWallStrength) - (2*vTolerance);
vShutterLidInner_h = vWallStrength;
vShutterLidInner_offsetX = 0;
vShutterLidInner_offsetY = 0;
vShutterLidInner_offsetZ = vWallStrength;

vShutterLidOpening_d = vShutterOpening;
vShutterLidOpening_h = vShutterLidOuter_h + vShutterLidInner_h;

vShutterLidBladeAxisHole_d = vBladeAxis_d+vTolerance;
vShutterLidBladeAxisHole_h = vShutterLidOpening_h;
vShutterLidBladeAxisHole_offsetR = vBladeAxisCircle/2;


vBladeStopPin_d = 4;
vBladeStopPin_h = 2.6;
vBladeStopPin_offsetX = vShutterLidBladeAxisHole_offsetR - (vBladeStopPin_d/2) - 0.3;
vBladeStopPin_offsetY = (vShutterLidBladeAxisHole_d/2) + 1 + (vBladeStopPin_d/2);
vBladeStopPin_offsetZ = vShutterLidOpening_h;

/*
##################################################
## variables specifically for the integrated shutter lid / linhopf adapter
##################################################
*/

vShutterLidLinhofOuter_d = vShutterBodyOuter_d;
vShutterLidLinhofOuter_h = vWallStrength;
// the offset variables are depending on following variables, so we set them later  

vShutterLidLinhofInner_d = vShutterLidLinhofOuter_d - (2*vWallStrength) - (2*vTolerance);
vShutterLidLinhofInner_h = vWallStrength-vTolerance;
// the offset variables are depending on following variables, so we set them later  

vShutterLidLinhofOpening_d = vShutterOpening;
vShutterLidLinhofOpening_h = vShutterLidLinhofOuter_h + vShutterLidLinhofInner_h;

vShutterLidLinhofBladeAxisHole_d = vBladeAxis_d+vTolerance;
vShutterLidLinhofBladeAxisHole_h = 10;

vShutterLidLinhofBladeStopPin_d = 4;
vShutterLidLinhofBladeStopPin_h = 2.6;

/*
adapter specific variables
// Linhof/Wista style
// caution: we are working with a slightly simplified geometry
*/
vLightSealOuter_d = 83;
vLightSealInner_d = vLightSealOuter_d-8;
vLightSeal_h = 3;
vLightSeal_offsetX = 0;
vLightSeal_offsetY = 0;
vLightSeal_offsetZ = 0;

vAdapterPlate_l = 99;
vAdapterPlate_w = 96;
vAdapterPlate_h = 2;
vAdapterPlate_offsetX = -48; // caution: lightseal and bore are off center!
vAdapterPlate_offsetY = -vAdapterPlate_w/2;
vAdapterPlate_offsetZ = vLightSeal_h;

vAdapterCone_d1 = vAdapterPlate_w - 8; // we need about 4mm space on the upper and lower side for the lensboard clamps
vAdapterCone_d2 = vShutterLidLinhofOuter_d;
vAdapterCone_h = 6;
vAdapterCone_offsetX = 0;
vAdapterCone_offsetY = 0;
vAdapterCone_offsetZ = vLightSeal_h + vAdapterPlate_h;

vShutterLidLinhofOuter_offsetX = 0;
vShutterLidLinhofOuter_offsetY = 0;
vShutterLidLinhofOuter_offsetZ = vLightSeal_h + vAdapterPlate_h + vAdapterCone_h;

vShutterLidLinhofInner_offsetX = 0;
vShutterLidLinhofInner_offsetY = 0;
vShutterLidLinhofInner_offsetZ = vLightSeal_h + vAdapterPlate_h + vAdapterCone_h + vShutterLidLinhofOuter_h;

vShutterLidLinhofBladeAxisHole_offsetX = vBladeAxisCircle/2;
vShutterLidLinhofBladeAxisHole_offsetY = 0;
vShutterLidLinhofBladeAxisHole_offsetZ = vShutterLidLinhofOuter_offsetZ - 2;

vShutterLidLinhofBladeStopPin_offsetX = vShutterLidLinhofBladeAxisHole_offsetX - (vShutterLidLinhofBladeStopPin_d/2) - 0.3;
vShutterLidLinhofBladeStopPin_offsetY = (vShutterLidLinhofBladeAxisHole_d/2) + 1 + (vShutterLidLinhofBladeStopPin_d/2);
vShutterLidLinhofBladeStopPin_offsetZ = vLightSeal_h + vAdapterPlate_h + vAdapterCone_h + vShutterLidLinhofOuter_h + vShutterLidLinhofInner_h;

vShutterLidLinhofBore_d1 = vLightSealInner_d;
vShutterLidLinhofBore_d2 = vShutterLidLinhofOpening_d;
vShutterLidLinhofBore_h = vLightSeal_h + vAdapterPlate_h + vAdapterCone_h + vShutterLidLinhofOuter_h + vShutterLidLinhofInner_h;
vShutterLidLinhofBore_offsetX = 0;
vShutterLidLinhofBore_offsetY = 0;
vShutterLidLinhofBore_offsetZ = 0;

vShutterLidLinhofScrewTube_d = 10;
vShutterLidLinhofScrewHole_d = 4.5;
vShutterLidLinhofScrewTube_h = vAdapterPlate_h + vAdapterCone_h + vShutterLidLinhofOuter_h;
vShutterLidLinhofScrewTube_offsetX = (vShutterLidLinhofOuter_d + vShutterLidLinhofScrewHole_d) / 2;
vShutterLidLinhofScrewTube_offsetY = 0;
vShutterLidLinhofScrewTube_offsetZ = vLightSeal_h;

vShutterLidLinhofScrewNut_KW = 7.1;
vShutterLidLinhofScrewNut_h = 3;
