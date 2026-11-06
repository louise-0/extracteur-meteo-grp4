#!/bin/bash

# Attribution par defaut de la ville de Toulouse
ville=${1:-"Toulouse"}

# Selectionne la date et heure actuelle
date=$(date  +"%Y-%m-%d %H:%M:%S")

# Cree un fichier pour les donnees meteorologiques de la ville choisie
donnees_meteoVille="meteo_ville.txt"
curl -s "https://wttr.in/${ville}?T" >"$donnees_meteoVille"

if [ "$donnees_meteoVille" = "" ];
then
    echo "Erreur! Impossible de recuperer la meteo"
    exit 2
fi

# Récupère les températures dans le fichier des donnees meteos
val_temp=$(head -n 4 "$donnees_meteoVille" | tail -n 1 | cut -d'(' -f1 | tr ' ' '\n' | grep -v '^$' | tail -n 1 | tr -d '+')
tempActuelle="${val_temp}°C"

val_demain=$(grep "°C" "$donnees_meteoVille" | head -n 3 | tail -n 1 | cut -d'(' -f1 | tr ' ' '\n' | grep -v '^$' | tail -n 1 | tr -d '+')
tempDemain="${val_demain}°C"


if [ -z "$tempActuelle" ]; then
    tempActuelle="N/A"
    exit 3
fi

if [ -z "$tempDemain" ]; then
    tempDemain="N/A"
    exit 4
fi

jour=$(date +"%Y-%m-%d")
heure=$(date +"%H:%M")
echo "${jour} - ${heure} - ${ville} : - Température actuelle : ${tempActuelle}°C - Prévision lendemain :${tempDemain}°C" >> meteo.txt
echo "Les données météorologiques de ${ville} ont été formatées et enregistrées dans meteo.txt."
