#!/bin/bash

# Pfad zum Projektverzeichnis
PROJECT_PATH=/home/local/Projekt/

# Pfad zum SBT-Projekt
SBT_PATH=/home/local/Projekt/Reddit_Crawler/RedditCrawler/

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
REDDIT_COMPILE_RESULT=$(sbt compile 2>&1)
curl -X POST -d "content=Reddit Compile:  $REDDIT_COMPILE_RESULT&sender=run_reddit-crawler.sh" http://localhost:3333/message


REDDIT_RUN_RESULT=$(sbt run 2>&1)
curl -X POST -d "content=Reddit Run:  $REDDIT_RUN_RESULT&sender=run_reddit-crawler.sh" http://localhost:3333/message
