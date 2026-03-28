// ============================================================
//  N E X U S   3  —  Organic Unibody 3-Inch FPV Frame
// ============================================================
//  A topology-inspired, 3D-printed unibody micro drone frame.
//
//  DESIGN PHILOSOPHY
//  -  Spine & Rib architecture: a hollow central spine carries
//     all loads; ribs branch to motor pylons.
//  -  Y-split arms: each arm forks near the motor for vibration
//     isolation and visual drama — never done on a 3" platform.
//  -  Airfoil-section arms: deep at root, thin at tip — aero
//     drag reduction with structural efficiency.
//  -  Integrated camera nacelle with detented tilt (no screws).
//  -  Snap-in battery cradle on the belly.
//  -  Prints as ONE piece, zero hardware for the frame itself.
//
//  COMPATIBILITY
//    Camera/VTX : Walksnail Avatar GT  (19x19x24mm / 34x34mm)
//    FC #1      : HAKRC F7220 40A AIO  (20x20 M2)
//    FC #2      : GEPRC TAKER G4 35A   (25.5x25.5 M2)
//    Motors     : iFlight XING 1404    (9x9 M2, 18.3mm OD)
//    Props      : 3-inch (76.2 mm)
//    Material   : PETG-CF / PA-CF (Bambu, Polymaker, etc.)
// ============================================================

// ===================== GLOBAL PARAMS ========================

// --- Print ---
nozzle          = 0.4;      // mm
wall_lines      = 3;        // perimeters
wall_t          = nozzle * wall_lines;  // 1.2 mm effective wall
layer_h         = 0.2;      // mm

// --- Prop & Motor Layout (Dead Cat) ---
prop_d          = 76.2;     // 3-inch prop diameter
prop_clear      = 5;        // mm min tip-to-tip clearance

// Motor positions [x, y] from frame center (dead cat: front wider)
fm_spread       = 66;       // front motor half-span
rm_spread       = 56;       // rear motor half-span
fm_y            = 60;       // front motors fwd of CG
rm_y            = -56;      // rear motors aft of CG

// --- Motor (iFlight XING 1404) ---
mtr_od          = 18.3;     // bell diameter
mtr_bolt_sp     = 9;        // 9x9 M2 pattern
mtr_bolt_d      = 2.2;      // M2 clearance
mtr_center_d    = 8;        // center wire hole
mtr_pylon_h     = 6;        // pylon height above arm

// --- Spine (central body) ---
spine_l         = 56;       // mm  length (front-back)
spine_w         = 38;       // mm  width  (fits 34mm VTX)
spine_h         = 24;       // mm  height (stack space)
spine_r         = 6;        // mm  corner radius
spine_wall      = wall_t;   // wall thickness

// --- FC/VTX Stack ---
fc20_sp         = 20;       // 20x20 pattern
fc25_sp         = 25.5;     // 25.5x25.5 pattern
fc_bolt_d       = 2.2;      // M2 clearance
fc_standoff_d   = 4.5;      // standoff OD (printed)
fc_floor_z      = 2.5;      // FC floor above belly

// --- Camera (Walksnail Avatar GT) ---
cam_w           = 19;       // width
cam_h           = 19;       // height
cam_d           = 24;       // depth (with lens)
cam_lens_d      = 14;       // lens OD
cam_mount_sp    = 19;       // side-hole spacing
cam_bolt_d      = 2.2;      // M2 clearance
cam_nacelle_wall= 1.6;      // nacelle wall
cam_tilt_min    = 10;       // degrees
cam_tilt_max    = 55;
cam_tilt_step   = 5;        // detent every 5°

// --- Walksnail Avatar GT VTX ---
vtx_w           = 34;
vtx_h           = 34;
vtx_thick       = 6;        // board + heatsink
vtx_ant_d       = 6.5;      // antenna connector hole

// --- Arm Geometry ---
arm_root_w      = 14;       // arm width at spine junction
arm_root_h      = 10;       // arm depth at spine (airfoil)
arm_mid_w       = 10;       // width at Y-split point
arm_mid_h       = 7;        // depth at Y-split
arm_tip_w       = 7;        // width at motor pylon
arm_tip_h       = 4;        // depth at motor pylon (thin)
arm_split_ratio = 0.6;      // split at 60% of arm length
arm_fork_angle  = 18;       // Y-fork half-angle (degrees)

