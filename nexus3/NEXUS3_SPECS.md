# NEXUS 3 — Organic Unibody 3-Inch FPV Frame

> **A topology-inspired, single-piece 3D-printed micro drone frame.**
> Never-before-seen Y-split organic arms with airfoil cross-sections
> on a 3-inch platform.

---

## What Makes This Different

| Innovation | Description |
|---|---|
| **Y-Split Arms** | Each arm forks into two branches near the motor — distributes vibration, adds torsional stiffness, looks unlike any existing frame |
| **Airfoil Cross-Section Arms** | Arms transition from deep at the root to thin at the tip, like a wing — reduces drag at speed |
| **Organic Unibody** | Entire frame is one 3D-printed piece (PETG-CF). Zero frame hardware. Inspired by Aether 4 philosophy |
| **Integrated Camera Nacelle** | Camera housing with built-in tilt detents (10°-55°, every 5°) — no side plates, no bolts for tilt |
| **Spine & Rib Architecture** | Central hollow spine carries all loads; material exists only where stress demands it |
| **Snap Battery Cradle** | Printed retaining lips on the belly — no Velcro pad needed |

---

## Frame Specifications

| Spec | Value |
|---|---|
| Type | 3D-Printed Unibody (single piece) |
| Layout | Dead Cat (front wider than rear) |
| Prop Size | 3 inch (76.2 mm) |
| Front Motor Span | 132 mm (center-to-center) |
| Rear Motor Span | 112 mm (center-to-center) |
| Front-to-Rear | 116 mm |
| Spine Dimensions | 38 x 56 x 24 mm (W x L x H) |
| Stack Space | 22 mm internal height |
| Wall Thickness | 1.2 mm (3 perimeters @ 0.4mm nozzle) |
| Material | PETG-CF or PA-CF |
| Estimated Weight | 28-35 g (depends on material and settings) |

---

## Component Compatibility

### Camera: Walksnail Avatar GT

| Spec | Value |
|---|---|
| Camera Module | 19 x 19 x 24 mm, 9.5 g |
| Lens | M12, 2.1mm, F1.6, 160° FOV |
| Sensor | 1/1.8" Sony Starvis II, 8MP |
| Mount Type | Integrated nacelle with detented tilt |
| Tilt Range | 10° to 55° (detents every 5°) |
| Cable | 140mm coaxial to VTX |

### VTX: Walksnail Avatar GT

| Spec | Value |
|---|---|
| Board Size | 34 x 34 mm |
| Mounting | 25.5 x 25.5 mm AND 20 x 20 mm (M2) |
| Weight | 41.6 g (with antennas) |
| Power | 11.1V - 25.2V (3S-6S) |
| Antenna | 2x u.FL/IPEX connectors |
| Note | Only 25.5 pattern passes screws through board |

### Flight Controller Option 1: HAKRC F7220 40A AIO (20x20)

| Spec | Value |
|---|---|
| Mounting | 20 x 20 mm, M2 |
| Board | 40 x 30 mm |
| MCU | STM32F722RET6 |
| Gyro | ICM42688-P |
| ESC | BLHeli_32, 40A / 50A burst |
| BEC | 5V/3A + 10V/2.5A |
| Voltage | 2-6S |
| UARTs | 5 |
| Weight | 10 g |
| PCB | 8-layer, 2oz copper |

### Flight Controller Option 2: GEPRC TAKER G4 35A AIO (25.5x25.5)

| Spec | Value |
|---|---|
| Mounting | 25.5 x 25.5 mm, phi 3.05 mm holes |
| Board | 33.4 x 34.4 mm |
| MCU | STM32G473CEU6 |
| Gyro | ICM42688-P |
| ESC | 35A / 45A burst |
| BEC | 5V/3A |
| Voltage | 2-4S |
| UARTs | 4 |
| USB | Type-C |
| Weight | 7.7 g |

### Motors: iFlight XING 1404

| Spec | Value |
|---|---|
| Stator | 14 x 4 mm |
| OD | 18.3 mm (X1404) / 19.9 mm (XING2) |
| Height | 12.5 mm (X1404) / 18.4 mm (XING2) |
| Mounting | 9 x 9 mm, M2 bolts |
| Shaft | 1.5 mm |
| Config | 9N12P |
| Weight | 8.5 g (X1404) / 9.1 g (XING2) |
| Recommended KV | 3800 (4S) / 4600 (6S) |
| Props | Gemfan 3016, HQ 3x1.5, Avan Mini 3 |

---

## Bill of Materials

### Printed Parts

| Part | Qty | Material | Notes |
|---|---|---|---|
| NEXUS 3 Frame | 1 | PETG-CF or PA-CF | Single unibody print |

### Electronics

| Part | Qty | Notes |
|---|---|---|
| Walksnail Avatar GT Camera | 1 | 19mm micro mount |
| Walksnail Avatar GT VTX | 1 | Mounts in stack |
| HAKRC F7220 40A AIO **or** GEPRC TAKER G4 35A | 1 | Choose your pattern |
| iFlight XING 1404 Motor | 4 | 3800KV (4S) recommended |

### Hardware (minimal — unibody advantage)

