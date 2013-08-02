package :unicorn, provides: :appserver do 
	requires :fs, :nginx
	file "/etc/nginx/nginx.conf", contents: render("nginx.conf"), sudo: true
	runner "service nginx restart", sudo: true

	verify{ file_contains "/etc/nginx/nginx.conf", Site::CONFIG[:app_dir]+"/site/current/public"}
end