#!/bin/bash
# Version 2 : ville par défaut si aucun argument
ville=${1:-"Toulouse"}

# Date et heure (printf intégré à bash, date n'est pas autorisée)
printf -v jour '%(%Y-%m-%d)T' -1
printf -v heure '%(%H:%M)T' -1

# Fichier des données météo brutes (format texte de wttr.in)
donnees_meteoVille="meteo_ville.txt"
curl -s "https://wttr.in/${ville}?T" > "$donnees_meteoVille"

# Contrôle : fichier vide = échec de la requête
if [ ! -s "$donnees_meteoVille" ]; then
    echo "Erreur! Impossible de recuperer la meteo"
    exit 2
fi

# Toutes les températures du fichier, dans l'ordre
temps=$(grep -oE '[-+]?[0-9]+(\([-+]?[0-9]+\))? °C' "$donnees_meteoVille")

# 1re = température actuelle ; 7e = demain à midi
tempActuelle=$(echo "$temps" | head -1 | cut -d'(' -f1 | cut -d' ' -f1 | tr -d '+')
tempDemain=$(echo "$temps" | head -7 | tail -1 | cut -d'(' -f1 | cut -d' ' -f1 | tr -d '+')

if [ -z "$tempActuelle" ]; then
    exit 3
fi

if [ -z "$tempDemain" ]; then
    exit 4
fi

echo "${jour} - ${heure} - ${ville} : ${tempActuelle}°C - ${tempDemain}°C" >> meteo.txt
echo "Les données météorologiques de ${ville} ont été formatées et enregistrées dans meteo.txt."