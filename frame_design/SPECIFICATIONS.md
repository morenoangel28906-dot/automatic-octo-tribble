# PHANTOM 3 — 3-Inch Drone Frame

**Original design inspired by the Aether 4 philosophy: lightweight, durable, clean build.**

---

## Frame Overview

| Spec | Value |
|---|---|
| Frame Type | Dead Cat / Stretched X (configurable) |
| Prop Size | 3 inch (76.2 mm) |
| Wheelbase (diagonal) | ~170 mm (front), ~155 mm (rear) |
| Front Motor Span | 136 mm (center-to-center) |
| Rear Motor Span | 116 mm (center-to-center) |
| Front-to-Rear Distance | 120 mm |
| Bottom Plate Thickness | 2.5 mm carbon fiber |
| Top Plate Thickness | 2.0 mm carbon fiber |
| Arm Width (root) | 14 mm |
| Arm Width (tip) | 10 mm |
| Stack Height (standoff) | 22 mm |
| Estimated Frame Weight | ~38-42 g (carbon plates + hardware) |

---

## Component Compatibility

### Camera & VTX: Walksnail Avatar GT

| Component | Dimensions | Mounting |
|---|---|---|
| Avatar GT Camera | 19 x 19 x 22 mm | 19 mm side-mount, M2 bolts |
| Avatar GT VTX | 28 x 30 mm board | 25.5 x 25.5 mm M2 pattern |
| Camera Tilt Range | 15° to 55° | Adjustable via arc slots |
| Default Tilt | 30° | |
| Antenna Exit | Rear top plate | 6 mm pass-through hole |

### Flight Controllers (Dual Mounting Pattern)

The frame supports **both** common 3-inch FC form factors simultaneously:

#### 1. SpeedyBee F405 Mini AIO (20x20mm)
| Spec | Value |
|---|---|
| Mounting Pattern | 20 x 20 mm, M2 |
| Board Size | ~27 x 27 mm |
| Firmware | Betaflight / iNav |
| Built-in ESC | 4-in-1 35A (BLHeli_S) |
| Voltage | 2-6S LiPo |
| Features | OSD, Blackbox, Barometer |
| Why chosen | Most popular AIO for lightweight 3" builds, excellent community support |

#### 2. JHEMCU GHF405AIO (25.5x25.5mm)
| Spec | Value |
|---|---|
| Mounting Pattern | 25.5 x 25.5 mm, M2 |
| Board Size | ~32 x 32 mm |
| Firmware | Betaflight / iNav |
| Built-in ESC | 4-in-1 40A (BLHeli_32) |
| Voltage | 3-6S LiPo |
| Features | OSD, Blackbox, Dual UART, Current sensor |
| Why chosen | Popular full-size mini AIO, higher current rating for aggressive flying |

### Motors: iFlight XING 1404

| Spec | Value |
|---|---|
| Motor Size | 1404 (14 mm stator diameter, 04 mm stator height) |
| Motor OD | ~16 mm (bell) |
| Mounting Pattern | 12 x 12 mm, M2 bolts |
| Shaft Diameter | 1.5 mm |
| Prop Mount | T-mount / press-fit |
| Recommended KV | 3800 KV (4S) / 4600 KV (6S) |
| Weight | ~7.5 g per motor |
| Compatible Props | Gemfan 3016, HQ 3x1.5, Avan Mini 3 |

---

## Parts List (Bill of Materials)

### Carbon Fiber Parts (CNC Cut)

| Part | Qty | Material | Thickness | File |
|---|---|---|---|---|
| Bottom Plate | 1 | 3K Carbon Fiber | 2.5 mm | `bottom_plate_cut.scad` → export DXF |
| Top Plate | 1 | 3K Carbon Fiber | 2.0 mm | `top_plate_cut.scad` → export DXF |
| Camera Side Plate | 2 | 3K Carbon Fiber | 2.0 mm | `camera_sideplate_cut.scad` → export DXF |

### 3D Printed Parts (Optional)

| Part | Qty | Material | File |
|---|---|---|---|
| TPU Camera Mount | 1 | TPU 95A | `camera_mount_tpu.scad` → export STL |

