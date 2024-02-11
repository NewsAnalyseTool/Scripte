#!/bin/bash

# Discord Bot Path
BOT_PATH=/home/local/Projekt/Discord_Bot/DiscordBotForVM/

# Start Bot Path
RUN_BOT_PATH=/home/local/Projekt/Discord_Bot/DiscordBotForVM/ErrorBot.js

# Reddit Crawler Path
REDDIT_PATH=/home/local/Projekt/Reddit_Crawler/RedditCrawler/

# Tagesschau Crawler Path
TAGESSCHAU_PATH=/home/local/Projekt/Tagesschau_Crawler/ScalaTageschauCrawler/

# BBC Crawler Path
BBC_PATH=/home/local/Projekt/BBC_Crawler/BBCScalaCrawler/

# Backend / Frontend Path
BACKEND_PATH=/home/local/Projekt/Backend/WebInterface/

# Analyse Path
ANALYSE_PATH=/home/local/Projekt/Analysis/Analysis/

cd $BOT_PATH
DISCORD_BOT_UPDATE=$(git pull https://Username:Password@github.com/SearchTrendAnalyseTool/DiscordBotForVM.git 2>&1)
cd /

cd $REDDIT_PATH
REDDIT_CRAWLER_UPDATE=$(git pull https://Username:Password@github.com/SearchTrendAnalyseTool/RedditCrawler.git 2>&1)
cd / 

cd $TAGESSCHAU_PATH
TAGESSCHAU_CRAWLER_UPDATE=$(git pull https://Username:Password@github.com/SearchTrendAnalyseTool/ScalaTagesschauCrawler.git 2>&1)
cd / 

cd $BBC_PATH
BBC_CRAWLER_UPDATE=$(git pull https://Username:Password@github.com/SearchTrendAnalyseTool/BBCScalaCrawler.git 2>&1)
cd / 

cd $ANALYSE_PATH
ANALYSIS_UPDATE=$(git pull https://Username:Password@github.com/SearchTrendAnalyseTool/Analysis.git 2>&1)
cd /

cd $BACKEND_PATH
BACKEND_UPDATE=$(git pull https://Username:Password@github.com/SearchTrendAnalyseTool/WebInterface.git 2>&1)
cd /


cd /home/local/Projekt/
# Überprüfe, ob der Bot-Prozess läuft

if ps -ef | grep "ErrorBot.js" | grep -v grep; then
    echo "ErrorBot.js laeuft bereits."
else
	echo "\nBot Prozess wir gestartet" >> errorbot.log
    echo "Der Bot ist nicht gestartet. Starte ihn jetzt..."
    nohup node $RUN_BOT_PATH >> errorbot.log 2>&1 &
    sleep 5
fi

sleep 5
curl -X POST -d "content=Discord Bot update:\n$DISCORD_BOT_UPDATE&sender=run_component.sh" http://localhost:3333/update
curl -X POST -d "content=Reddit Crawler update:\n$REDDIT_CRAWLER_UPDATE&sender=run_component.sh" http://localhost:3333/update
curl -X POST -d "content=Tagesschau Crawler update:\n$TAGESSCHAU_CRAWLER_UPDATE&sender=run_component.sh" http://localhost:3333/update
curl -X POST -d "content=BBC Crawler update:\n$BBC_CRAWLER_UPDATE&sender=run_component.sh" http://localhost:3333/update
curl -X POST -d "content=Analysis update:\n$ANALYSIS_UPDATE&sender=run_component.sh" http://localhost:3333/update
curl -X POST -d "content=Backend update:\n$BACKEND_UPDATE&sender=run_component.sh" http://localhost:3333/update
