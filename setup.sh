#!/bin/bash

# === Création des fichiers de démos ===

# Démo 1 : execsnoop.bt
cat << 'EOF' > execsnoop.bt
#!/usr/bin/env bpftrace
tracepoint:syscalls:sys_enter_execve
{
    printf("%d  %s\n", pid, comm);
}
EOF

chmod +x execsnoop.bt

# Démo 2 : opensnoop.bt
cat << 'EOF' > opensnoop.bt
#!/usr/bin/env bpftrace
tracepoint:syscalls:sys_enter_openat
{
    printf("%d  %s  %s\n", pid, comm, str(args->filename));
}
EOF

chmod +x opensnoop.bt

# Démo 3 : cpu_usage.bt
cat << 'EOF' > cpu_usage.bt
#!/usr/bin/env bpftrace
BEGIN {
    printf("Monitoring CPU usage per process... Ctrl+C to stop\n");
}

tracepoint:sched:sched_switch {
    @cpu[comm] = @cpu[comm] + 1;
}

interval:s:1 {
    printf("\n=== CPU usage per process (approx) ===\n");
    print(@cpu);
    clear(@cpu);
}
EOF

chmod +x cpu_usage.bt

# Démo 4 : network_monitor.bt
cat << 'EOF' > network_monitor.bt
#!/usr/bin/env bpftrace
tracepoint:syscalls:sys_enter_connect
{
    printf("%d  %s  connect()\n", pid, comm);
}
EOF

chmod +x network_monitor.bt

# README.md complet
cat << 'EOF' > README.md
# eBPF / BPFtrace Demo

## Introduction

Ce projet présente plusieurs démonstrations utilisant eBPF (extended Berkeley Packet Filter) avec BPFtrace afin d'observer l'activité interne d'un système Linux en temps réel.

eBPF est une technologie moderne du noyau Linux qui permet d’exécuter des programmes directement dans le kernel de manière sécurisée et performante, sans modifier le noyau lui-même. Elle est largement utilisée aujourd’hui pour :

- l’observabilité des systèmes
- l’analyse de performance
- la détection d’activités suspectes
- le monitoring avancé

Dans ce projet, plusieurs scripts BPFtrace sont utilisés pour surveiller différentes activités du système comme :

- l’exécution des programmes
- l’accès aux fichiers
- l’utilisation du CPU
- les connexions réseau

Ces démonstrations montrent comment eBPF permet d’obtenir des informations très précises sur le comportement du système en temps réel.

----

## Démo 1 – execsnoop

**Commande à exécuter :**  
sudo ./execsnoop.bt

**Description**  
Cette démo trace tous les appels système execve, c’est-à-dire tous les programmes lancés sur le système.  
Elle affiche en temps réel :  
- le PID  
- le nom du programme exécuté

**Exemple de sortie**  
2196 nano  
12196 nano  
12196 bash  
...

----

## Démo 2 – opensnoop

**Commande à exécuter :**  
sudo ./opensnoop.bt

**Description**  
Cette démo trace tous les fichiers ouverts par les programmes en temps réel.  
Elle affiche :  
- le PID  
- le nom du programme  
- le chemin du fichier ouvert

**Exemple de sortie**  
2196 nano /etc/ld.so.cache  
12196 nano /usr/lib/x86_64-linux-gnu/libncursesw.so.6  
12196 nano /usr/lib/x86_64-linux-gnu/libc.so.6  
...

----

## Démo 3 – cpu_usage

**Commande à exécuter :**  
sudo ./cpu_usage.bt

**Description**  
Cette démo montre l’utilisation approximative du CPU par processus en temps réel.  
Elle compte le nombre d’apparitions d’un processus dans le scheduler.

**Exemple de sortie**  
=== CPU usage per process (approx) ===  
bash: 5  
nano: 2  
firefox: 10  
...

----

## Démo 4 – network_monitor

**Commande à exécuter :**  
sudo ./network_monitor.bt

**Description**  
Cette démo surveille les connexions réseau initiées par les processus.  
Elle trace l’appel système connect afin de détecter quand un programme tente d’établir une connexion réseau.  
Elle affiche :  
- le PID  
- le nom du processus  
- l’événement de connexion

**Exemple de sortie**  
PID PROCESS EVENT  
4321 curl connect()  
5320 firefox connect()  
6102 ping connect()  

----

## Instructions pour exécuter

1. Ouvrir un terminal et naviguer dans le dossier du projet.  
2. Lancer chaque démo avec les commandes indiquées ci-dessus.  
3. Observer la sortie en temps réel.  
4. Pour arrêter la démo, appuyer sur Ctrl+C.  

----

## Explications des scripts

- **execsnoop.bt** : Surveille l’exécution des programmes (execve).  
- **opensnoop.bt** : Surveille les fichiers ouverts par les programmes.  
- **cpu_usage.bt** : Montre une estimation de l’utilisation CPU par processus.  
- **network_monitor.bt** : Surveille les tentatives de connexion réseau des processus (connect).
EOF

echo "Tous les fichiers ont été créés avec succès !"
