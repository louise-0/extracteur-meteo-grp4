#!/bin/bash

# Date et heure 
printf -v jour '%(%Y-%m-%d)T' -1
printf -v heure '%(%H:%M)T' -1

# Option JSON 
format="txt"
if [ "$1" = "-j" ]; then
    format="json"
    shift
fi

# Ville par défaut
ville=${1:-"Toulouse"}

# Fichier des données météo brutes (format texte de wttr.in)
donnees_meteoVille="meteo_ville.txt"

# Récupération des données
if ! curl -fsS "https://wttr.in/${ville}?T" > "$donnees_meteoVille"; then
    echo "Erreur! Impossible de recuperer la meteo"
    exit 2
fi

# Toutes les températures du fichier, dans l'ordre
temps=$(grep -oE '[-+]?[0-9]+(\([-+]?[0-9]+\))? °C' "$donnees_meteoVille")

# 1re = température actuelle ; 7e = demain à midi
val_temp=$(echo "$temps" | head -1 | cut -d'(' -f1 | cut -d' ' -f1 | tr -d '+')
val_demain=$(echo "$temps" | head -7 | tail -1 | cut -d'(' -f1 | cut -d' ' -f1 | tr -d '+')

# Vérification des températures
if [ -z "$val_temp" ]; then
    echo "Erreur : temperature actuelle introuvable."
    exit 3
fi

if [ -z "$val_demain" ]; then
    echo "Erreur : prevision du lendemain introuvable."
    exit 4
fi

tempActuelle="${val_temp}°C"
tempDemain="${val_demain}°C"

# Choix du format d'enregistrement
if [ "$format" = "json" ]; then
    echo "{\"date\": \"${jour}\", \"heure\": \"${heure}\", \"ville\": \"${ville}\", \"temperature\": \"${tempActuelle}\", \"prevision\": \"${tempDemain}\"}" >> meteo.json
    echo "Les données météorologiques de ${ville} ont été enregistrées dans meteo.json."
else
    echo "${jour} - ${heure} - ${ville} : ${tempActuelle} - ${tempDemain}" >> meteo.txt
    echo "Les données météorologiques de ${ville} ont été formatées et enregistrées dans meteo.txt."
fi