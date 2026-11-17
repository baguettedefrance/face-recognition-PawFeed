# PawFeed

A 3D-printed auger feeder that uses a camera and an AI model to feed only the right pet:
it opens for the cats and stays closed for the dog.

> **Status (November 2026): work in progress.** The electronics and a first version of the
> recognition software have run on the Raspberry Pi. The 3D-printed structure is designed and
> being tested. The AI model and the software are being rebuilt from scratch. Target: finished
> before Christmas 2026.

## Why this project?

At home there are two cats, Kait and Noisette, and a dog, Skiff. Skiff is small but very strong,
and he always manages to eat the cats' food. PawFeed is a feeder that tells them apart on its own,
with no human involved.

## How it works

1. An infrared day/night camera watches the area in front of the feeder.
2. A Raspberry Pi 4 runs an image classification model (TensorFlow Lite) on each frame.
3. If a cat is recognized with enough confidence, a 28BYJ-48 stepper motor turns a 3D-printed
   auger that pushes kibble down a ramp into the bowl.
4. If it is the dog, or if the model is not sure, nothing comes out.
5. A small web page served by the Pi shows the live status (green = cat, red = dog,
   gray = nothing, orange = unsure).

## Hardware at a glance

| Part | Model |
|---|---|
| Computer | Raspberry Pi 4 (1 GB), Raspberry Pi OS Lite 64-bit (Bookworm), 64 GB microSD |
| Camera | Arducam IR-CUT day/night camera, OV5647 5 MP, with built-in IR LEDs |
| Motor | 28BYJ-48 stepper + ULN2003 driver board |
| Structure | 16 printed parts in PLA and PETG, sand-ballasted base |
| Printer used | Elegoo Centauri Carbon 2 Combo |

Full details: [docs/02-hardware.md](docs/02-hardware.md) and [docs/03-mechanical.md](docs/03-mechanical.md).

## Documentation

| File | What's inside |
|---|---|
| [docs/01-journey.md](docs/01-journey.md) | The full story: every version, every prototype, what was abandoned and why |
| [docs/02-hardware.md](docs/02-hardware.md) | Electronics, wiring, GPIO pinout |
| [docs/03-mechanical.md](docs/03-mechanical.md) | 3D-printed structure: parts, filaments, print order, hardware list, assembly, known limits |
| [docs/04-software.md](docs/04-software.md) | How the first software version works, and the Raspberry Pi pitfalls met |
| [docs/05-ai-model.md](docs/05-ai-model.md) | The recognition model: first version, new plan, dataset |
| [docs/06-problems-and-solutions.md](docs/06-problems-and-solutions.md) | Every problem met so far and how it was solved |
| [cad/pawfeed_structure.scad](cad/pawfeed_structure.scad) | Parametric OpenSCAD source of the whole structure |
| [legacy/reco_v1.py](legacy/reco_v1.py) | First recognition script, kept for reference |

## What was given up along the way

- **RFID tag** to identify the cats: replaced by the camera.
- **Trapdoor**, then a **rotating disc**: replaced by the auger.
- **Load cell (HX711)** to weigh portions: dropped, calibration was never reliable.
- **Hand-cut plywood / plexiglass body**: replaced by a fully 3D-printed structure.

The details are in [docs/01-journey.md](docs/01-journey.md).

## Roadmap

- [x] Camera working on the Pi (`rpicam-still`, `rpicam-vid`)
- [x] Stepper motor wired and tested on its own
- [x] First recognition script with live web page
- [x] First printed auger prototype
- [x] Full parametric 3D design of the structure
- [ ] Print and validate the test parts (motor hub, nut slots, cap fit, camera plate)
- [ ] Print and assemble the full structure
- [ ] Train the new AI model on a public cats/dogs dataset
- [ ] New software: recognition + motor control in one program
- [ ] Real-life test with the animals, day and night
- [ ] Build guide, bill of materials with prices, FAQ, photos

## Credits

- Cats vs Dogs dataset (Microsoft Research / Kaggle), planned for training
- Built for Hack Club Forge
- The English documentation was written with the help of Claude (Anthropic), because English is
  not my strong point.
