# The PawFeed journey

This page tells the whole story of the project: each version, each prototype that did not make it,
and why things changed. It is written as a devlog, in the order things happened.

---

## 0. The problem

Two cats (Kait and Noisette) and one dog (Skiff). Skiff is small but very strong and very
motivated, and he always ends up eating the cats' kibble. The goal: a feeder that serves the cats **only**, by itself, with no human
around.

---

## 1. Identifying the animal: RFID first, then the camera

**First idea: RFID.** Identify each cat with an RFID tag or its microchip.

**Abandoned.** The project moved to full recognition with a camera and an AI model instead.

---

## 2. Version 1 on paper: plywood, Pi Zero and lots of sensors

The first complete design looked like this:

- **Structure:** thin plywood or plexiglass, cut by hand (no 3D printer at the time), on a wider,
  thicker base with anti-slip pads and corner brackets, because the dog hits hard.
  Overall size about 40 cm wide, 25 cm deep, 45 to 50 cm high.
- **Hopper:** a funnel with an opening of about 20 x 15 cm and a height of 25 cm, walls at
  45 to 60° so the kibble slides down on its own.
- **Dispensing:** at the bottom of the funnel, a tube of 3 to 3.5 cm diameter with an auger inside,
  turned by a 28BYJ-48 stepper motor. The kibble falls into a bowl underneath.
- **Brain:** a Raspberry Pi Zero 2 W.
- **Vision:** a NoIR camera module (no infrared filter) with two separate IR LEDs, so it works at
  night without visible light. A BH1750 light sensor would switch the IR LEDs on when it gets dark.
- **Recognition:** a small Teachable Machine model with three classes: cat 1, cat 2, dog. The motor
  only turns if one of the two cats is recognized with good confidence.
- **Portions:** a load cell under the bowl with an HX711 module, to weigh the kibble in real time
  and stop the motor at the right moment, so the bowl never overflows.
- **Electronics** in a small closed box, away from dust and food crumbs.

---

## 3. Finding a dispensing mechanism

Several mechanisms were tried before settling:

1. **Trapdoor** under the hopper: abandoned.
2. **Auger**, then a **rotating disc**: the disc was tried too, and abandoned.
3. **3D-printed auger**: this is the final choice.

---

## 4. The weight sensor: abandoned

The HX711 load cell was wired and tested for portion control. The calibration was never stable
enough to trust: the readings could not be relied on to stop the motor at the right time.
**The weight sensor was removed from the project.**

---

## 5. The real hardware

The final electronics changed from the paper design:

| Paper design | What is actually used |
|---|---|
| Raspberry Pi Zero 2 W | Raspberry Pi 4 (1 GB RAM), Raspberry Pi OS Lite 64-bit Bookworm, 64 GB microSD |
| NoIR camera + 2 separate IR LEDs + BH1750 | Arducam IR-CUT day/night camera (OV5647, 5 MP), which carries its own IR LEDs and light sensors on the board |
| 28BYJ-48 + ULN2003 | unchanged |

Everything is managed remotely over SSH: the Pi has no screen and no keyboard. Each part was tested
on its own before putting things together: first the camera, then the motor, then the web page.

**Camera:** working with `rpicam-still` and `rpicam-vid`. The older `raspistill` and
`libcamera-still` commands do not exist on this OS version.

**Motor:** the ULN2003 board is wired to GPIO 17, 18, 27 and 22, powered from the Pi's 5 V.
A small separate script was used to test the motor alone. See [02-hardware.md](02-hardware.md).

---

## 6. Software version 1

- **Model:** trained with Google Teachable Machine, three classes: `chats` (cats), `chien` (dog),
  `rien` (nothing). Exported as **TensorFlow Lite, quantized**.
- **Inference:** Python with `tensorflow.lite`. The lighter `tflite-runtime` package was tried first
  but does not work with the Python version shipped on Bookworm.
- **Main script `reco.py`:** takes a picture every 2 seconds, runs the model, keeps the result only
  if the confidence is above 70 %, and serves a web page that turns green, red, gray or orange.
