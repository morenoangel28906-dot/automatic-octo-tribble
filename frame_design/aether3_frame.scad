// ============================================================
// PHANTOM 3 - 3-Inch Drone Frame
// Inspired by Aether 4 | Original Design
// ============================================================
// Designer: Claude AI-Assisted Parametric Design
// Compatibility:
//   - Camera/VTX: Walksnail Avatar GT
//   - FC: SpeedyBee F405 Mini 20x20 / JHEMCU GHF405AIO 25.5x25.5
//   - Motors: iFlight XING 1404 (12x12mm M2)
//   - Props: 3-inch (76.2mm)
// ============================================================

// ==================== PARAMETERS ====================

// --- Frame Geometry (Stretched X / Dead Cat) ---
frame_style = "deadcat"; // "stretched_x" or "deadcat"

// Motor positions (from center, mm)
front_motor_spread  = 68;   // half-width between front motors
rear_motor_spread   = 58;   // half-width between rear motors
front_motor_y       = 62;   // front motors forward of center
rear_motor_y        = -58;  // rear motors behind center

// --- Carbon Fiber Plate Thicknesses ---
bottom_plate_thick  = 2.5;  // mm - main structural plate
top_plate_thick     = 2.0;  // mm - top plate
arm_thick           = 4.0;  // mm - arm width at root
arm_tip_width       = 10;   // mm - arm width at motor mount
arm_root_width      = 14;   // mm - arm width at body junction

// --- Body Dimensions ---
body_length         = 52;   // mm - center body length
body_width          = 30;   // mm - center body width
body_fillet         = 5;    // mm - corner radius

// --- Prop Clearance ---
prop_diameter       = 76.2; // mm - 3 inch
prop_clearance      = 4;    // mm - minimum between prop tips

// --- Motor Mount (iFlight XING 1404) ---
motor_mount_pattern = 12;   // mm - bolt pattern (12x12)
motor_mount_bolt    = 2;    // mm - M2 bolts
motor_diameter      = 16;   // mm - motor can OD
motor_shaft         = 1.5;  // mm - shaft diameter
motor_mount_holes   = 4;    // number of mounting holes

// --- FC Mount (Dual Pattern Support) ---
fc_20x20_pattern    = 20;   // mm - M2 holes
fc_20x20_bolt       = 2;    // mm
fc_25x25_pattern    = 25.5; // mm - M3 holes (actually M2 on most)
fc_25x25_bolt       = 2;    // mm

// --- Walksnail Avatar GT Camera ---
cam_width           = 19;   // mm - camera module width
cam_height          = 19;   // mm - camera module height
cam_depth           = 22;   // mm - camera module depth (with lens)
cam_mount_width     = 19;   // mm - side hole spacing
cam_mount_bolt      = 2;    // mm - M2 mounting bolts
cam_tilt_min        = 15;   // degrees - minimum camera tilt
cam_tilt_max        = 55;   // degrees - maximum camera tilt
cam_tilt_default    = 30;   // degrees - default tilt angle

// --- Walksnail Avatar GT VTX ---
vtx_width           = 28;   // mm - board width
vtx_height          = 30;   // mm - board height
vtx_mount_pattern   = 25.5; // mm - mounting hole pattern
vtx_mount_bolt      = 2;    // mm - M2 bolts

// --- Standoffs ---
standoff_height     = 22;   // mm - between bottom and top plates
standoff_od         = 5;    // mm - outer diameter
standoff_id         = 2.2;  // mm - inner diameter (M2)
standoff_count      = 4;    // number of standoffs

// --- Camera Side Plates ---
cam_plate_thick     = 2.0;  // mm
cam_plate_height    = 26;   // mm
cam_plate_width     = 18;   // mm

// --- Visualization ---
show_bottom_plate   = true;
show_top_plate      = true;
show_camera_mount   = true;
show_motors         = true;
show_camera         = true;
show_vtx            = true;
show_fc             = true;
show_standoffs      = true;
show_props          = false; // set true to check clearance

// Colors
color_carbon        = [0.15, 0.15, 0.18, 1];
color_motor         = [0.6, 0.6, 0.65, 1];
color_camera        = [0.2, 0.2, 0.25, 1];
color_vtx           = [0.1, 0.5, 0.1, 0.7];
color_fc            = [0.1, 0.1, 0.6, 0.7];
color_standoff      = [0.8, 0.3, 0.1, 1];
color_prop          = [0.3, 0.3, 0.35, 0.3];

