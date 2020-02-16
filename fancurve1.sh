#! /bin/bash

echo Starting FanCurve!

#Sets fanControlState to 1
DEFAULT=(nvidia-settings -a "[gpu:0]/GPUFanControlState=1")
${DEFAULT[@]}


while :
do

#Assigns GPU temp to 'TEMP'
TEMP=$(nvidia-settings -t -q [gpu:0]/GPUCoreTemp)

	#these decide the target fan speed
	if [[ $TEMP -ge 45 && $TEMP -lt 50 ]]
	then
	 DEFAULT=(nvidia-settings -a "[fan:0]/GPUTargetFanSpeed=35")
	elif [[ $TEMP -ge 50 && $TEMP -lt 65 ]]
	then
	 DEFAULT=(nvidia-settings -a "[fan:0]/GPUTargetFanSpeed=45")
	elif [[ $TEMP -ge 65 && $TEMP -lt 80 ]]
	then
	 DEFAULT=(nvidia-settings -a "[fan:0]/GPUTargetFanSpeed=55")
	elif [[ $TEMP -ge 80 ]]
	then
	 DEFAULT=(nvidia-settings -a "[fan:0]/GPUTargetFanSpeed=90")
	else	
	 DEFAULT=(nvidia-settings -a "[fan:0]/GPUTargetFanSpeed=25")
	fi
		
	${DEFAULT[@]}  #This sets the Fanspeed
	
	sleep 7  #time between loops
done


