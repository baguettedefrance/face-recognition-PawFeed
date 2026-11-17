# 3D-printed structure

Assembled size: **230 x 345 x 343 mm** (width x depth from the wall x height).

Source file: [cad/pawfeed_structure.scad](../cad/pawfeed_structure.scad) (OpenSCAD). All the
parameters are at the top of the file. Set `part = "..."` to choose the part, and
`pose = "impression"` (lying on the print bed) or `pose = "assemblage"` (in place).
`part = "assemblage"` shows the whole feeder, `part = "eclate"` an exploded view.
The comments in the file are in French; the part names are listed below with their translation.

| Name in the file | Part |
|---|---|
| `socle_lest` | ballast base |
| `bouchon_lest` | ballast plug |
| `boitier_elec` | electronics box |
| `corps` | body (holds the auger block and motor) |
| `virole` | hopper shell (also carries the camera) |
| `tremie` | hopper |
| `couvercle` | lid |
| `deflecteur` | deflector (inside the hopper) |
| `bac_gamelle` | bowl tray |
| `rampe` | exit ramp |
| `bloc_vis` | auger block (tube + motor wall) |
| `vis` | auger |
| `capuchon` | auger end cap |
| `support_camera` | camera bracket |
| `capot_camera` | camera housing (tilting head) |
| `facade_camera` | camera front plate |
| `test_moyeu`, `test_ecrou`, `test_emboitement`, `test_camera` | test parts: motor hub, nut slots, cap fit, camera plate |

---

## 1. Check before printing

- **Camera:** dimensions taken from a photo of the board after a first test (IR LED 19 mm,
  three sensors 9 mm, hole spacing estimated at 26 mm, ribbon connector on top). They are estimated
  at +/- 1.5 mm: print `test_camera` again before `facade_camera`. The test plate is 1.2 mm thick
  on purpose; the final front plate is 2.4 mm.
- **ULN2003:** default hole spacing 30 x 27 mm (`uln_ex`, `uln_ey`). The two diagonal slots
  absorb about +/- 5 mm.
- **Bowl:** 165 mm recess (160 mm bowl + 5 mm clearance), 18 mm high holding ring.
  Parameters `gam_d`, `gam_jeu`, `gam_anneau_h`.
- **Rotation direction:** the helix is mirrored compared with the prototype so the motor keeps the
  same direction. This was deduced from the prototype's inlet and outlet positions, not tested:
  if the kibble moves backwards, reverse the direction in the script.
- **Clearances** (0.2 mm tight / 0.4 mm sliding) are to be validated with the test parts.

## 2. From the prototype to the new design

| | Prototype | New |
|---|---|---|
| Auger: thread diameter / pitch / core | 34 / 25 / 6 mm | 46 / 34 / 10 mm (x1.35) |
| Thread | 2.25 mm at the edge, 45° cone underneath | 2.5 mm at the edge, same cone (20 mm root) |
| Radial clearance auger / tube | 2 mm | 2 mm (50 mm tube) |
| Hub 15 mm, bore 5.15 x 3.15 mm, 6.5 mm deep | — | **identical** |
| Motor mount (6 mm wall, 9.4 mm hole, 17 x 2 mm counterbore, 2 x 2.7 mm holes 35 mm apart, 8 mm offset) | — | **identical** |
| Pin 6 x 6.5 mm in a 6.6 mm bearing | — | identical |
| Cap: flange / spigot | 3 / 6.2 mm | 5 / 14 mm, solid, conical fillet |
| Cap fixing | 1 radial M3 screw | 2 axial M3 x 16 screws + captive nuts |
| Inlet / outlet | 22 mm / 14 x 30 mm | 45 x 40 / 30 x 40 mm |

Design choices:

- **x1.35:** big enough for 15 mm kibble (all passages at least 30 mm), without increasing the
  lever arm too much.
- **Cap:** the screws are axial, not radial. The flange then works flat, along the print layers,
  instead of pulling across the layers of the spigot. It is solid (4 walls + infill) rather than
  ribbed: stronger, and it prints without bridges.
- **Ballast:** the base is an open tray, closed by the floor of the electronics box screwed on top.
  The rear plug is for topping up and emptying.

**Torque (estimate, not measured):** kibble friction in the tube about 30 g·cm; shearing under the
hopper, limited by the deflector, about 130 g·cm. Total about 160 g·cm for about 300 g·cm
available, a margin of about x1.9. It should work, but the code should reverse a quarter turn if
the motor stalls.

## 3. Parts, filaments and settings

Estimates for a 0.4 mm nozzle and 0.2 mm layers (+/- 20 %). Mechanical parts: 4 walls, 30 % infill.
Others: 3 walls, 15 %. **No part needs supports.**

| Part | Material | Color | Weight | Time | Orientation on the bed | Note |
|---|---|---|---|---|---|---|
| socle_lest | PLA | black | 295 g | 5.7 h | bottom down | |
| bac_gamelle | PLA | black | 201 g | 3.9 h | bottom down | |
| support_camera | PLA | black | 35 g | 0.8 h | back plate down | 4 walls |
| capot_camera | PLA | black | 34 g | 0.8 h | back down | 4 walls |
| facade_camera | PLA | black | 11 g | 0.4 h | front face down | after the test |
| bouchon_lest | PLA | black | 2 g | 0.2 h | flange down | |
| boitier_elec | PLA | blue | 237 g | 4.6 h | bottom down | |
| virole | PLA | blue | 286 g | 5.5 h | bottom down | |
| corps | PLA | white | 358 g | 6.9 h | bottom down | 13 mm bridges |
| couvercle | PLA | white | 159 g | 3.2 h | top down | 22 mm bridge (handle) |
| tremie | PETG | black | 276 g | 7.7 h | upside down, band down | |
| bloc_vis | PETG | black | 170 g | 4.8 h | motor wall down | 4 walls, 20 mm bridges |
| vis | PETG | black | 48 g | 1.5 h | hub down | 4 walls, **8 mm brim** |
| capuchon | PETG | black | 32 g | 1.0 h | flange down | 4 walls, 40 % |
| rampe | PETG | black | 20 g | 0.7 h | low end down | brim recommended |
| deflecteur | PETG | black | 9 g | 0.4 h | base down | |