| Item | Qty | Spec |
|---|---|---|
| M2 x 5mm Socket Head | 16 | Motor mounting (4 per motor) |
| M2 x 6mm Socket Head | 4 | FC mounting |
| M2 Brass Inserts (heat-set) | 4 | FC mount points (press into print) |
| M2 x 4mm (included w/ VTX) | 4 | VTX mounting |
| Battery Strap | 1 | 10-12mm rubberized (backup) |
| XT30 Pigtail | 1 | Battery connector |

### Recommended Battery

| Spec | Value |
|---|---|
| Type | 3S or 4S LiPo |
| Capacity | 450-650 mAh |
| Size | ~55 x 22 x 16 mm (fits cradle) |
| Connector | XT30 |

---

## Estimated All-Up Weight (AUW)

| Component | Weight |
|---|---|
| Frame (PETG-CF) | ~32 g |
| Motors (x4) | 34 g |
| FC (HAKRC F7220) | 10 g |
| VTX (Avatar GT) | 41.6 g |
| Camera (Avatar GT) | 9.5 g |
| Battery (4S 550mah) | ~65 g |
| Hardware + wires | ~8 g |
| **Total** | **~200 g** |

> Note: The Avatar GT VTX is heavy (41.6g). For sub-200g builds,
> consider the Walksnail Avatar Mini VTX (8g) as an alternative,
> which shares the same camera connector.

---

## Print Guide

### Slicer Settings

| Setting | Value |
|---|---|
| **Material** | PETG-CF (Bambu, Polymaker) or PA-CF |
| **Nozzle** | 0.4 mm hardened steel (CF filament!) |
| **Layer Height** | 0.2 mm |
| **Walls/Perimeters** | 3 |
| **Top/Bottom Layers** | 4 |
| **Infill** | 0% (frame is hollow by design) |
| **Supports** | Tree, touching build plate only |
| **Support Interface** | Yes, 2 layers, 0.2mm gap |
| **Print Speed** | 60-80 mm/s (slower = stronger layer adhesion) |
| **Bed Temp** | 80°C (PETG-CF) / 100°C (PA-CF) |
| **Nozzle Temp** | 260°C (PETG-CF) / 280°C (PA-CF) |
| **Cooling** | 30-50% (less cooling = stronger bonds) |

### Print Orientation

**Motor pylons face DOWN on the build plate.**

Use `nexus3_export_stl.scad` — it automatically flips the frame so:
- Motor pylon flat faces sit on the build plate (best adhesion)
- Camera nacelle prints upward (good bridging over the lens window)
- Arms grow upward from the pylons (gravity assists layer stacking)
- Spine prints last (top) with good structural integrity

### Post-Processing

1. Remove tree supports carefully (needle-nose pliers)
2. Press M2 brass heat-set inserts into FC mount holes (soldering iron, 220°C)
3. Test-fit camera in nacelle — should slide in snugly
4. Check motor bolt holes with M2 bolts — ream if tight

---

## Assembly Guide

### Order of Assembly

1. **Press heat-set inserts** into the 4 FC mounting holes on the spine floor
2. **Install motors** — 4x iFlight XING 1404, M2x5mm bolts through pylons
3. **Mount FC** — bolt to standoff posts with M2x6mm
4. **Connect motor wires** — solder to FC ESC pads
5. **Mount VTX** — stack above FC on the 25.5x25.5 pattern (or 20x20)
6. **Connect VTX** — power cable + coax from camera
7. **Install camera** — slide into nacelle, set tilt angle (detents click in)
8. **Route antenna** — through rear antenna tube
9. **Install battery** — slide into belly cradle, secure with strap
10. **Bind & configure** — Betaflight/iNav setup

### Stack Layout (Bottom to Top)

```
┌─────────────────┐  ← Top of spine (ventilation slots)
│  Walksnail VTX   │  ← 34x34mm board
│  ┌─────────────┐ │
│  │  FC (AIO)   │ │  ← 20x20 or 25.5x25.5
│  └─────────────┘ │
│   Standoff posts  │  ← 3mm printed posts
│ ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ │  ← Spine floor (2.5mm)
└─────────────────┘
  ┌─────────────┐    ← Battery cradle
  │   Battery    │
  └─────────────┘
```

---

## File Structure

```
nexus3/
├── nexus3_frame.scad           # Main parametric design (full assembly)
├── nexus3_export_stl.scad      # Print-oriented STL export
├── nexus3_clearance_check.scad # Prop clearance verification
└── NEXUS3_SPECS.md             # This file
```

### How to Use

1. **Preview assembly**: Open `nexus3_frame.scad` in OpenSCAD → F5
2. **Check clearance**: Open `nexus3_clearance_check.scad` → F5 (check console for measurements)
3. **Export for printing**: Open `nexus3_export_stl.scad` → F6 (Render) → File → Export as STL
4. **Customize**: Edit parameters at top of `nexus3_frame.scad` (all dimensions are variables)

### Customization Examples

```scad
// Wider front stance (more stability)
fm_spread = 72;

// Tighter rear (more agility)
rm_spread = 52;

// Thicker walls for durability
wall_lines = 4;  // → 1.6mm walls

// Taller spine for bigger VTX stack
spine_h = 28;
```

---

## Design Credits

Organic unibody philosophy inspired by the BM Aether 4 (Dr. J. Ma).
NEXUS 3 is an original design — all geometry, architecture, and
innovations (Y-split arms, airfoil sections, integrated nacelle)
are new to this project.
