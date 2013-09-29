# Use this file to easily define all of your cron jobs.

set :output, "/data/apps/site/shared/log/cron_log.log"

every 1.hours do
	rake 'cs478:slurp_bing'
end