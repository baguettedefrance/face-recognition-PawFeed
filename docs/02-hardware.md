# Hardware and wiring

## Electronics

| Part | Details |
|---|---|
| Raspberry Pi 4 | 1 GB RAM |
| microSD card | 64 GB, Raspberry Pi OS Lite 64-bit (Bookworm), no desktop |
| Camera | Arducam IR-CUT day/night camera, OV5647 sensor, 5 MP. The board carries two IR LEDs (about 19 mm) and three small sensors |
| CSI ribbon cable | **50 cm**. The cable path inside the printed structure is about 32 cm, so 15 cm and 30 cm cables are too short |
| Stepper motor | 28BYJ-48 (5 V) |
| Motor driver | ULN2003 board |
| Power | USB-C supply for the Pi; the ULN2003 is powered from the Pi's 5 V pin |

Prices and purchase links: to be added in the bill of materials.

## Motor wiring (ULN2003 -> Raspberry Pi)

| ULN2003 pin | Raspberry Pi GPIO | Physical pin |
|---|---|---|
| IN1 | GPIO 17 | 11 |
| IN2 | GPIO 18 | 12 |
| IN3 | GPIO 27 | 13 |
| IN4 | GPIO 22 | 15 |
| + (5 V) | 5 V | 2 |
| - (GND) | GND | 9 |

The motor plugs into the white 5-pin connector of the ULN2003 board.

## Camera

The camera connects to the Pi's CSI camera port with the ribbon cable. Test it from an SSH session:

```
rpicam-still -o test.jpg
rpicam-vid -t 10000 -o test.h264
```

On Raspberry Pi OS Bookworm, the old `raspistill` and `libcamera-still` commands are not available:
use `rpicam-still` and `rpicam-vid`.

## Where things go in the printed structure

- The Pi sits on four 5 mm standoffs in the electronics box, M2.5 x 6 screws. USB-C faces the
  rear cable niche, the microSD faces the nearby side wall.
- The ULN2003 is held by two M3 x 8 screws in two slots placed diagonally, which absorb about
  5 mm of difference in hole spacing (default spacing in the design: 30 x 27 mm, to check on
  your board).
- The motor cable goes through a hole in the floor of the body down to the ULN2003.
- The camera ribbon goes through a slot at the front of the electronics box, up through the body
  and the hopper shell, to the camera head.
- The USB-C cable comes out in a niche at a rear corner (on the right seen from the front),
  the only electrical part reachable from outside. A cable tie holds it.

Full assembly steps: [03-mechanical.md](03-mechanical.md).
