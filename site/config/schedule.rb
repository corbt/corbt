# Use this file to easily define all of your cron jobs.
env :PATH, ENV['PATH']

set :output, "/data/apps/site/shared/log/cron_log.log"

every 1.hours do
	rake 'cs478:slurp_bing'
end

every 10.minutes do
	rake 'cs598r:slurp_bing'
end

every 30.minutes do
	rake 'cs598r:slurp_wu'
end