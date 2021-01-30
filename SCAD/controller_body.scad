
// loading the base configuration
// include <config.scad>;

// some modules such as hex, countersunk screws, roof, wedge are available in a module file
use <modules.scad>;
//use <threads.scad>;

$fn=120;

vWallStrength = 2;
vTolerance = 0.2;



// for easier vizualization
vController_l = 80;
vController_w = 60;
vController_h = 26;
vController_offsetX = 0;
vController_offsetY = 0;
vController_offsetZ = 4;

vDriver_l = 22;
vDriver_w = 50;
vDriver_h = 10;
vDriver_offsetX = vController_l + 5;
vDriver_offsetY = 0;
vDriver_offsetZ = 4;

vBattery_l = 18;
vBattery_w = 50;
vBattery_h = 28;
vBattery_offsetX = vDriver_offsetX + vDriver_l + 5;
vBattery_offsetY = 0;
vBattery_offsetZ = 2;

vEdgeCylinder_d = 12;
vEdgeCylinder_h = 30;
vEdgeCylinder_offsetX1 = -vEdgeCylinder_d/2;
vEdgeCylinder_offsetX2 = vBattery_offsetX + vBattery_l + vEdgeCylinder_d/2;
vEdgeCylinder_offsetY1 = vEdgeCylinder_d/2 - vWallStrength - 1 ;
vEdgeCylinder_offsetY2 = vController_w - vEdgeCylinder_offsetY1;
vEdgeCylinder_offsetZ = 0;

vCutoutCylinder_d = vEdgeCylinder_d - (2*vWallStrength);
vCutoutCylinder_h = vEdgeCylinder_h - vWallStrength;
vCutoutCylinder_offsetX1 = vEdgeCylinder_offsetX1;
vCutoutCylinder_offsetX2 = vEdgeCylinder_offsetX2;
vCutoutCylinder_offsetY1 = vEdgeCylinder_offsetY1;
vCutoutCylinder_offsetY2 = vEdgeCylinder_offsetY2;
vCutoutCylinder_offsetZ = vWallStrength;

vScrewTube_d = vEdgeCylinder_d;
vScrewTube_h = vEdgeCylinder_h - vWallStrength;
vScrewTube_offsetX1 = vEdgeCylinder_offsetX1;
vScrewTube_offsetX2 = vEdgeCylinder_offsetX2;
vScrewTube_offsetY1 = vEdgeCylinder_offsetY1;
vScrewTube_offsetY2 = vEdgeCylinder_offsetY2;
vScrewTube_offsetZ = vEdgeCylinder_offsetZ;

// we will use M4 threads to press into the holes
// they need a hole of about 5.5mm
vScrewHole_d = 5.5;
vScrewHole_h = 16;
vScrewHole_offsetX1 = vEdgeCylinder_offsetX1;
vScrewHole_offsetX2 = vEdgeCylinder_offsetX2;
vScrewHole_offsetY1 = vEdgeCylinder_offsetY1;
vScrewHole_offsetY2 = vEdgeCylinder_offsetY2;
vScrewHole_offsetZ = vScrewTube_h-vScrewHole_h;

vBatteryWall_l = 2;
vBatteryWall_w = vController_w + (2*vWallStrength);
vBatteryWall_h = vController_h/2;
vBatteryWall_offsetX1 = vBattery_offsetX - vBatteryWall_l;
vBatteryWall_offsetX2 = vBattery_offsetX + vBattery_l;
vBatteryWall_offsetY = -vWallStrength;
vBatteryWall_offsetZ = vWallStrength;

vStrainReliefBlock_l = vDriver_l;
vStrainReliefBlock_w = 10;
vStrainReliefBlock_h = 12;
vStrainReliefBlock_offsetX = vDriver_offsetX;
vStrainReliefBlock_offsetY = vController_w + 1 - vStrainReliefBlock_w;
vStrainReliefBlock_offsetZ = vWallStrength;

vStrainReliefScrewHole_d = 2.6;
vStrainReliefScrewHole_h = vStrainReliefBlock_h;
vStrainReliefScrewHole_offsetX1 = vStrainReliefBlock_offsetX + 5;
vStrainReliefScrewHole_offsetX2 = vStrainReliefBlock_offsetX + vStrainReliefBlock_l -5;
vStrainReliefScrewHole_offsetY = vStrainReliefBlock_offsetY + 5;
vStrainReliefScrewHole_offsetZ = vStrainReliefBlock_offsetZ;

