#!/bin/bash

# Pfad zum Projektverzeichnis
PROJECT_PATH=/home/local/Projekt/

# Pfad zum SBT-Projekt
SBT_PATH=/home/local/Projekt/BBC_Crawler/BBCScalaCrawler/

#Pfad zum Discord Bot
BOT_PATH=/home/local/Projekt/Discord_Bot/DiscordBotForVM/ErrorBot.js

# In das Projektverzeichnis wechseln
cd $PROJECT_PATH


# Überprüfe, ob der Bot-Prozess läuft
if ps -ef | grep "ErrorBot.js" | grep -v grep; then
    echo "ErrorBot.js laeuft bereits."
else 
    echo "\nBot Prozess wird gestartet" >> errorbot.log
    nohup node $BOT_PATH >> errorbot.log 2>&1 &
    sleep 5 
fi

# In das sbt Projekt wechseln
cd $SBT_PATH

# SBT-Befehle ausführen
BBC_COMPILE_RESULT=$(sbt compile 2>&1)
curl -X POST -d "content=BBC Compile:  $BBC_COMPILE_RESULT&sender=run_bbc-crawler.sh" http://localhost:3333/message


BBC_RUN_RESULT=$(sbt run 2>&1)
curl -X POST -d "content=BBC Run:  $BBC_RUN_RESULT&sender=run_bbc-crawler.sh" http://localhost:3333/message
