// ============================================================
// PHANTOM 3 - TPU Camera Mount for Walksnail Avatar GT
// 3D Print Material: TPU 95A (flexible, vibration dampening)
// ============================================================
// This mount replaces the carbon fiber side plates with a
// single-piece TPU mount that protects the camera on crashes
// and dampens vibrations for cleaner video.
// ============================================================

// --- Camera Specs (Walksnail Avatar GT) ---
cam_w       = 19;     // mm - camera width
cam_h       = 19;     // mm - camera height
cam_d       = 22;     // mm - camera depth (with lens)
lens_od     = 14;     // mm - lens outer diameter
lens_depth  = 12;     // mm - lens protrusion

// --- Mount Parameters ---
wall        = 1.8;    // mm - wall thickness
mount_w     = cam_w + wall * 2 + 0.4;  // total width with clearance
mount_h     = cam_h + wall * 2 + 0.4;  // total height with clearance
base_w      = mount_w + 8;             // base plate width (wider for tabs)
base_d      = 10;                       // base plate depth
base_t      = 2.5;                      // base plate thickness

// --- Mounting ---
pivot_spacing   = 19;    // mm - side plate hole spacing
pivot_bolt      = 2.2;   // mm - M2 bolt clearance
tab_width       = 6;     // mm - mounting tab width
tab_height      = 22;    // mm - tab height for tilt range

// --- Tilt ---
tilt_angle      = 30;    // degrees - default camera tilt
tilt_slot_arc   = 40;    // degrees - total tilt range (15-55 deg)
tilt_slot_r     = 8;     // mm - radius of tilt arc slot

// --- Frame Interface ---
frame_slot_w    = 2.2;   // mm - slot width to interface with CF plates
frame_slot_d    = 4;     // mm - slot depth

$fn = 48;

// ==================== MODULES ====================

module camera_cradle() {
    difference() {
        union() {
            // Main camera housing
            translate([0, 0, 0])
                cube([mount_w, cam_d + wall, mount_h], center = true);

            // Side mounting tabs
            for (dx = [-1, 1]) {
                translate([dx * (mount_w/2 + tab_width/2 - 0.5), 0, 0])
                    cube([tab_width, wall * 3, tab_height], center = true);
            }
        }

        // Camera cavity
        translate([0, -wall/2, 0])
            cube([cam_w + 0.4, cam_d + 0.4, cam_h + 0.4], center = true);

        // Lens opening (front)
        translate([0, -(cam_d/2 + wall/2), 0])
            rotate([90, 0, 0])
                cylinder(d = lens_od + 2, h = wall * 3, center = true);

        // Top opening for cable/connector
        translate([0, 2, mount_h/2])
            cube([cam_w - 4, cam_d - 6, wall * 3], center = true);

        // Pivot bolt holes in tabs
        for (dx = [-1, 1]) {
            translate([dx * (mount_w/2 + tab_width/2 - 0.5), 0, 0])
                rotate([0, 90, 0])
                    cylinder(d = pivot_bolt, h = tab_width + 2, center = true);
        }

        // Tilt arc slots in tabs
        for (dx = [-1, 1]) {
            translate([dx * (mount_w/2 + tab_width/2 - 0.5), 0, 0])
                rotate([0, 90, 0])
                    for (a = [-tilt_slot_arc/2 : 2 : tilt_slot_arc/2]) {
                        rotate([0, 0, a])
                            translate([tilt_slot_r, 0, 0])
                                cylinder(d = pivot_bolt,
                                        h = tab_width + 2, center = true);
                    }
        }

        // Ventilation slots (sides)
        for (dx = [-1, 1]) {
            for (dz = [-4, 0, 4]) {
                translate([dx * mount_w/2, 0, dz])
                    cube([wall * 3, 4, 1.5], center = true);
            }
        }
    }
}

// ==================== RENDER ====================

// Oriented for printing (tabs facing up, lens hole forward)
rotate([0, 0, 0])
    camera_cradle();
