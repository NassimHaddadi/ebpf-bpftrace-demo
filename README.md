# eBPF / BPFtrace Demo

## Démo 1 – execsnoop
**Commande à exécuter**
sudo ./execsnoop.bt

**Description**
Cette démo trace tous les appels système execve, c’est-à-dire tous les programmes lancés sur le système.
Elle affiche en temps réel le PID et le nom du programme.

**Exemple de sortie**
2196 nano
12196 nano
12196 bash
...

## Démo 2 – opensnoop
**Commande à exécuter**
sudo ./opensnoop.bt

**Description**
Cette démo trace tous les fichiers ouverts par les programmes en temps réel.
Elle affiche le PID, le nom du programme et le chemin du fichier ouvert.

**Exemple de sortie**
2196 nano /etc/ld.so.cache
12196 nano /usr/lib/x86_64-linux-gnu/libncursesw.so.6
12196 nano /usr/lib/x86_64-linux-gnu/libc.so.6
...

## Démo 3 – cpu_usage
**Commande à exécuter**
sudo ./cpu_usage.bt

**Description**
Cette démo montre l'utilisation approximative du CPU par processus en temps réel.
Elle affiche le nom du processus et le nombre d'occurrences dans le scheduler.

**Exemple de sortie**
=== CPU usage per process (approx) ===
bash: 5
nano: 2
firefox: 10
...

## Instructions pour exécuter
1. Ouvrir un terminal et naviguer dans le dossier du projet.
2. Lancer chaque démo avec les commandes indiquées ci-dessus.
3. Observer la sortie en temps réel.
4. Pour arrêter la démo, appuyer sur Ctrl+C.

## Explications
- **execsnoop.bt** : Surveille l’exécution des programmes (execve), utile pour voir quels programmes se lancent.
- **opensnoop.bt** : Surveille les fichiers ouverts par tous les programmes, pratique pour déboguer ou comprendre l’accès aux fichiers.
- **cpu_usage.bt** : Montre l’utilisation approximative du CPU par processus en temps réel.

