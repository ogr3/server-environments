#!/bin/bash
USER_NAME="ubuntu"

CURRENT_USER=$(/usr/bin/whoami)

######################################################################
#                                                                    #
# DO NOT EDIT BELOW THIS LINE                                        #
#                                                                    #
######################################################################

CMD="screen -A -m -d -c /home/ubuntu/.screenrc -S TF2 /home/ubuntu/tf2/srcds_run -console -game tf -nohltv +sv_pure 1 +map koth_harvest_final +maxplayers 24 -ip 172.31.36.73 +clientport 27005 -port 27015 -autoupdate -steam_dir /home/ubuntu/.steam/steamcmd -steamcmd_script /home/ubuntu/tf2server-script"

if [ "$CURRENT_USER" = "$USER_NAME" ]; then
  sh -c "$CMD"
else
  su - $USER_NAME -c "$CMD"
fi