// --- Battery Cradle ---
batt_l          = 55;       // typical 3S 450-550mah length
batt_w          = 22;       // width
batt_lip        = 2;        // retaining lip height
batt_strap_w    = 12;       // strap slot width

// --- Antenna ---
ant_tube_d      = 7;        // antenna tube OD
ant_tube_id     = 5.5;      // antenna tube ID
ant_tube_l      = 15;       // tube length

// --- Visualization ---
show_frame      = true;
show_motors     = true;
show_camera     = true;
show_vtx        = true;
show_fc         = true;
show_battery    = true;
show_props      = false;    // enable for clearance check
show_section    = false;    // cross-section view

$fn = 64;

// ===================== DERIVED ==============================

motor_pos = [
    [-fm_spread,  fm_y],    // FL
    [ fm_spread,  fm_y],    // FR
    [-rm_spread, rm_y],     // RL
    [ rm_spread, rm_y],     // RR
];

// Arm vectors from spine edge to motor
function arm_vec(i) =
    let(mx = motor_pos[i][0], my = motor_pos[i][1])
    let(sx = (mx > 0 ? 1 : -1) * spine_w/2,
        sy = clamp(my, -spine_l/2, spine_l/2))
    [mx - sx, my - sy];

function arm_len(i) = norm(arm_vec(i));
function arm_angle(i) = atan2(arm_vec(i)[1], arm_vec(i)[0]);
function arm_origin(i) =
    let(mx = motor_pos[i][0], my = motor_pos[i][1])
    [(mx > 0 ? 1 : -1) * spine_w/2,
     clamp(my, -spine_l/2 + 5, spine_l/2 - 5)];

function clamp(v, lo, hi) = min(max(v, lo), hi);

// ===================== MODULES ==============================

// ---- Rounded box (hollow) ----
module rbox(w, l, h, r, t) {
    difference() {
        // Outer shell
        hull() for (dx=[-1,1], dy=[-1,1])
            translate([dx*(w/2-r), dy*(l/2-r), 0])
                cylinder(r=r, h=h);
        // Inner cavity
        translate([0, 0, t])
        hull() for (dx=[-1,1], dy=[-1,1])
            translate([dx*(w/2-r-t), dy*(l/2-r-t), 0])
                cylinder(r=max(r-t, 0.5), h=h);
    }
}

// ---- Rounded box (solid) ----
module rbox_solid(w, l, h, r) {
    hull() for (dx=[-1,1], dy=[-1,1])
        translate([dx*(w/2-r), dy*(l/2-r), 0])
            cylinder(r=r, h=h);
}

// ---- Airfoil cross-section (2D) ----
//  w = chord, h = max thickness
module airfoil_2d(w, h) {
    scale([w, h])
    hull() {
        // Leading edge (rounded)
        translate([-0.4, 0]) circle(d=0.5);
        // Trailing edge (sharp)
        translate([0.45, 0]) scale([1, 0.3]) circle(d=0.2);
        // Upper camber
        translate([0, 0.15]) scale([0.7, 1]) circle(d=0.35);
        // Lower camber
        translate([0, -0.12]) scale([0.7, 1]) circle(d=0.3);
    }
}

// ---- Single organic arm with Y-split ----
module organic_arm(motor_xy, mirror_x=false) {
    org = arm_origin(0); // will be overridden per-call
    mx = motor_xy[0];
    my = motor_xy[1];

    // Compute arm direction
    sx = (mx > 0 ? 1 : -1) * spine_w/2;
    sy = clamp(my, -spine_l/2 + 8, spine_l/2 - 8);
    dx = mx - sx;
    dy = my - sy;
    length = sqrt(dx*dx + dy*dy);
    angle = atan2(dy, dx);

    split_l = length * arm_split_ratio;
    fork_l  = length * (1 - arm_split_ratio);

