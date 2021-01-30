// loading the base configuration
include <config.scad>;



union(){
    difference(){
        union(){
            // outer cylinder
            cylinder(d=vShutterBodyOuter_d, h=vShutterBodyOuter_h);
            
            // we add a box for the power gear
            translate([vPowerGearBox_offsetX, vPowerGearBox_offsetY, vPowerGearBox_offsetZ])
            cube([vPowerGearBox_l, vPowerGearBox_w, vPowerGearBox_h]);
            
            // tubes for the lid screws
            for (a =[0:1:3]){
                rotate([0, 0, (a*90)+45])
                    translate([vLidScrewTube_offsetX, vLidScrewTube_offsetY, vLidScrewTube_offsetZ])
                        cylinder(d=vLidScrewTube_d, h=vLidScrewTube_h);
            };
        };
        // subtracting the inner cylinder
        translate([vShutterBodyInner_offsetX, vShutterBodyInner_offsetY, vShutterBodyInner_offsetZ])
            cylinder(d=vShutterBodyInner_d, h=vShutterBodyInner_h);
        
        // shutter opening
        translate([0,0,0])
        cylinder(d=vShutterOpening_d, h = vShutterOpening_h);
        
        
        
        // cutout for power gear
        translate([vPowerGearCutout_offsetX, vPowerGearCutout_offsetY, vPowerGearCutout_offsetZ])
            cube([vPowerGearCutout_l, vPowerGearCutout_w, vPowerGearCutout_h]);
        
        // Stepper motor axis hole
        translate([vStepperMotorAxis_offsetX, vStepperMotorAxis_offsetY, vStepperMotorAxis_offsetZ])
            cylinder(d=vStepperMotorAxis_d, h=vStepperMotorAxis_h);
        
        // stepper motor screw holes
        translate([vStepperMotorScrewHole_offsetX, vStepperMotorScrewHole_offsetY, vStepperMotorScrewHole_offsetZ])
            cylinder(d=vStepperMotorScrewHole_d, h= vStepperMotorScrewHole_h);
        translate([vStepperMotorScrewHole_offsetX, -vStepperMotorScrewHole_offsetY, vStepperMotorScrewHole_offsetZ])
            cylinder(d=vStepperMotorScrewHole_d, h= vStepperMotorScrewHole_h);
         
        // screw holes for the lid screws
        for (a =[0:1:3]){
            rotate([0, 0, (a*90)+45])
                translate([vLidScrewTube_offsetX, vLidScrewTube_offsetY, vLidScrewTube_offsetZ])
                    cylinder(d=vLidScrewHole_d, h=vLidScrewTube_h);
        };

}
// little pads for the gear ring, so it can glide better over the blades 
for (a =[0:1:vNoOfBlades-1]){
            rotate([0, 0, a*vAngleIncrement])
                translate([vOuterGearBasePad_offsetR, 0, 0])
                    cylinder(d=vOuterGearBasePad_d, h=vOuterGearBasePad_h );
        };

// Pins for the shutter blades
for (a =[0:1:vNoOfBlades-1]){
            rotate([0, 0, a*vAngleIncrement])
                translate([vBladeAxisPin_offsetR, 0, 0])
                    cylinder(d=vBladeAxisPin_d, h=vBladeAxisPin_h );
        };

};