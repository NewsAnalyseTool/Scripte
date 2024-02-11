#!/bin/bash

# Pfad zum Projektverzeichnis
PROJECT_PATH=/home/local/Projekt/

# Pfad zum SBT-Projekt
SBT_PATH=/home/local/Projekt/Backend/WebInterface/

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
# BACKEND_COMPILE_RESULT=$(sbt compile 2>&1)
# curl -X POST -d "content=Backend Compile:  $BACKEND_COMPILE_RESULT&sender=run_backend-frontend.sh" http://localhost:3333/message

#if ps -ef | grep "run_backend-frontend.sh" | grep -v grep; then
 #   echo "Backend-frontend laeuft bereits."
#else 
    echo "\nBackend Frontend Prozess wird gestartet"
    BACKEND_RUN_RESULT=$(sbt run 2>&1 &)
    curl -X POST -d "content=Backend Run:  $BACKEND_RUN_RESULT&sender=run_backend-frontend.sh" http://localhost:3333/message
    sleep 5 
#fi

