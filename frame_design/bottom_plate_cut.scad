// ============================================================
// PHANTOM 3 - Bottom Plate CNC Cutting Template
// Material: 2.5mm Carbon Fiber Sheet
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
    bottom_plate();