    translate([sx, sy, spine_h/2])
    rotate([0, 0, angle]) {

        // === Main arm trunk (root to split point) ===
        // Organic taper: sequence of hulled airfoil sections
        sections = 6;
        for (i = [0 : sections-1]) {
            t0 = i / sections;
            t1 = (i+1) / sections;
            p0 = t0 * split_l;
            p1 = t1 * split_l;
            w0 = arm_root_w * (1-t0) + arm_mid_w * t0;
            w1 = arm_root_w * (1-t1) + arm_mid_w * t1;
            h0 = arm_root_h * (1-t0) + arm_mid_h * t0;
            h1 = arm_root_h * (1-t1) + arm_mid_h * t1;

            hull() {
                translate([p0, 0, 0])
                    rotate([0, 90, 0])
                        linear_extrude(0.01)
                            airfoil_2d(h0, w0);
                translate([p1, 0, 0])
                    rotate([0, 90, 0])
                        linear_extrude(0.01)
                            airfoil_2d(h1, w1);
            }
        }

        // === Y-fork: two branches diverge ===
        for (branch = [-1, 1]) {
            fork_sections = 4;
            for (i = [0 : fork_sections-1]) {
                t0 = i / fork_sections;
                t1 = (i+1) / fork_sections;
                // Lateral offset increases along fork
                off0 = branch * sin(arm_fork_angle) * fork_l * t0;
                off1 = branch * sin(arm_fork_angle) * fork_l * t1;
                fwd0 = split_l + cos(arm_fork_angle) * fork_l * t0;
                fwd1 = split_l + cos(arm_fork_angle) * fork_l * t1;

                w0 = arm_mid_w * (1-t0) + arm_tip_w * t0;
                w1 = arm_mid_w * (1-t1) + arm_tip_w * t1;
                h0 = arm_mid_h * (1-t0) + arm_tip_h * t0;
                h1 = arm_mid_h * (1-t1) + arm_tip_h * t1;

                // Scale fork branches thinner (60% of main)
                sw0 = w0 * 0.6;
                sw1 = w1 * 0.6;
                sh0 = h0 * 0.7;
                sh1 = h1 * 0.7;

                hull() {
                    translate([fwd0, off0, 0])
                        rotate([0, 90, 0])
                            linear_extrude(0.01)
                                airfoil_2d(sh0, sw0);
                    translate([fwd1, off1, 0])
                        rotate([0, 90, 0])
                            linear_extrude(0.01)
                                airfoil_2d(sh1, sw1);
                }
            }
        }
    }
}

// ---- Motor pylon (raised cylindrical mount) ----
module motor_pylon(pos) {
    translate([pos[0], pos[1], spine_h/2]) {
        // Pylon riser
        difference() {
            union() {
                // Main pylon body
                cylinder(d=mtr_od + 4, h=mtr_pylon_h);
                // Flared base for strength
                cylinder(d1=mtr_od + 8, d2=mtr_od + 4, h=2);
            }
            // Motor center hole (wires)
            translate([0, 0, -1])
                cylinder(d=mtr_center_d, h=mtr_pylon_h + 2);
            // 9x9 M2 bolt holes
            for (dx=[-1,1], dy=[-1,1])
                translate([dx*mtr_bolt_sp/2, dy*mtr_bolt_sp/2, -1])
                    cylinder(d=mtr_bolt_d, h=mtr_pylon_h + 2);
        }
    }
}

// ---- Central Spine (hollow body) ----
module spine() {
    difference() {
        union() {
            // Main hollow spine
            translate([0, 0, 0])
                rbox(spine_w, spine_l, spine_h, spine_r, spine_wall);

            // Belly floor (FC mounting surface)
            translate([0, 0, 0])
                rbox_solid(spine_w - 2, spine_l - 4, fc_floor_z, spine_r - 1);

            // Top spine ridge (structural rib along centerline)
            translate([0, 0, spine_h - 1])
                rbox_solid(8, spine_l - 8, 1, 3);
        }

        // ---- Stack access window (both sides) ----
        for (dx=[-1, 1])
            translate([dx * spine_w/2, 0, spine_h * 0.35])
                rotate([0, 90, 0])
                    rbox_solid(spine_h * 0.45, spine_l * 0.5,
                              spine_wall + 2, 3);

        // ---- FC bolt holes (20x20 + 25.5x25.5) ----
        for (dx=[-1,1], dy=[-1,1]) {
            // 20x20
            translate([dx*fc20_sp/2, dy*fc20_sp/2, -1])
                cylinder(d=fc_bolt_d, h=fc_floor_z + 2);
            // 25.5x25.5
            translate([dx*fc25_sp/2, dy*fc25_sp/2, -1])
                cylinder(d=fc_bolt_d, h=fc_floor_z + 2);
        }

        // ---- Top VTX ventilation slots ----
        for (dy=[-10, 0, 10])
            translate([0, dy, spine_h - 0.5])
                cube([spine_w * 0.5, 3, 2], center=true);

        // ---- USB-C access port (side) ----
        translate([spine_w/2, -8, fc_floor_z + 3])
            rotate([0, 90, 0])
                rbox_solid(4, 10, spine_wall + 2, 1.5);

        // ---- Rear antenna exit ----
        translate([0, -spine_l/2, spine_h * 0.7])
            rotate([90, 0, 0])
                cylinder(d=vtx_ant_d, h=spine_wall + 2, center=true);

        // ---- Battery strap pass-throughs ----
        for (dy=[-8, 8])
            for (dx=[-1, 1])
                translate([dx * (spine_w/2), dy, 0])
                    cube([spine_wall + 2, batt_strap_w, batt_lip + 2],
                         center=true);

        // ---- Bottom weight-saving windows ----
        for (dy=[-12, 12])
            translate([0, dy, -0.5])
                rbox_solid(spine_w * 0.4, 8, spine_wall + 1, 2);
    }
}

