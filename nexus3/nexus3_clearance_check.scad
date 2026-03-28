// ============================================================
//  NEXUS 3 — Prop Clearance Verification
// ============================================================
//  Open this file to visually verify all prop discs clear
//  each other and the frame body. Red overlap = problem.
// ============================================================

show_frame      = true;
show_motors     = true;
show_camera     = false;
show_vtx        = false;
show_fc         = false;
show_battery    = false;
show_props      = true;     // ENABLED
show_section    = false;

include <nexus3_frame.scad>;

full_assembly();

// Annotation: calculated clearances
echo("=== PROP CLEARANCE CHECK ===");
echo(str("Front motor span: ", fm_spread * 2, " mm"));
echo(str("Rear motor span:  ", rm_spread * 2, " mm"));
echo(str("Prop diameter:    ", prop_d, " mm"));

// Front L-R clearance
fl_fr_dist = fm_spread * 2;
echo(str("Front L↔R clearance: ", fl_fr_dist - prop_d, " mm"));

// Rear L-R clearance
rl_rr_dist = rm_spread * 2;
echo(str("Rear L↔R clearance:  ", rl_rr_dist - prop_d, " mm"));

// Front-Rear diagonal (FL-RL)
fl_rl = sqrt(pow(fm_spread - rm_spread, 2) + pow(fm_y - rm_y, 2));
echo(str("FL↔RL diagonal:      ", fl_rl, " mm"));
echo(str("FL↔RL clearance:     ", fl_rl - prop_d, " mm"));

// Front-Rear diagonal (FR-RR)
fr_rr = sqrt(pow(fm_spread - rm_spread, 2) + pow(fm_y - rm_y, 2));
echo(str("FR↔RR clearance:     ", fr_rr - prop_d, " mm"));

// Front-Rear cross (FL-RR) — widest, always safe
fl_rr = sqrt(pow(fm_spread + rm_spread, 2) + pow(fm_y - rm_y, 2));
echo(str("FL↔RR cross:         ", fl_rr - prop_d, " mm (cross-diag)"));
