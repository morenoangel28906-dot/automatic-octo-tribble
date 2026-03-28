// ============================================================
// PHANTOM 3 - Top Plate CNC Cutting Template
// Material: 2.0mm Carbon Fiber Sheet
// Export as DXF: File > Export > .dxf
// ============================================================

include <aether3_frame.scad>;

// Override visualization flags
show_bottom_plate   = false;
show_top_plate      = false;
show_camera_mount   = false;
show_motors         = false;
show_camera         = false;
show_vtx            = false;
show_fc             = false;
show_standoffs      = false;
show_props          = false;

// 2D projection for CNC cutting
projection(cut = false)
    translate([0, 0, -(bottom_plate_thick + standoff_height)])
        top_plate();
