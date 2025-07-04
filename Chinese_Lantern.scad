/* ================ Chinese Paper Lantern Parameters ================ */
/* --- Lantern Body Parameters --- */
frame_height      = 80;     // Lantern height
ellipse_major     = 35;     // Major axis radius of ellipse
ellipse_minor     = 54;     // Minor axis radius of ellipse
vertical_count    = 20;     // Number of vertical frames
bar_thickness     = 1.2;    // Frame bar thickness
skin_thickness    = 0.4;    // Skin thickness

/* --- Tassel Parameters --- */
tassel_count       = 60;    // Number of tassels
tassel_length      = 25;    // Tassel length
tassel_thickness   = 0.2;   // Tassel thread thickness
end_bead_diameter  = 3;     // End bead diameter
connector_height   = 5;     // Tassel connector height

/* ================ Lantern Main Structure ================ */
// 1. Vertical elliptical frames
for (i = [0:vertical_count-1]) {
    angle = i * (360 / vertical_count);
    rotate([0, 0, angle])
    translate([0, 0, frame_height/2])
    rotate([90, 0, 0])
    scale([1, frame_height/(ellipse_major*3), 1])
    rotate_extrude(angle=360)
    translate([ellipse_minor, 0])
    circle(d=bar_thickness);
}

// 2. Ellipsoid skin shell
z_scale = frame_height/(ellipse_major*3);  // Z-axis scaling factor
translate([0, 0, frame_height/2])
difference() {
    // Outer surface
    scale([ellipse_minor, ellipse_minor, ellipse_minor * z_scale])
    sphere(1, $fn=96);
    
    // Inner surface (hollow out to form shell)
    scale([
        ellipse_minor - skin_thickness, 
        ellipse_minor - skin_thickness, 
        (ellipse_minor - skin_thickness) * z_scale
    ])
    sphere(1, $fn=96);
}

/* ================ Lantern Fixing Rings ================ */
// Top fixing ring system
translate([0, 0, frame_height]) {
    rotate_extrude(angle=360)
    translate([ellipse_minor * 0.25, 0])
    circle(d=bar_thickness * 2);
    
    translate([0,0,2.5]) cylinder(h=6.25, r1=14.25, r2=10, center=true);
    
    translate([0, 0, 4.85])
    rotate_extrude(angle=360)
    translate([ellipse_minor * 0.185, 0])
    circle(d=bar_thickness * 1.75);
}

// Bottom fixing ring system
translate([0, 0, 0]) {
    rotate_extrude(angle=360)
    translate([ellipse_minor * 0.25, 0])
    circle(d=bar_thickness * 2);
    
    translate([0,0,-2.5]) cylinder(h=6.25, r1=10, r2=14, center=true);
    
    translate([0, 0, -4.85])
    rotate_extrude(angle=360)
    translate([ellipse_minor * 0.185, 0])
    circle(d=bar_thickness * 1.75);
}

/* ================ Hanging System ================= */
// Top hook connection point
translate([0, 0, frame_height + 8.65])
sphere(d=bar_thickness * 5.5);

// Bottom hanging rod
translate([0,0,-20]) cylinder(h=40, r=0.5, center=true);
translate([0,0,-35]) sphere(2);
translate([0,0,-40]) sphere(1.5);

/* ================ Tassel System ================= */
// Tassel connector
translate([0, 0, -7]) {
    sphere(d=bar_thickness * 3);  // Central connection point
    cylinder(h=connector_height, r1=5, r2=8);  // Tassel support
}

// Create tassel array
for (i = [0:tassel_count-1]) {
    angle = i * (360 / tassel_count);
    distance = 10;  // Tassel starting distance from center
    
    translate([distance * cos(angle), distance * sin(angle), 0.5 - connector_height]) {
        // Tassel thread
        translate([0, 0, -tassel_length])
        cylinder(h=tassel_length, d=tassel_thickness, $fn=8);
        
        // Tassel end decorative bead
        translate([0, 0, -tassel_length])
        sphere(d=end_bead_diameter-2.3, $fn=20);
    }
}