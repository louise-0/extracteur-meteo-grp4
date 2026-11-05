#!/bin/bash

# Gestion de la ville 
ville=${1:-"Toulouse"}

donnees_meteoVille="meteo_ville.txt"

curl -s "https://wttr.in/${ville}?T" > "$donnees_meteoVille"

# Contrôle de la réussite de la requête
if [ ! -s "$donnees_meteoVille" ]; then
    echo "Erreur ! Impossible de récupérer la météo pour ${ville}."
    exit 1
fi


# Température actuelle 
val_temp=$(head -n 4 "$donnees_meteoVille" | tail -n 1 | cut -d'(' -f1 | tr ' ' '\n' | grep -v '^$' | tail -n 1 | tr -d '+')
tempActuelle="${val_temp}°C"

# Vent actuel 
val_vent=$(head -n 5 "$donnees_meteoVille" | tail -n 1 | cut -d'k' -f1 | tr ' ' '\n' | grep -v '^$' | tail -n 1)
vent="${val_vent} km/h"

# Visibilité 
val_visib=$(head -n 6 "$donnees_meteoVille" | tail -n 1 | cut -d'k' -f1 | tr ' ' '\n' | grep -v '^$' | tail -n 1)
visibilite="${val_visib} km"

# Humidité 
val_hum=$(grep -m1 "%" "$donnees_meteoVille" | cut -d'%' -f1 | tr ' ' '\n' | grep -v '^$' | tail -n 1)
humidite="${val_hum}%"

# Prévision du lendemain 
val_demain=$(grep "°C" "$donnees_meteoVille" | head -n 3 | tail -n 1 | cut -d'(' -f1 | tr ' ' '\n' | grep -v '^$' | tail -n 1 | tr -d '+')
tempDemain="${val_demain}°C"

# Horodatage
date_actuelle=$(date +"%Y-%m-%d")
heure_actuelle=$(date +"%H:%M")

# Écriture du résultat dans meteo.txt
echo "${date_actuelle} - ${heure_actuelle} - Ville: ${ville} - Temp actuelle: ${tempActuelle} - Prévision demain: ${tempDemain} - Vent: ${vent} - Humidité: ${humidite} - Visibilité: ${visibilite}" >> meteo.txt

echo "Données enregistrées avec succès dans meteo.txt pour ${ville}."