- Separate small scripts to test the motor alone and to test triggering it from the web page.

This version proved the idea: the Pi can see and classify in real time. The script is kept in
[legacy/reco_v1.py](../legacy/reco_v1.py) and explained in [04-software.md](04-software.md).
Note that this saved version only does recognition and the web page: the motor code lived in the
separate test scripts.

---

## 7. From "borrowing designs" to a custom printed structure

**Plan A: print at a FabLab.** With no printer at home, the plan was to print the parts at a local
FabLab, which has a Creality K2 Plus (350 x 350 x 350 mm) and laser cutters. The idea was to start
from existing open designs:

- Cat Feeder by quentin_orhant on Thingiverse (thing:7327686)
- Pet-feeder by Dagoma on Wikifab

and to adapt them: replace the NEMA17 motor mount with a 28BYJ-48 mount found on Printables, and use
a piece of **bicycle inner tube** as a flexible coupling between the motor shaft and the printed
auger shaft.

**Plan B (what happened): a printer at home.** An Elegoo Centauri Carbon 2 Combo arrived, with PLA
in white, black and blue, and PETG in black. That changed everything: instead of adapting other
designs, the whole structure was designed from scratch as one **parametric OpenSCAD file**
([cad/pawfeed_structure.scad](../cad/pawfeed_structure.scad)), sized to fit this printer
(every part fits in 250 mm and prints in under 8 hours).

**First printed prototype.** A first auger and its tube were printed: auger 34 mm diameter,
25 mm pitch, 6 mm core, with a hub that fits straight onto the 28BYJ-48 shaft (5.15 mm bore with
flats 3.15 mm apart, 6.5 mm deep) and a cap with a guide pin. The motor mount and the hub of this
prototype work, so their dimensions are kept **exactly** in the new design. The direct D-shaped hub
also made the inner-tube coupling unnecessary.

**What the prototype taught:**

- Passages were too small for 15 mm kibble. The new auger is the prototype scaled by **x1.35**:
  46 mm thread diameter, 34 mm pitch, 10 mm core, in a 50 mm tube. Inlet 45 x 40 mm,
  outlet 30 x 40 mm (prototype: 22 mm and 14 x 30 mm). Scaling more would have increased the
  lever arm and the load on the small motor.
- The cap was held by one radial M3 screw, which pulls across the print layers. The new cap is
  solid, with a 5 mm flange and a 14 mm spigot (prototype: 3 mm and 6.2 mm), and is held by two
  axial M3 x 16 screws into captive nuts, so the flange works flat, along the layers.
- The new helix is mirrored compared with the prototype, so the motor keeps the same rotation
  direction. This was deduced from the inlet and outlet positions of the prototype, not tested yet.

**The new structure** (details in [03-mechanical.md](03-mechanical.md)), from bottom to top:

1. A base filled with 2 to 2.4 kg of dry sand, so the dog cannot knock the feeder over.
2. A closed electronics box (Pi 4 + ULN2003), with only the USB-C cable reachable from outside.
3. A body holding the auger block and the motor.
4. A shell around the hopper, which also carries the tilting camera head.
5. A removable PETG hopper (washable), with a deflector inside, and a clip-on lid.
6. A removable ramp that drops the kibble into a bowl held by a ring in a front tray.

Small **test parts** come first, to check fits before printing big parts: motor hub, nut slots,
cap fit, and camera front plate. A first camera plate test showed the hole positions were off,
so the camera dimensions were measured again from a photo of the board.

---

## 8. Restart for Hack Club Forge

In November 2026 the project was restarted cleanly, to be shared on Hack Club Forge and to be
easy for anyone to rebuild:

- **New repository** (this one), fully documented.
- **New AI model, trained on a public dataset** instead of hundreds of photos of our own cats:
  the Cats vs Dogs dataset (about 25,000 images). See [05-ai-model.md](05-ai-model.md).
- **New software** that will combine recognition and motor control in one program.
- **No weight sensor.**

Target: finished before Christmas 2026, so that everyone can build their own.