vCableHole_d = 5;
vCableHole_h = vStrainReliefBlock_w + vWallStrength;
vCableHole_offsetX = vStrainReliefBlock_offsetX + vStrainReliefBlock_l/2;
vCableHole_offsetY = vStrainReliefBlock_offsetY;
vCableHole_offsetZ = vStrainReliefBlock_offsetZ + vStrainReliefBlock_h;

vBoardPod_d = 6;
vBoardPod_h = 2;
vBoardPod1_offsetX = 26;
vBoardPod1_offsetY = 5;
vBoardPod2_offsetX = 27;
vBoardPod2_offsetY = 53.5;
vBoardPod3_offsetX = 78;
vBoardPod3_offsetY = 10.5;
vBoardPod4_offsetX = 78;
vBoardPod4_offsetY = 39;
vBoardPod5_offsetX = vDriver_offsetX + 14;
vBoardPod5_offsetY = 9;
vBoardPod6_offsetX = vDriver_offsetX + 10;
vBoardPod6_offsetY = 33;
vBoardPod_offsetZ = vWallStrength;

// we are using the BoardPod offsets!
vBoardPin_d = 2.4;
vBoardPin_h = vBoardPod_h + 3;

/*
// only for easier vizualization
color("Crimson"){
translate([vController_offsetX, vController_offsetY, vController_offsetZ])
    cube([vController_l, vController_w, vController_h]);
}
;

// only for easier vizualization
color("Purple"){
translate([vDriver_offsetX, vDriver_offsetY, vDriver_offsetZ])
    cube([vDriver_l, vDriver_w, vDriver_h]);
}
;

// only for easier vizualization
color("Navy"){
translate([vBattery_offsetX, vBattery_offsetY, vBattery_offsetZ])
    cube([vBattery_l, vBattery_w, vBattery_h]);
}
;
*/
// start with the real design