// Resolution
$fn = 60;

// ==================== DERIVED VALUES ====================

motor_positions = [
    [-front_motor_spread,  front_motor_y],   // Front-Left
    [ front_motor_spread,  front_motor_y],   // Front-Right
    [-rear_motor_spread,  rear_motor_y],     // Rear-Left
    [ rear_motor_spread,  rear_motor_y],     // Rear-Right
];

// Standoff positions (inside body, near arm roots)
standoff_positions = [
    [-body_width/2 + 3,  body_length/2 - 5],
    [ body_width/2 - 3,  body_length/2 - 5],
    [-body_width/2 + 3, -body_length/2 + 5],
    [ body_width/2 - 3, -body_length/2 + 5],
];

// ==================== MODULES ====================

// --- Rounded Rectangle ---
module rounded_rect(w, h, r, t) {
    linear_extrude(height = t)
        offset(r = r)
            offset(r = -r)
                square([w, h], center = true);
}

// --- Motor Mount Pad ---
module motor_mount_pad(thickness) {
    difference() {
        // Circular pad
        cylinder(d = motor_diameter + 4, h = thickness);

        // Center hole for motor shaft/wires
        translate([0, 0, -0.5])
            cylinder(d = motor_shaft + 6, h = thickness + 1);

        // M2 mounting holes (12x12 pattern)
        for (dx = [-1, 1], dy = [-1, 1]) {
            translate([dx * motor_mount_pattern/2,
                      dy * motor_mount_pattern/2, -0.5])
                cylinder(d = motor_mount_bolt + 0.2, h = thickness + 1);
        }
    }
}

// --- Single Arm ---
module arm(motor_pos, thickness) {
    hull() {
        // Root at body
        translate([motor_pos[0] * 0.25, motor_pos[1] * 0.35, 0])
            cylinder(d = arm_root_width, h = thickness);

        // Tip at motor
        translate([motor_pos[0], motor_pos[1], 0])
            cylinder(d = arm_tip_width, h = thickness);
    }
}

// --- Body Plate (with cutouts for weight reduction) ---
module body_plate(thickness) {
    difference() {
        union() {
            // Central body
            rounded_rect(body_width, body_length, body_fillet, thickness);

            // Forward camera mount extension
            translate([0, body_length/2, 0])
                rounded_rect(body_width + 6, 12, 3, thickness);
        }

        // Weight reduction slots in body
        for (dy = [-12, 0, 12]) {
            translate([0, dy, -0.5])
                rounded_rect(10, 6, 2, thickness + 1);
        }
    }
}

// --- FC Mounting Holes ---
module fc_mount_holes(thickness) {
    // 20x20 pattern (M2)
    for (dx = [-1, 1], dy = [-1, 1]) {
        translate([dx * fc_20x20_pattern/2,
                  dy * fc_20x20_pattern/2, -0.5])
            cylinder(d = fc_20x20_bolt + 0.2, h = thickness + 1);
    }

    // 25.5x25.5 pattern (M2)
    for (dx = [-1, 1], dy = [-1, 1]) {
        translate([dx * fc_25x25_pattern/2,
                  dy * fc_25x25_pattern/2, -0.5])
            cylinder(d = fc_25x25_bolt + 0.2, h = thickness + 1);
    }
}

// --- Standoff Holes ---
module standoff_holes(thickness) {
    for (pos = standoff_positions) {
        translate([pos[0], pos[1], -0.5])
            cylinder(d = standoff_id, h = thickness + 1);
    }
}

