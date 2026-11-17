# The recognition model

## Version 1: Teachable Machine

- Trained with [Google Teachable Machine](https://teachablemachine.withgoogle.com/) (image project).
- Three classes: `chats` (cats), `chien` (dog), `rien` (nothing in front of the camera).
- Exported as **TensorFlow Lite, quantized**: `model.tflite` + `labels.txt`.
- Run on the Pi with `tensorflow.lite` (see [04-software.md](04-software.md)).

The very first plan was even more precise: one class per cat (cat 1, cat 2) plus the dog.
Version 1 grouped both cats into one class.

It worked as a proof of concept, but it needs a lot of photos of your own animals, taken by hand,
and every builder would have to do the same.

## Version 2 (in progress): a public dataset

To make the project easy to rebuild, the new model is trained on a **public cats/dogs dataset**
instead of hundreds of personal photos.

**Chosen dataset: Microsoft Cats vs Dogs** (the dataset of the Kaggle "Dogs vs. Cats" challenge)

- About 25,000 photos, zip of 787 MB.
- Download: <https://www.microsoft.com/en-US/download/details.aspx?id=54765>
- Once unzipped: a `PetImages` folder with `Cat/` and `Dog/` subfolders.
- Some files are broken and must be removed before training: `Cat/666.jpg` and `Dog/11702.jpg`
  are empty, and a few others cannot be read.
- Also available directly in TensorFlow Datasets as `cats_vs_dogs`:
  <https://www.tensorflow.org/datasets/catalog/cats_vs_dogs>

**Smaller alternative:** a sample of the same dataset on Zenodo, 1,000 training images
(500 cats, 500 dogs) and 400 test images, 32.6 MB: <https://zenodo.org/record/5226945>

**Training plan:** on a PC with an NVIDIA GPU, using transfer learning from a pretrained
lightweight network (MobileNet type), then export to TensorFlow Lite for the Pi.

## Known risks and open questions

- **Domain gap:** the public photos are taken by people, in daylight, well framed. The PawFeed camera
  sits low, close to the bowl, and is in black and white at night (infrared). The model must be
  tested on the real camera, day and night. If it struggles, a few photos from the PawFeed camera
  can be added to the training set.
- **The "nothing" class:** no public dataset contains pictures of an empty feeder. Two options are
  still open:
  1. Only two classes (cat / dog). When the confidence is low, the feeder treats it as "nothing"
     and does not dispense.
  2. Three classes, with a few photos of the empty bowl area taken once with the PawFeed camera.
- **Dataset license:** the license terms of the Microsoft dataset must be checked before publishing
  a trained model.
