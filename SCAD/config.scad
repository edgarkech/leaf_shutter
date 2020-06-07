/*
This is the base configuration file for the shutter
*/

$fn = 60;

// general tolerance
vTolerance = 0.2;

vMaxAperture = 40;

vNoOfBlades = 5;
vBladeAxis_d = 4;
vBladeAngle = 360/vNoOfBlades;

vBladeBase_r = vMaxAperture/2 + 1;
vBladeBase_h = 2;
vBladeBase_offsetX = 0;
vBladeBase_offsetY = 0;
vBladeBase_offsetZ = 0;

vBladeRib_l = vMaxAperture;
vBladeRib_w = vBladeAxis_d*2.5/2;
vBladeRib_h = vBladeBase_h;
vBladeRib_offsetX = 0;
vBladeRib_offsetY = 0;
vBladeRib_offsetZ = 0;

vBladeEye_d = 2.5* vBladeAxis_d;
vBladeEye_offsetX = vBladeRib_l;
vBladeEye_offsetY = 0;
vBladeEye_offsetZ = 0;

vBladeAxisHole_d = vBladeAxis_d + vTolerance;
vBladeAxisHole_h = vBladeBase_h;
vBladeAxisHole_offsetX = vBladeRib_l;
vBladeAxisHole_offsetY = 0;
vBladeAxisHole_offsetZ = 0;

vLightSeal_l = vBladeBase_r;
vLightSeal_w = vBladeBase_h;
vLightSeal_h = -vLightSeal_w/2;
vLightSeal_offsetX = 0;
vLightSeal_offsetY = 0;
vLightSeal_offsetZ = 0;

vLightSealNeg_l = vBladeBase_r+vBladeBase_h;
vLightSealNeg_w = vBladeBase_h;
vLightSealNeg_h = -vLightSealNeg_w/2;
vLightSealNeg_offsetX = -vBladeBase_h/2;
vLightSealNeg_offsetY = 0;
vLightSealNeg_offsetZ = 0;

vCaseOuter_d = 2.5*vMaxAperture;
vCase_walls = 2;
vCaseInner_d = vCaseOuter_d-(2*vCase_walls);
vCaseOuter_h = 8;
vCaseInner_h = vCaseOuter_h - vCase_walls;
vCaseInner_offsetX = 0;
vCaseInner_offsetY = 0;
vCaseInner_offsetZ = vCase_walls;
