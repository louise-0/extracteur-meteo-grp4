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

Les données météo de la ville choisie sont rajoutées périodiquement dans le fichier meteo.txt grâce à l'outil `cron`.


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
# Edit this file to introduce tasks to be run by cron.
#
# Each task to run has to be defined through a single line
# indicating with different fields when the task will be run
# and what command to run for the task
#
# To define the time you can provide concrete values for
# minute (m), hour (h), day of month (dom), month (mon),
# and day of week (dow) or use '*' in these fields (for 'any').
#
# Notice that tasks will be started based on the cron's system
# daemon's notion of time and timezones.
#
# Output of the crontab jobs (including errors) is sent through
# email to the user the crontab file belongs to (unless redirected).
#
# For example, you can run a backup of all your user accounts
# at 5 a.m every week with:
# 0 5 * * 1 tar -zcf /var/backups/home.tgz /home/
#
# For more information see the manual pages of crontab(5) and cron(8)
#
# m h  dom mon dow   command
```

### Étape 3 : Configuration de la tache cron.

On ajoute a la fin de ce fichier la ligne suivante :

**Syntaxe** :

 ┌───────── minute (0-59)

 │ ┌─────── heure (0-23)

 │ │ ┌───── jour du mois (1-31)

 │ │ │ ┌─── mois (1-12)

 │ │ │ │ ┌─ jour de la semaine (0-7, 0 et 7 = dimanche)

 │ │ │ │ │

`* * * * *` chemin/du/code/a/executer >> /chemin/cron.log 2>&1

```bash
* * * * * /home/projet/Extracteur_meteo.sh >> /home/projet/cron.log 2>&1
```
Execution toute les minutes du code Extracteur_meteo.sh et toute les erreurs sont rediriger vers le fichier cron.log


### Étape 4 : Verification de la configuration.

```bash
crontab -l
```

## IV/Variante 2 : Sauvegarde au format JSON

En plus du fichier texte `meteo.txt`, le script peut enregistrer les données au format **JSON** grâce à l'option `-j`.

### Utilisation
L'option `-j` doit être placée **en premier argument**, la ville vient ensuite (sinon la ville par défaut est utilisée) :
```bash
./Extracteur_meteo.sh -j "Toulouse"
```
Sans l'option `-j`, le script fonctionne comme avant et écrit dans `meteo.txt`.

### Résultat
Chaque exécution **ajoute une ligne** (un objet JSON) à la fin du fichier `meteo.json` :
```json
{"date": "2026-11-06", "heure": "17:47", "ville": "Toulouse", "temperature": "15°C", "prevision": "13°C"}
```
Pour vérifier le résultat :
```bash
tail -1 meteo.json
```

### Fonctionnement
- Le script lit toujours le format **texte** de wttr.in (`?T`), comme l'impose le sujet.
- Le JSON est construit à la main avec `echo` : aucune commande interdite n'est utilisée.
- La date et l'heure sont obtenues avec `printf` (fonction intégrée à bash), car la commande `date` n'est pas autorisée.

### Utilisation avec Cron
L'option `-j` fonctionne aussi avec la tâche cron de la partie III :
```bash
* * * * * /home/projet/Extracteur_meteo.sh -j >> /home/projet/cron.log 2>&1
```
Exécution toutes les minutes avec enregistrement dans `meteo.json`.