### Hardware

| Item | Qty | Spec |
|---|---|---|
| Standoffs (M2) | 4 | 22 mm aluminum, M2 thread |
| M2 x 5mm Button Head | 8 | Standoff bolts (top + bottom) |
| M2 x 6mm Socket Head | 16 | Motor mounting bolts |
| M2 x 8mm Socket Head | 4 | Camera side plate bolts |
| M2 Lock Nuts | 4 | Camera pivot |
| M2 Nylon Washers | 8 | Camera anti-vibration |
| Battery Strap | 1 | 10-12 mm rubberized |
| XT30 Pigtail | 1 | For battery connection |

---

## Design Features

### Aether 4 Inspired Elements
- **Dead cat geometry**: Front motors wider than rear for clean camera FOV
- **Tapered arms**: Wide at root (14mm) for strength, narrow at tip (10mm) for weight savings
- **Unibody bottom plate**: Single-piece carbon construction for maximum rigidity
- **Clean stack routing**: Centered FC/VTX stack with wire routing channels

### Original Design Elements
- **Dual FC pattern**: Unique dual 20x20 + 25.5x25.5 support on a 3" frame
- **Integrated battery strap slots**: No external battery pad needed
- **Front camera extension**: Extended nose for camera protection and mounting rigidity
- **Rear zip-tie anchor points**: For antenna and receiver management
- **Weight reduction cutouts**: Strategic material removal in body for sub-42g frame weight

### Walksnail Avatar GT Integration
- Camera side plates with tilt arc slots (15°-55° adjustable)
- VTX mounts in the stack on the 25.5x25.5 pattern
- Rear antenna exit hole in top plate (6mm)
- Optional TPU camera mount for crash protection and vibration dampening

---

## Build Notes

### Assembly Order
1. Press M2 standoffs into bottom plate (or bolt from below)
2. Mount motors to arm tips with M2x6mm bolts
3. Install FC to bottom plate on chosen pattern (20x20 or 25.5x25.5)
4. Mount VTX above FC with M2 standoffs or soft-mount grommets
5. Install camera in side plates (or TPU mount), set tilt angle
6. Slide camera side plates into bottom plate slots
7. Bolt top plate onto standoffs
8. Route antenna through rear hole, secure with zip ties
9. Thread battery strap through side slots

### Recommended Stack Configuration (Bottom to Top)
1. Bottom plate (2.5mm CF)
2. FC + ESC AIO (SpeedyBee F405 Mini or JHEMCU GHF405AIO)
3. Walksnail Avatar GT VTX
4. Top plate (2.0mm CF)

### Prop Clearance
With the dead cat layout, minimum prop-to-prop clearance is **~5mm** between adjacent props. The stretched front motor spacing provides clean airflow for the front props during forward flight.

---

## File Structure

```
frame_design/
├── aether3_frame.scad          # Main parametric design (full assembly)
├── bottom_plate_cut.scad       # Bottom plate 2D export for CNC
├── top_plate_cut.scad          # Top plate 2D export for CNC
├── camera_sideplate_cut.scad   # Camera side plate 2D export for CNC
├── camera_mount_tpu.scad       # TPU camera mount for 3D printing
├── SPECIFICATIONS.md           # This file
└── exports/                    # Directory for exported DXF/STL files
```

## How to Export for Manufacturing

### CNC Cut Parts (Carbon Fiber)
1. Open `bottom_plate_cut.scad` in OpenSCAD
2. Render (F6)
3. File → Export → Export as DXF
4. Send DXF to CNC cutting service (recommended: 3K twill CF)
5. Repeat for `top_plate_cut.scad` and `camera_sideplate_cut.scad`

### 3D Printed Parts
1. Open `camera_mount_tpu.scad` in OpenSCAD
2. Render (F6)
3. File → Export → Export as STL
4. Print in TPU 95A at 0.2mm layer height, 3 perimeters, 20% infill

### Full Assembly Visualization
1. Open `aether3_frame.scad` in OpenSCAD
2. Preview (F5) to see full assembly with all components
3. Toggle `show_props = true` to verify propeller clearance
4. Adjust parameters at top of file to customize geometry
