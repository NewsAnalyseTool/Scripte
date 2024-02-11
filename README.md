## Scripte
All scripts are using the [Discord Bot](https://github.com/NewsAnalyseTool/DiscordBotForVM.git). Be sure you are using it./
Each script is starting the Discord Bot if it is not running. You don't have to start it./
Otherwise you have to delete the lines for Discord Bot in all scripts./

All run scripts need to be updated in all *_PATH variables.

# Run
For run_Analysis* be sure you have installed Spark./
Maybe you have to set the path to [Spark](https://github.com/NewsAnalyseTool/Analysis.git) as global variable in these scripts.

# Update
Replace in the URl's the Username and Password with your credentials./ 
REDDIT_CRAWLER_UPDATE=$(git pull https://Username:Password@github.com/SearchTrendAnalyseTool/RedditCrawler.git 2>&1)

# Cron
You can find the crontab file on Linux "/etc/"./
These file will start all crawlers and the update script./
You only have to copy line 19-24 and paste it in your crontab file./
Example: 5 * * * * local cd /home/local/Projekt/Scripte/ && bash run_tagesschau-crawler.sh
- 5 means everytime the clock is xx:05 these script will be started.
- local is the user it runs with, use your username (of the PC) there
- cd /home/local/Projekt/Scripte/ change to the path of the scripts
- && bash run_tagesschau-crawler.sh and run the following script with bash
