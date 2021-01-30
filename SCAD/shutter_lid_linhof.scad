 
// loading the base configuration
include <config.scad>;





difference(){
union(){
        // light seal from the adapter plate
        translate([vLightSeal_offsetX, vLightSeal_offsetY, vLightSeal_offsetZ])
            cylinder(d=vLightSealOuter_d, h=vLightSeal_h);
    
        // adapter plate
        translate([vAdapterPlate_offsetX, vAdapterPlate_offsetY, vAdapterPlate_offsetZ])
            cube([vAdapterPlate_l, vAdapterPlate_w, vAdapterPlate_h]);
    
        // adapter cone
        translate([vAdapterCone_offsetX, vAdapterCone_offsetY, vAdapterCone_offsetZ])
            cylinder(d1=vAdapterCone_d1, d2=vAdapterCone_d2, h=vAdapterCone_h);
        
        // this is the "real" shutter lid 
        translate([vShutterLidLinhofOuter_offsetX, vShutterLidLinhofOuter_offsetY, vShutterLidLinhofOuter_offsetZ])
            cylinder(d=vShutterLidLinhofOuter_d, h=vShutterLidLinhofOuter_h);
        
        // light seal for the lid
        translate([vShutterLidLinhofInner_offsetX, vShutterLidLinhofInner_offsetY, vShutterLidLinhofInner_offsetZ])
            cylinder(d=vShutterLidLinhofInner_d, h=vShutterLidLinhofInner_h);
        
        // blade stop pins
        for (a =[0:1:vNoOfBlades-1]){
            rotate([0, 0, a*vAngleIncrement])
                translate([vShutterLidLinhofBladeStopPin_offsetX, vShutterLidLinhofBladeStopPin_offsetY, vShutterLidLinhofBladeStopPin_offsetZ])
                    cylinder(d=vShutterLidLinhofBladeStopPin_d, h=vShutterLidLinhofBladeStopPin_h);
        };
        
        // tubes for the lid screws
        for (a =[0:1:3]){
            rotate([0, 0, (a*90)+45])
                translate([vShutterLidLinhofScrewTube_offsetX, vShutterLidLinhofScrewTube_offsetY, vShutterLidLinhofScrewTube_offsetZ])
                    cylinder(d=vShutterLidLinhofScrewTube_d, h=vShutterLidLinhofScrewTube_h);
        };
    
    
    }
    
    
        cylinder(d1=vShutterLidLinhofBore_d1, d2=vShutterLidLinhofBore_d2, h=vShutterLidLinhofBore_h);
        
        // holes for the blade axis pins
        for (a =[0:1:vNoOfBlades-1]){
            rotate([0, 0, a*vAngleIncrement])
                translate([vShutterLidLinhofBladeAxisHole_offsetX, vShutterLidLinhofBladeAxisHole_offsetY, vShutterLidLinhofBladeAxisHole_offsetZ])
                    cylinder(d=vShutterLidLinhofBladeAxisHole_d, h=vShutterLidLinhofBladeAxisHole_h );
        };
        
        // screw holes for the lid screws
        for (a =[0:1:3]){
            rotate([0, 0, (a*90)+45])
                translate([vShutterLidLinhofScrewTube_offsetX, vShutterLidLinhofScrewTube_offsetY, vShutterLidLinhofScrewTube_offsetZ])
                    cylinder(d=vShutterLidLinhofScrewHole_d, h=vShutterLidLinhofScrewTube_h);
        };
        
        // hex cutouts for the lid screw nuts
        for (a =[0:1:3]){
            rotate([0, 0, (a*90)+45])
                translate([vShutterLidLinhofScrewTube_offsetX, vShutterLidLinhofScrewTube_offsetY, vShutterLidLinhofScrewTube_offsetZ])
                    hex(vShutterLidLinhofScrewNut_KW, h=vShutterLidLinhofScrewNut_h);
        };
        
}