// ---- Printed FC standoff posts ----
module fc_standoffs() {
    for (dx=[-1,1], dy=[-1,1]) {
        // 20x20 standoffs
        translate([dx*fc20_sp/2, dy*fc20_sp/2, fc_floor_z])
            difference() {
                cylinder(d=fc_standoff_d, h=3);
                translate([0,0,-0.5])
                    cylinder(d=fc_bolt_d, h=4);
            }
    }
}

// ---- Camera nacelle (integrated, with tilt detents) ----
module camera_nacelle() {
    nac_w = cam_w + cam_nacelle_wall * 2 + 1;
    nac_h = cam_h + cam_nacelle_wall * 2 + 1;
    nac_d = cam_d + 4;

    translate([0, spine_l/2 + nac_d/2 - 2, spine_h/2]) {
        difference() {
            union() {
                // Nacelle shell (organic shape)
                hull() {
                    // Back (joins spine)
                    translate([0, -nac_d/2, 0])
                        cube([nac_w, 2, nac_h], center=true);
                    // Front (tapered, aero)
                    translate([0, nac_d/2 - 2, 0])
                        scale([0.85, 1, 0.9])
                            cube([nac_w, 2, nac_h], center=true);
                }

                // Side tilt towers
                for (dx=[-1, 1])
                    translate([dx*(nac_w/2 + 1.5), -2, 0])
                        cylinder(d=6, h=nac_h * 0.5, center=true);
            }

            // Camera cavity
            translate([0, 0, 0])
                cube([cam_w + 0.6, cam_d + 0.6, cam_h + 0.6],
                     center=true);

            // Lens window (front)
            translate([0, nac_d/2, 0])
                rotate([90, 0, 0])
                    cylinder(d=cam_lens_d + 3, h=nac_d/2);

            // Top cable exit
            translate([0, -4, nac_h/2])
                cube([cam_w - 6, 8, cam_nacelle_wall + 2], center=true);

            // Tilt pivot holes (both sides)
            for (dx=[-1, 1])
                translate([dx*(nac_w/2 + 1.5), -2, 0])
                    rotate([0, 90, 0])
                        cylinder(d=cam_bolt_d, h=10, center=true);

            // Tilt arc detent slots (every 5 degrees)
            for (dx=[-1, 1])
                translate([dx*(nac_w/2 + 1.5), -2, 0])
                    for (a=[cam_tilt_min : cam_tilt_step : cam_tilt_max]) {
                        rotate([a - 30, 0, 0])
                            translate([0, 0, 6])
                                rotate([0, 90, 0])
                                    cylinder(d=1.5, h=10, center=true);
                    }

            // Side ventilation (cooling for camera sensor)
            for (dx=[-1,1], dz=[-3, 0, 3])
                translate([dx*nac_w/2, 0, dz])
                    cube([cam_nacelle_wall+2, 5, 1.2], center=true);
        }
    }
}

// ---- Rear antenna tube ----
module antenna_tube() {
    translate([0, -spine_l/2 - 2, spine_h * 0.7])
    rotate([90, 0, 0])
    difference() {
        // Outer tube
        cylinder(d=ant_tube_d, h=ant_tube_l);
        // Inner bore
        translate([0, 0, -1])
            cylinder(d=ant_tube_id, h=ant_tube_l + 2);
        // Side slot (for bending the antenna)
        translate([0, 0, ant_tube_l * 0.4])
            cube([1.5, ant_tube_d + 2, ant_tube_l], center=true);
    }
}

