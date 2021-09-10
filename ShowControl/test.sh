#!/bin/sh

while (true) ;  do
	MESSAGE=$(nc -l -p 5150)
	echo "Message is: ""$MESSAGE"
	case $MESSAGE in
		shutdown)
			echo "Shutting down!"
			poweroff
			;;
		mute)
			echo "muting"
			
			;;
	esac
done
