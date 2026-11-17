# Problems met and solutions

Everything that went wrong or had to change, in one place.

## Concept

| Problem | What was done |
|---|---|
| The dog eats the cats' food | The whole project: a feeder that only serves the cats |
| First identification idea: RFID | Abandoned, switched to camera + AI recognition |
| Trapdoor mechanism | Abandoned |
| Rotating disc mechanism | Abandoned, replaced by a 3D-printed auger |
| HX711 load cell: calibration never reliable, could not trust it to stop the motor | Weight sensor removed from the project |
| No 3D printer at first: plan to hand-cut plywood/plexiglass, then to print at a FabLab | Got an Elegoo Centauri Carbon 2 Combo; the whole structure is now 3D-printed and designed for it |

## Electronics and Raspberry Pi

| Problem | What was done |
|---|---|
| `tflite-runtime` is incompatible with Python 3.11+ on Bookworm | Use `tensorflow.lite` from the full `tensorflow` package |
| `raspistill` / `libcamera-still` missing | Use `rpicam-still` / `rpicam-vid` |
| SSH warning "REMOTE HOST IDENTIFICATION HAS CHANGED" | `ssh-keygen -R <hostname>`, reconnect, accept the new key |
| Quantized model returns scores from 0 to 255, so confidence showed above 100 % | Scores above 1 are divided by 255 |
| CSI ribbon too short for the path inside the structure (about 32 cm) | Use a 50 cm ribbon |
| The ULN2003 board hole spacing is not certain | Two diagonal slots instead of holes, absorbing about +/- 5 mm |

## Mechanics

| Problem | What was done |
|---|---|
| Connecting the round printed auger to the motor shaft (plan: bicycle inner tube as a flexible coupling) | The auger hub fits directly on the 28BYJ-48 D-shaped shaft (5.15 mm bore, flats 3.15 mm apart); measured on the prototype and kept identical |
| Prototype passages too small for 15 mm kibble | Auger scaled x1.35 (46 mm, pitch 34 mm), all passages at least 30 mm |
| Prototype cap held by one radial screw, pulling across the print layers | Solid cap with two axial M3 screws and captive nuts |
| The new helix had to be mirrored, which could reverse the feed direction | Helix mirrored so the motor keeps the same direction (to be confirmed by testing; otherwise reverse it in software) |
| The dog hits and pushes the feeder | Base filled with 2 to 2.4 kg of sand, rubber pads; the feeder weighs about 5.5 kg full |
| Kibble could jam under the hopper and overload the small motor | A deflector inside the hopper limits the load on the auger; estimated torque margin about x1.9. Planned: reverse a quarter turn if the motor stalls |
| PLA does not handle warm water well | Everything that touches food (hopper, auger, block, cap, ramp, deflector) is PETG and can be washed |
| Camera board dimensions uncertain; a first test plate did not fit | Dimensions measured again from a photo; a thin test plate is printed before the final front plate |
| Unknown fits (tight / sliding clearances, nut slots, hub) | Small test parts printed before the big parts |
| Hopper corners only at 42° | Known limit: a few kibbles may stay when the hopper is almost empty |
| Ramp and hopper are held without screws | Known limit: a catch will be added if the dog pulls the ramp out |

## AI model

| Problem | What was done |
|---|---|
| Training on your own pets means taking many photos by hand, for every builder | New model trained on the public Cats vs Dogs dataset |
| Some images of the dataset are corrupted (`Cat/666.jpg`, `Dog/11702.jpg`, a few others) | Remove them before training |
| Public photos are in daylight, while the camera works in infrared at night | To test on the real camera; add a few PawFeed photos if needed |
| No public dataset has a "nothing" class | Open choice: two classes + confidence threshold, or three classes with a few photos of the empty bowl |