difference(){
    union(){
        difference(){
            // outer shape
            hull(){
                translate([vEdgeCylinder_offsetX1, vEdgeCylinder_offsetY1, vEdgeCylinder_offsetZ])
                    cylinder(d=vEdgeCylinder_d, h=vEdgeCylinder_h);
                translate([vEdgeCylinder_offsetX2, vEdgeCylinder_offsetY1, vEdgeCylinder_offsetZ])
                    cylinder(d=vEdgeCylinder_d, h=vEdgeCylinder_h);
                translate([vEdgeCylinder_offsetX1, vEdgeCylinder_offsetY2, vEdgeCylinder_offsetZ])
                    cylinder(d=vEdgeCylinder_d, h=vEdgeCylinder_h);
                translate([vEdgeCylinder_offsetX2, vEdgeCylinder_offsetY2, vEdgeCylinder_offsetZ])
                    cylinder(d=vEdgeCylinder_d, h=vEdgeCylinder_h);
            }

            // cutout
            hull(){
                translate([vCutoutCylinder_offsetX1, vCutoutCylinder_offsetY1, vCutoutCylinder_offsetZ])
                    cylinder(d=vCutoutCylinder_d, h=vCutoutCylinder_h);
                translate([vCutoutCylinder_offsetX2, vCutoutCylinder_offsetY1, vCutoutCylinder_offsetZ])
                    cylinder(d=vCutoutCylinder_d, h=vCutoutCylinder_h);
                translate([vCutoutCylinder_offsetX1, vCutoutCylinder_offsetY2, vCutoutCylinder_offsetZ])
                    cylinder(d=vCutoutCylinder_d, h=vCutoutCylinder_h);
                translate([vCutoutCylinder_offsetX2, vCutoutCylinder_offsetY2, vCutoutCylinder_offsetZ])
                    cylinder(d=vCutoutCylinder_d, h=vCutoutCylinder_h);
            }

        }

        // walls for holding the battery in place
        translate([vBatteryWall_offsetX1, vBatteryWall_offsetY, vBatteryWall_offsetZ])
            cube([vBatteryWall_l, vBatteryWall_w, vBatteryWall_h]);
        translate([vBatteryWall_offsetX2, vBatteryWall_offsetY, vBatteryWall_offsetZ])
            cube([vBatteryWall_l, vBatteryWall_w, vBatteryWall_h]);
        
        
        // pods for the controller board
        translate([vBoardPod1_offsetX, vBoardPod1_offsetY, vBoardPod_offsetZ])
            cylinder(d=vBoardPod_d, h=vBoardPod_h);
        translate([vBoardPod2_offsetX, vBoardPod2_offsetY, vBoardPod_offsetZ])
            cylinder(d=vBoardPod_d, h=vBoardPod_h);
        translate([vBoardPod3_offsetX, vBoardPod3_offsetY, vBoardPod_offsetZ])
            cylinder(d=vBoardPod_d, h=vBoardPod_h);
        translate([vBoardPod4_offsetX, vBoardPod4_offsetY, vBoardPod_offsetZ])
            cylinder(d=vBoardPod_d, h=vBoardPod_h);
        
        
        // pods for the driver board
        translate([vBoardPod5_offsetX, vBoardPod5_offsetY, vBoardPod_offsetZ])
            cylinder(d=vBoardPod_d, h=vBoardPod_h);
        translate([vBoardPod6_offsetX, vBoardPod6_offsetY, vBoardPod_offsetZ])
            cylinder(d=vBoardPod_d, h=vBoardPod_h);
            
            
        // pins for the controller board
        translate([vBoardPod1_offsetX, vBoardPod1_offsetY, vBoardPod_offsetZ])
            cylinder(d=vBoardPin_d, h=vBoardPin_h);
        translate([vBoardPod2_offsetX, vBoardPod2_offsetY, vBoardPod_offsetZ])
            cylinder(d=vBoardPin_d, h=vBoardPin_h);
        translate([vBoardPod3_offsetX, vBoardPod3_offsetY, vBoardPod_offsetZ])
            cylinder(d=vBoardPin_d, h=vBoardPin_h);
        translate([vBoardPod4_offsetX, vBoardPod4_offsetY, vBoardPod_offsetZ])
            cylinder(d=vBoardPin_d, h=vBoardPin_h);
        
        
        // pins for the driver board
        translate([vBoardPod5_offsetX, vBoardPod5_offsetY, vBoardPod_offsetZ])
            cylinder(d=vBoardPin_d, h=vBoardPin_h);
        translate([vBoardPod6_offsetX, vBoardPod6_offsetY, vBoardPod_offsetZ])
            cylinder(d=vBoardPin_d, h=vBoardPin_h);    

        // strain relief for the stepper cable
        translate([vStrainReliefBlock_offsetX, vStrainReliefBlock_offsetY, vStrainReliefBlock_offsetZ])
            cube([vStrainReliefBlock_l, vStrainReliefBlock_w, vStrainReliefBlock_h]);
        
        

        // cylinders in the edges for the lid screw threads
        translate([vScrewTube_offsetX1, vScrewTube_offsetY1, vScrewTube_offsetZ])
            cylinder(d=vScrewTube_d, h=vScrewTube_h);
        translate([vScrewTube_offsetX2, vScrewTube_offsetY1, vScrewTube_offsetZ])
            cylinder(d=vScrewTube_d, h=vScrewTube_h);
        translate([vScrewTube_offsetX1, vScrewTube_offsetY2, vScrewTube_offsetZ])
            cylinder(d=vScrewTube_d, h=vScrewTube_h);
        translate([vScrewTube_offsetX2, vScrewTube_offsetY2, vScrewTube_offsetZ])
            cylinder(d=vScrewTube_d, h=vScrewTube_h);

        }

// holes for the lid screw threads
translate([vScrewHole_offsetX1, vScrewHole_offsetY1, vScrewHole_offsetZ])
    cylinder(d=vScrewHole_d, h=vScrewHole_h);
translate([vScrewHole_offsetX2, vScrewHole_offsetY1, vScrewHole_offsetZ])
    cylinder(d=vScrewHole_d, h=vScrewHole_h);
translate([vScrewHole_offsetX1, vScrewHole_offsetY2, vScrewHole_offsetZ])
    cylinder(d=vScrewHole_d, h=vScrewHole_h);
translate([vScrewHole_offsetX2, vScrewHole_offsetY2, vScrewHole_offsetZ])
    cylinder(d=vScrewHole_d, h=vScrewHole_h);

// screw holes in the strain relief block
translate([vStrainReliefScrewHole_offsetX1, vStrainReliefScrewHole_offsetY, vStrainReliefScrewHole_offsetZ])
    cylinder(d=vStrainReliefScrewHole_d, h=vStrainReliefScrewHole_h);
translate([vStrainReliefScrewHole_offsetX2, vStrainReliefScrewHole_offsetY, vStrainReliefScrewHole_offsetZ])
    cylinder(d=vStrainReliefScrewHole_d, h=vStrainReliefScrewHole_h);

// hole for the stepper cable
translate([vCableHole_offsetX, vCableHole_offsetY, vCableHole_offsetZ])
    rotate([-90, 0, 0]) 
        cylinder(d=vCableHole_d, h=vCableHole_h);        
        


}