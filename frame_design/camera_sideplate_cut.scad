// ============================================================
// PHANTOM 3 - Camera Side Plate CNC Cutting Template
// Material: 2.0mm Carbon Fiber Sheet (or 3D print in TPU)
// Quantity: 2 needed
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

// 2D projection for CNC cutting (rotated flat)
projection(cut = false)
    rotate([0, 90, 0])
        camera_side_plate();