// ---- Battery cradle (belly) ----
module battery_cradle() {
    translate([0, 0, -0.01])
    difference() {
        union() {
            // Base rails
            for (dx=[-1, 1])
                translate([dx * (batt_w/2 + 1.5), 0, 0])
                    rbox_solid(4, batt_l, batt_lip + 1.5, 1);

            // Front/rear retaining lips
            for (dy=[-1, 1])
                translate([0, dy * (batt_l/2 - 2), 0])
                    rbox_solid(batt_w + 6, 5, batt_lip + 1.5, 1.5);
        }

        // Battery cavity
        translate([0, 0, 1.5])
            cube([batt_w + 0.5, batt_l + 0.5, batt_lip + 2],
                 center=true);
    }
}

// ===================== FULL FRAME ==========================

module nexus3_frame() {
    color([0.18, 0.18, 0.2]) {
        // Central spine
        spine();

        // FC standoffs
        fc_standoffs();

        // Four organic Y-split arms
        for (i = [0:3])
            organic_arm(motor_pos[i]);

        // Motor pylons
        for (pos = motor_pos)
            motor_pylon(pos);

        // Camera nacelle (front)
        camera_nacelle();

        // Antenna tube (rear)
        antenna_tube();

        // Battery cradle (belly)
        battery_cradle();
    }
}

// ===================== VISUALIZATION ========================

// --- Motor mock-up (iFlight XING 1404) ---
module viz_motor() {
    color([0.55, 0.55, 0.6]) {
        cylinder(d=14, h=4.5);          // stator
        translate([0,0,4.5])
            cylinder(d=mtr_od, h=8);    // bell
        translate([0,0,12.5])
            cylinder(d=1.5, h=2);       // shaft
    }
}

// --- Prop disc ---
module viz_prop() {
    color([0.3, 0.3, 0.35, 0.25])
        translate([0, 0, 15])
            cylinder(d=prop_d, h=0.5);
}

// --- Walksnail Avatar GT Camera ---
module viz_camera() {
    color([0.2, 0.2, 0.25]) {
        cube([cam_w, cam_d - 10, cam_h], center=true);
        translate([0, cam_d/2 - 5, 0])
            rotate([90,0,0])
                cylinder(d=cam_lens_d, h=12, center=true);
        translate([0, cam_d/2, 0])
            rotate([90,0,0])
                cylinder(d=12, h=2, center=true);
    }
}

// --- Walksnail Avatar GT VTX ---
module viz_vtx() {
    color([0.1, 0.45, 0.1, 0.7]) {
        cube([vtx_w, vtx_h, 1.6], center=true);
        translate([0, 0, 2])
            cube([vtx_w-4, vtx_h-4, 3], center=true);
    }
}

// --- Flight controller ---
module viz_fc() {
    color([0.12, 0.12, 0.55, 0.7]) {
        cube([27, 27, 1.2], center=true);
        translate([0, 0, 1])
            cube([8, 8, 1.5], center=true);
    }
}

// --- Battery ---
module viz_battery() {
    color([0.15, 0.15, 0.8, 0.5])
        cube([batt_w, batt_l, 16], center=true);
}

// ===================== ASSEMBLY ============================

module full_assembly() {
    if (show_frame)   nexus3_frame();

    if (show_motors)
        for (pos = motor_pos)
            translate([pos[0], pos[1], spine_h/2 + mtr_pylon_h])
                viz_motor();

    if (show_props)
        for (pos = motor_pos)
            translate([pos[0], pos[1], spine_h/2 + mtr_pylon_h])
                viz_prop();

    if (show_camera)
        translate([0, spine_l/2 + cam_d/2, spine_h/2])
            rotate([30, 0, 0])  // default tilt
                viz_camera();

    if (show_vtx)
        translate([0, 0, fc_floor_z + 10])
            viz_vtx();

    if (show_fc)
        translate([0, 0, fc_floor_z + 3])
            viz_fc();

    if (show_battery)
        translate([0, 0, -9])
            viz_battery();
}

// ===================== SECTION VIEW =========================

module section_view() {
    difference() {
        full_assembly();
        translate([0, 0, -50])
            cube([200, 200, 100]);
    }
}

// ===================== RENDER ===============================

if (show_section)
    section_view();
else
    full_assembly();
