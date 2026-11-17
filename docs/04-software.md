# Software

> The software is being rewritten. This page describes **version 1**, which ran on the Pi, and the
> pitfalls met while setting it up. The script is kept in [legacy/reco_v1.py](../legacy/reco_v1.py).

## System

- Raspberry Pi OS Lite 64-bit (Bookworm), no desktop.
- Managed only over SSH (no screen, no keyboard on the Pi).
- Python libraries: `tensorflow` (for `tensorflow.lite`), `picamera2`, `Pillow`, `numpy`, `Flask`,
  `RPi.GPIO` (motor).

## How version 1 works

`reco.py` expects `model.tflite` and `labels.txt` (Teachable Machine export) in the same folder.

1. **Loading:** opens the model with `tensorflow.lite.Interpreter`, reads the labels
   (Teachable Machine writes lines like `0 chats`, so only the part after the first space is kept),
   and reads the input size from the model.
2. **Camera:** Picamera2, still configuration at 640 x 480, 2 seconds of warm-up.
3. **Prediction:** every 2 seconds, a frame is captured, converted to RGB, resized to the model input
   and sent as `uint8`. The best class is kept. Because the model is quantized, scores can come out
   between 0 and 255 instead of 0 and 1: anything above 1 is divided by 255.
4. **Threshold:** if the confidence is above **0.70**, the label is used, otherwise the status is
   `incertain` (unsure).
5. **Shared state:** label, confidence and time are updated by a background thread.
6. **Web page:** Flask on port 5000. The page fills the screen with a color and reloads every
   2 seconds:

| Status | Color |
|---|---|
| `chats` (cats) | green |
| `chien` (dog) | red |
| `rien` (nothing) | gray |
| `incertain` (unsure) | orange |

Open it from a phone or PC on the same network: `http://<pi-address>:5000`.

**Limit of this version:** the saved `reco.py` does not drive the motor. Motor control was tested
in a separate script. The new version will put recognition and motor control in one program.

## Pitfalls met on the Raspberry Pi

| Problem | Solution |
|---|---|
| `tflite-runtime` is incompatible with the Python version on Bookworm (3.11+) | Use `import tensorflow.lite as tflite` from the full `tensorflow` package |
| `raspistill` and `libcamera-still` not found | They do not exist on this OS version: use `rpicam-still` and `rpicam-vid` |
| SSH refuses to connect: "REMOTE HOST IDENTIFICATION HAS CHANGED" | The host key stored on the PC no longer matches (typically after reinstalling the OS on the SD card). On the PC: `ssh-keygen -R <hostname>` then connect again and accept the new key |
| Confidence above 100 % with the quantized model | Divide scores above 1 by 255 |

## Planned for the new version

- Recognition and motor control in one program.
- Motor turns only when a cat is recognized with enough confidence.
- If the motor stalls, turn back a quarter turn, then try again (see the torque estimate in
  [03-mechanical.md](03-mechanical.md)).
- New model, see [05-ai-model.md](05-ai-model.md).
