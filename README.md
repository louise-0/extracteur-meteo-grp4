# Extracteur Météo - Groupe 4
L'extracteur météo est un script en shell/bash qui récupère les informations météo en temps réel pour une ville donnée.

## I/Objectif du Projet
L'objectif du projet est de développer un script capable d'extraire de manière **périodique** et **autonome** les données météorologiques d'une ville donnée en utilisant le service **wttr.in**.

Le script respecte les contraintes suivantes :
- __Les Données extraites__ : La température actuelle de la ville + les prévisions météorologiques du lendemain.
- __Le Format d'enregistrement__ : Les données sont stockées dans un fichier texte nommé `meteo.txt`. **Chaque extraction apparaît sur une seule ligne** (historisation chronologique grâce au `cron`).
- __Le Suivi du Projet & La Collaboration__ : Utilisation de **GIT / GITHUB** pour réaliser l'historique des versions ainsi que de **Teams** pour discuter de l'avancé du projet et de **Jira** pour visualiser les différentes tâches qui composent le projet et sa durée.

## II/Exécution du script manuellement

### Étape 1 : Lancer le script
Exécutez le script en passant le nom de la ville de votre choix en argument (sinon une ville par défaut est choisi) :
```bash
./Extracteur_meteo.sh "Toulouse"
```

### Étape 2 : Consulter le résultat
Le script extrait les données et les rajoute dans le fichier texte `meteo.txt`. Pour vérifier le résultat, affichez le fichier :
```bash
cat meteo.txt
```

## III/Configuration de l'automatisation avec Cron

La météo de la ville choisie est rajouter periodiquement dans le fichier meteo.txt grâce a cron.


### Étape 1 : Rendre le script exécutable.
```bash
chmod +x Extracteur_meteo.sh
```

### Étape 2 : Ouvrir le crontab.
```bash
crontab -e
```
Nous obtenons alors ce menu :
```bash

```
### Étape 3 : sous-titre3
je sais pas
