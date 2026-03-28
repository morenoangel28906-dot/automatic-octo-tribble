// ============================================================
//  NEXUS 3 — STL Export (Print Orientation)
// ============================================================
//  Print settings:
//    Material  : PETG-CF or PA-CF
//    Nozzle    : 0.4 mm
//    Layer     : 0.2 mm
//    Walls     : 3
//    Infill    : 0% (the frame is hollow by design)
//    Supports  : Tree supports, touching build plate only
//    Orientation: Motor pylons DOWN on build plate
//
//  Export: Render (F6) → File → Export as STL
// ============================================================

// Load the frame (disable all viz)
show_frame      = true;
show_motors     = false;
show_camera     = false;
show_vtx        = false;
show_fc         = false;
show_battery    = false;
show_props      = false;
show_section    = false;

include <nexus3_frame.scad>;

// Flip frame: motor pylons face DOWN for best print orientation
// This puts the flat motor mounts on the build plate and
// the camera nacelle printing upward (better bridging).
translate([0, 0, spine_h/2 + mtr_pylon_h])
    rotate([180, 0, 0])
        nexus3_frame();
