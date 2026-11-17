# PawFeed - recognition script, version 1 (kept for reference, being rewritten)
# Needs model.tflite and labels.txt (Teachable Machine export) in the same folder.
# This version does recognition + web page only; motor control was tested in a separate script.
import time
import threading
import numpy as np
from PIL import Image
from picamera2 import Picamera2
import tensorflow.lite as tflite
from flask import Flask

# --- Chargement du modèle et des labels ---
interpreter = tflite.Interpreter(model_path="model.tflite")
interpreter.allocate_tensors()
input_details = interpreter.get_input_details()
output_details = interpreter.get_output_details()

with open("labels.txt", "r") as f:
    labels = [line.strip().split(" ", 1)[-1] for line in f.readlines()]

taille_entree = input_details[0]['shape'][1]

# --- Initialisation caméra ---
picam = Picamera2()
config = picam.create_still_configuration(main={"size": (640, 480)})
picam.configure(config)
picam.start()
time.sleep(2)

SEUIL_CONFIANCE = 0.70

# --- État partagé entre la détection et la page web ---
etat = {"label": "démarrage...", "confiance": 0, "heure": ""}

def predire():
    frame = picam.capture_array()
    img = Image.fromarray(frame).convert("RGB").resize((taille_entree, taille_entree))
    img_array = np.expand_dims(np.array(img, dtype=np.uint8), axis=0)
    interpreter.set_tensor(input_details[0]['index'], img_array)
    interpreter.invoke()
    sortie = interpreter.get_tensor(output_details[0]['index'])[0]
    idx = int(np.argmax(sortie))
    # sortie est déjà en pourcentage (0-255 ou 0-1 selon le modèle), on normalise proprement
    confiance = float(sortie[idx])
    if confiance > 1.0:
        confiance = confiance / 255.0
    return labels[idx], confiance

def boucle_detection():
    while True:
        try:
            label, confiance = predire()
            etat["heure"] = time.strftime("%H:%M:%S")
            pourcentage = round(confiance * 100)
            if pourcentage > 100:
                pourcentage = 100
            if confiance > SEUIL_CONFIANCE:
                etat["label"] = label
            else:
                etat["label"] = "incertain"
            etat["confiance"] = pourcentage
            print(f"[{etat['heure']}] -> {etat['label']} ({pourcentage}%)")
        except Exception as e:
            print(f"Erreur pendant la détection: {e}")
        time.sleep(2)

# --- Page web ---
app = Flask(__name__)

COULEURS = {"chats": "#2ecc71", "chien": "#e74c3c", "rien": "#7f8c8d", "incertain": "#f39c12", "démarrage...": "#7f8c8d"}

PAGE = """
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Mangeoire</title>
<style>
  body {{ margin:0; height:100vh; display:flex; flex-direction:column; align-items:center; justify-content:center;
         font-family:sans-serif; background:{couleur}; color:white; transition:background 0.3s; }}
  h1 {{ font-size:14vw; margin:0; text-transform:uppercase; }}
  p {{ font-size:5vw; opacity:0.85; margin-top:10px; }}
</style>
</head>
<body>
<h1>{label}</h1>
<p>{confiance}% de confiance &middot; {heure}</p>
<script>
setTimeout(function(){{ location.reload(); }}, 2000);
</script>
</body>
</html>
"""

@app.route("/")
def accueil():
    return PAGE.format(
        label=etat["label"],
        confiance=etat["confiance"],
        heure=etat["heure"],
        couleur=COULEURS.get(etat["label"], "#7f8c8d")
    )

if __name__ == "__main__":
    threading.Thread(target=boucle_detection, daemon=True).start()
    app.run(host="0.0.0.0", port=5000)