Every part fits within 250 mm (largest: 230 x 180 mm, tallest: 165 mm) and prints in under 8 hours.

**Filament per spool**

| Spool | Used (tests included) | About left |
|---|---|---|
| PLA black | 587 g | 410 g |
| PLA blue | 523 g | 480 g |
| PLA white | 521 g | 480 g |
| PETG black | 585 g | 415 g |

Everything that touches the kibble is PETG, hopper included: it can be washed in warm water,
which PLA does not handle well. PLA is spread at about 520 to 580 g per color.

## 4. Screws and other hardware

| Item | Qty | Use |
|---|---|---|
| M3 x 16 screws | 10 | shell/body (4), auger block/rails (4), cap (2) |
| M3 x 12 screws | 11 | box/base (4), body/box (4), tray/base (3) |
| M3 x 10 screws | 4 | camera bracket (2), camera pivot (2) |
| M3 x 8 screws | 6 | camera front plate (4), ULN2003 (2), screwed into plastic |
| M3 x 6 screws | 2 | motor (as on the prototype) |
| M3 nuts | 25 | captive |
| M2.5 x 6 screws | 4 | Raspberry Pi, screwed into plastic |
| M2 x 5 screws | 4 | camera, screwed into plastic |
| Rubber pads, 10 mm | 6 | 4 under the base, 2 under the tray |
| CSI ribbon cable, 50 cm | 1 | the path is about 32 cm: 15 cm and 30 cm cables are too short |
| Dry sand or fine gravel | 2 to 2.4 kg | the base holds about 1.5 L |
| Cable tie, 2.5 mm | 1 | USB-C strain relief |

## 5. Print order

1. `test_moyeu` (PETG, motor hub test): push onto the motor shaft. It must fit like the
   prototype.
2. `test_ecrou`: nut slot, hexagonal pocket, M3 screw hole.
3. `test_emboitement` (PETG): 50 mm ring + plug, checks the cap fit.
4. `test_camera`: see section 1.
5. `vis`, `capuchon`, `bloc_vis`: dry run on the motor, then with kibble.
6. `corps`, `rampe`, `deflecteur`.
7. `socle_lest`, `boitier_elec`, `bac_gamelle`.
8. `virole`, `tremie`, `couvercle`.
9. Camera parts, `bouchon_lest`.

## 6. Assembly

1. Press the nuts into their pockets: 3 at the front of the base (from inside), 2 in the shell,
   2 in the camera housing. Slide the others into their slots when screwing.
2. Stick the 6 pads. Screw the bowl tray to the base (3 x M3 x 12).
3. Fill the base with sand up to 5 mm below the edge.
4. Place the electronics box on the 2 pins and screw it (4 x M3 x 12).
5. Mount the Pi (USB-C towards the rear niche, microSD towards the nearby side wall) and the
   ULN2003. Plug the ribbon into the Pi.
6. Place the body on the box, passing the ribbon through the slot in the floor (front, Pi side),
   then screw (4 x M3 x 12).
7. Screw the motor to the auger block, pass its cable through the hole in the floor of the body and
   plug it into the ULN2003.
8. Place the block in the body (nose to the front) and screw it to the rails (4 x M3 x 16).
9. Slide the auger onto the motor shaft, close with the cap (2 x M3 x 16).
10. Screw the camera bracket to the shell. Place the shell on the body while feeding the ribbon up,
    then screw the 4 corners (M3 x 16).
11. Mount the camera on the front plate, the plate on the housing, then the housing between the
    cheeks (2 x M3 x 10). Set the tilt between 15 and 35° and tighten.
12. Lower the hopper into the shell (its neck goes into the auger block inlet), put the deflector
    inside, clip the lid on.
13. Push the ramp into its two sockets under the nose. Plug in the USB-C and tie it to the
    cable holder in the niche.

Cleaning: the ramp, hopper, deflector and lid come off by hand; the cap and the auger with 2 screws.

## 7. Known limits

- **Hopper:** all four walls are at 51° or more, but the two rear corner edges are only at 42°.
  A few kibbles may stay there when the hopper is almost empty. Useful capacity about 2.7 L.
- **Dog pushing:** with 2.2 kg of ballast and 1 kg of kibble, the feeder weighs about 5.5 kg.
  It tips or slides from a side push of about 3 kg applied 20 cm high (calculated, not tested).
- **Hopper and ramp** hold without screws (weight and fit). If the dog manages to pull the ramp
  out, a catch will have to be added.
- **USB-C cable:** comes out in a niche at a rear corner (right side seen from the front), the only
  electrical part reachable from outside.
- **Bowl:** the ramp passes 5 mm above a 60 mm high bowl; the bowl comes out by tilting it forward.
- Checks done on the files: closed meshes, no interference between parts, overhangs at most 45°
  except small bridges, camera free to tilt from 15 to 35°.
