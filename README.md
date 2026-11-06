# extracteur-meteo-grp4









## Version 2 : ville par défaut et cron
Sans argument, la ville par défaut (Toulouse) est utilisée.

### Automatisation avec cron
1. Ouvrir la table cron : `crontab -e`
2. Ajouter la ligne (exécution toutes les heures) :
   `0 * * * * cd /chemin/vers/le/projet && ./Extracteur_meteo.sh Toulouse`
3. Enregistrer, puis vérifier avec `crontab -l`.

Le `cd` est nécessaire : le script écrit ses fichiers dans le dossier
courant, et cron ne démarre pas dans le dossier du projet.