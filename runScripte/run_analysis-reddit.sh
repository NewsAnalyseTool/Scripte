#!/bin/bash

# Pfad zum Projektverzeichnis
PROJECT_PATH=/home/local/Projekt/

# Pfad zum SBT-Projekt
SBT_PATH=/home/local/Projekt/Analysis/Analysis

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
ANALYSIS_REDDIT_COMPILE_RESULT=$(sbt assembly 2>&1)
curl -X POST -d "content=Analysis Reddit Compile:  $ANALYSIS_REDDIT_COMPILE_RESULT&sender=run_analysis-reddit.sh" http://localhost:3333/message

nohup spark-submit --class main.RedditSparkJob --master local --driver-memory 3G --name RedditAnalysis --packages org.mongodb.spark:mongo-spark-connector_2.12:10.2.1 $SBT_PATH/target/scala-2.12/*assembly*.jar >>redditerror.log 2>&1 &

#ANALYSIS_REDDIT_RUN_RESULT=$(spark-submit --class main.RedditSparkJob --master local --driver-memory 3G --name RedditAnalysis --packages org.mongodb.spark:mongo-spark-connector_2.12:10.2.1 $SBT_PATH/target/scala-2.12/*assembly*.jar 2>&1)
#curl -X POST -d "content=Analysis Reddit Run:  $ANALYSIS_REDDIT_RUN_RESULT&sender=run_analysis-reddit.sh" http://localhost:3333/message