// --- Bottom Plate (Complete) ---
module bottom_plate() {
    color(color_carbon)
    difference() {
        union() {
            // Body
            body_plate(bottom_plate_thick);

            // Arms
            for (pos = motor_positions) {
                arm(pos, bottom_plate_thick);

                // Motor mount pads
                translate([pos[0], pos[1], 0])
                    motor_mount_pad(bottom_plate_thick);
            }
        }

        // FC mounting holes (both patterns)
        fc_mount_holes(bottom_plate_thick);

        // Standoff holes
        standoff_holes(bottom_plate_thick);

        // Camera mount side plate slots (front)
        for (dx = [-1, 1]) {
            translate([dx * (cam_mount_width/2 + cam_plate_thick/2),
                      body_length/2 + 3, -0.5])
                cube([cam_plate_thick + 0.2, 4, bottom_plate_thick + 1],
                     center = true);
        }

        // Rear zip tie slots
        for (dx = [-1, 1]) {
            translate([dx * 8, -body_length/2 + 3, -0.5])
                rounded_rect(2, 6, 0.5, bottom_plate_thick + 1);
        }

        // Battery strap slots
        for (dy = [-8, 8]) {
            for (dx = [-1, 1]) {
                translate([dx * (body_width/2 - 1), dy, -0.5])
                    rounded_rect(3, 2, 0.5, bottom_plate_thick + 1);
            }
        }
    }
}

// --- Top Plate ---
module top_plate() {
    color(color_carbon)
    translate([0, 0, bottom_plate_thick + standoff_height])
    difference() {
        union() {
            // Main plate - slightly smaller than body
            rounded_rect(body_width - 2, body_length - 4, body_fillet - 1,
                        top_plate_thick);

            // Forward extension for camera support
            translate([0, body_length/2 - 4, 0])
                rounded_rect(body_width, 8, 3, top_plate_thick);
        }

        // Standoff holes
        standoff_holes(top_plate_thick);

        // VTX antenna hole
        translate([0, -body_length/2 + 8, -0.5])
            cylinder(d = 6, h = top_plate_thick + 1);

        // Weight reduction cutouts
        translate([0, 4, -0.5])
            rounded_rect(14, 16, 3, top_plate_thick + 1);

        translate([0, -10, -0.5])
            rounded_rect(10, 10, 3, top_plate_thick + 1);

        // Camera mount slots
        for (dx = [-1, 1]) {
            translate([dx * (cam_mount_width/2 + cam_plate_thick/2),
                      body_length/2 - 2, -0.5])
                cube([cam_plate_thick + 0.2, 4, top_plate_thick + 1],
                     center = true);
        }
    }
}

// --- Camera Side Plate (x2 needed) ---
module camera_side_plate() {
    color(color_carbon)
    difference() {
        // Main plate shape
        hull() {
            translate([0, 0, 0])
                cube([cam_plate_thick, 8, 0.01], center = true);
            translate([0, 0, cam_plate_height])
                cube([cam_plate_thick, cam_plate_width, 0.01], center = true);
        }

        // Camera bolt holes (multiple tilt angles)
        for (angle = [cam_tilt_min : 5 : cam_tilt_max]) {
            tilt_y = cam_height/2 * cos(angle) + cam_plate_height/2;
            tilt_z = cam_height/2 * sin(angle) + cam_plate_height/2;
            translate([0, 0, cam_plate_height * 0.55])
                rotate([0, 90, 0])
                    cylinder(d = cam_mount_bolt + 0.3,
                            h = cam_plate_thick + 1, center = true);
        }

        // Tilt adjustment arc slot
        translate([0, 0, cam_plate_height * 0.55])
            rotate([0, 90, 0])
                rotate_extrude(angle = cam_tilt_max - cam_tilt_min)
                    translate([8, 0, 0])
                        circle(d = cam_mount_bolt + 0.3);
    }
}

// --- Camera Mount Assembly ---
module camera_mount_assembly() {
    // Left side plate
    translate([-(cam_mount_width/2 + cam_plate_thick/2),
               body_length/2 + 1, bottom_plate_thick])
        camera_side_plate();

    // Right side plate
    translate([(cam_mount_width/2 + cam_plate_thick/2),
               body_length/2 + 1, bottom_plate_thick])
        camera_side_plate();
}

// --- Standoffs ---
module standoffs() {
    color(color_standoff)
    for (pos = standoff_positions) {
        translate([pos[0], pos[1], bottom_plate_thick])
            difference() {
                cylinder(d = standoff_od, h = standoff_height);
                translate([0, 0, -0.5])
                    cylinder(d = standoff_id, h = standoff_height + 1);
            }
    }
}

// ==================== VISUALIZATION COMPONENTS ====================

// --- Motor (simplified iFlight XING 1404) ---
module motor_viz() {
    color(color_motor) {
        // Motor base/stator
        cylinder(d = 14, h = 4);
        // Motor bell
        translate([0, 0, 4])
            cylinder(d = 16, h = 6);
        // Shaft
        translate([0, 0, 10])
            cylinder(d = motor_shaft, h = 4);
    }
}

