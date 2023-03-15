include <BOSL/shapes.scad>

$fn=42; 

hp = 10;
length = hp * 5.08;
depth = 24;
rail_thickness = 9.5;

lip_depth = 2.5;
lip_thickness = 1.2;

hole_distance = 5;
hole_depth = 6;

side_mount_radius = 2;

module generateRail(){
    difference(){
        cuboid(
            [depth, length, rail_thickness],
            center=false,
            chamfer=0.8,
            edges=EDGE_TOP_FR+EDGE_TOP_BK + EDGE_TOP_RT+EDGE_FR_RT+EDGE_BK_RT,
            $fn=24);
        
        union(){
            translate([0, 0, lip_thickness])
                cube([lip_depth, length+1, rail_thickness-lip_thickness]);
            
            caseMountTop();
            caseMountSides();
            mountingHoleGrid();
        }
    }   
    
    // Make sure end walls are still thick
    union(){
        translate([lip_depth, 0, 0])
        cube([6, 0.4, 6]);
        
        translate([lip_depth, length-0.4, 0])
        cube([6, 0.4, 6]);
        }
    }
    
module caseMountTop(){
        translate([depth-12, 10, 4])
        cuboid(
            [depth, length - 20, 20],
            center=false,
            chamfer=4,
            $fn=24);
    
       // Center hole
       translate([depth - 4, length / 2, 0])
       #cylinder(r=1.25, h=2);
       
       translate([depth - 4, length / 2, 2])
       #cylinder(r=3, h=2);
    
       // Flank holes
       if (length > 100)
       union(){
           translate([depth-4, 20, 0])
           #cylinder(r=2, h=2);
           translate([depth-4, 20, 2])
           #cylinder(r=4, h=2);
        
           translate([depth-4, length-20, 0])
           #cylinder(r=2, h=2);
           translate([depth-4, length-20, 2])
           #cylinder(r=4, h=2);
       }
    }

module caseMountSides(){
    translate([12 + side_mount_radius, 11, lip_thickness + 1.8 + side_mount_radius - 0.5])
    rotate([90, 0, 0])
    #cylinder(r=side_mount_radius, h=12);

    translate([12 + side_mount_radius, length+1, lip_thickness + 1.8 + side_mount_radius - 0.5])
    rotate([90, 0, 0])
    #cylinder(r=side_mount_radius, h=12);

}
module mountingHoleGrid(){
    translate([lip_depth, 1, lip_thickness + 2])
    for ( i = [0 : hole_distance : length - hole_distance] ){
            translate([0, i, 0])
            #cube([hole_depth, 4.5, 3]);
        }
    }

generateRail();

