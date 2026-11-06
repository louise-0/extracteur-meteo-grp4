# extracteur-meteo-grp4
## Variante 1 : Informations météorologiques supplémentaires

Cette variante enrichit l'extraction de base en ajoutant trois données météorologiques complémentaires issues du service wttr.in.

###  Fonctionnalités ajoutées
* **Vitesse du vent** (en km/h)
* **Taux d'humidité** (en %)
* **Visibilité** (en km)

---

### 🛠️ Utilisation du script

```bash
# Exécution avec une ville en argument
./Extracteur_meteo.sh Toulouse

# Exécution sans argument (ville par défaut : Toulouse)
./Extracteur_meteo.sh
