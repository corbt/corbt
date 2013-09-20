package :seafile_client do
	# wget http://seafile.googlecode.com/files/seafile-cli_1.5.3_x86-64.tar.gz 
	# tar xzf seafile-cli_1.5.3_x86-64.tar.gz

# Move seafile folder to /etc

# cd seafile-cli_1.5.3
# # choose a folder where to store the seafile client settings e.g ~/.seafile-client
# mkdir ~/.seafile-client            # create the settings folder
# ./seaf-cli init -d ~/.seafile-client  # initialise seafile client with this folder
# ./seaf-cli start

#link the full path of the exectuable
# ln -s `readlink -f seaf-cli` /usr/bin/

# seaf-cli download -l "2382ea44-d997-4c5a-9da3-39414dd7d381" -s http://corbt.com:8000 -d "/data/apps" -u "kylecorbitt@gmail.com"

# In sites-enabled/corbt:
# location /files {
#     alias /data/apps/web;
# }

end