// --- Prop (3 inch, simplified) ---
module prop_viz() {
    color(color_prop)
    translate([0, 0, 14])
        cylinder(d = prop_diameter, h = 0.5);
}

// --- Walksnail Avatar GT Camera (simplified) ---
module camera_viz() {
    color(color_camera) {
        // Camera body
        translate([0, 0, 0])
            cube([cam_width, cam_depth - 8, cam_height], center = true);
        // Lens barrel
        translate([0, cam_depth/2 - 4, 0])
            rotate([90, 0, 0])
                cylinder(d = 14, h = 12, center = true);
        // Lens glass
        translate([0, cam_depth/2 + 1, 0])
            rotate([90, 0, 0])
                cylinder(d = 12, h = 2, center = true);
    }
}

// --- Walksnail Avatar GT VTX (simplified) ---
module vtx_viz() {
    color(color_vtx) {
        // PCB
        cube([vtx_width, vtx_height, 1.6], center = true);
        // Heatsink
        translate([0, 0, 2])
            cube([vtx_width - 4, vtx_height - 4, 2.5], center = true);
        // Antenna connector
        translate([0, -vtx_height/2, 0])
            rotate([90, 0, 0])
                cylinder(d = 6, h = 8);
    }
}

// --- Flight Controller (simplified) ---
module fc_viz(pattern_size) {
    color(color_fc) {
        board_size = pattern_size + 6;
        cube([board_size, board_size, 1.2], center = true);
        // Processor
        translate([0, 0, 1])
            cube([8, 8, 1.5], center = true);
        // Connectors
        translate([0, board_size/2 - 2, 1])
            cube([board_size - 4, 3, 3], center = true);
    }
}

// ==================== MAIN ASSEMBLY ====================

module full_assembly() {
    // Bottom Plate
    if (show_bottom_plate) bottom_plate();

    // Top Plate
    if (show_top_plate) top_plate();

    // Camera Mount
    if (show_camera_mount) camera_mount_assembly();

    // Standoffs
    if (show_standoffs) standoffs();

    // Motors
    if (show_motors) {
        for (pos = motor_positions) {
            translate([pos[0], pos[1], bottom_plate_thick])
                motor_viz();
        }
    }

    // Props (for clearance check)
    if (show_props) {
        for (pos = motor_positions) {
            translate([pos[0], pos[1], bottom_plate_thick])
                prop_viz();
        }
    }

    // Camera (at default tilt)
    if (show_camera) {
        translate([0, body_length/2 + 5,
                  bottom_plate_thick + cam_plate_height * 0.55])
            rotate([cam_tilt_default, 0, 0])
                camera_viz();
    }

    // VTX (mounted in stack)
    if (show_vtx) {
        translate([0, 0, bottom_plate_thick + standoff_height - 5])
            vtx_viz();
    }

    // Flight Controller (mounted in stack)
    if (show_fc) {
        translate([0, 0, bottom_plate_thick + 6])
            fc_viz(fc_20x20_pattern);
    }
}

// ==================== INDIVIDUAL PART EXPORTS ====================
// Uncomment ONE of these to export individual DXF/STL parts:

// -- For CNC cutting (2D DXF export) --
// projection() bottom_plate();
// projection() translate([0,0,-(bottom_plate_thick + standoff_height)]) top_plate();
// projection() rotate([0,90,0]) camera_side_plate();

// -- For 3D printing (if needed) --
// camera_side_plate();  // TPU camera mount option

// ==================== RENDER ====================

full_assembly();

// ==================== DIMENSIONAL ANNOTATIONS ====================
// (Visible in OpenSCAD preview)

module dimension_line(p1, p2, label) {
    color("red") {
        hull() {
            translate(p1) sphere(0.3);
            translate(p2) sphere(0.3);
        }
        translate((p1 + p2) / 2)
            text(label, size = 3, halign = "center");
    }
}

// Motor-to-motor dimensions
if (show_props) {
    // Front motor span
    dimension_line(
        [-front_motor_spread, front_motor_y, 20],
        [front_motor_spread, front_motor_y, 20],
        str(front_motor_spread * 2, "mm")
    );
}
