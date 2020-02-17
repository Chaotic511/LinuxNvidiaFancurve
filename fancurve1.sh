#! /bin/bash

echo Starting FanCurve!

#Sets fanControlState to 1 and gpu performance mode to "High performance"
default=(nvidia-settings -a "[gpu:0]/GPUFanControlState=1" -a "[gpu:0]/GPUPowerMizerMode=1")
${default[@]}


while :
do

#Assigns GPU temp to 'TEMP'
temp=$(nvidia-settings -t -q [gpu:0]/GPUCoreTemp)

	#these decide the target fan speed
	if [[ $temp -ge 45 && $temp -lt 50 ]]
	then
	 default=(nvidia-settings -a "[fan:0]/GPUTargetFanSpeed=35")	#45c-50c
	elif [[ $temp -ge 50 && $temp -lt 65 ]]
	then
	 default=(nvidia-settings -a "[fan:0]/GPUTargetFanSpeed=45")	#50c-65c
	elif [[ $temp -ge 65 && $temp -lt 80 ]]
	then
	 default=(nvidia-settings -a "[fan:0]/GPUTargetFanSpeed=55")	#65c-80c
	elif [[ $temp -ge 80 ]]
	then
	 default=(nvidia-settings -a "[fan:0]/GPUTargetFanSpeed=90")	#over 80c
	else	
	 default=(nvidia-settings -a "[fan:0]/GPUTargetFanSpeed=25")	#Under 45c
	fi
		
	${default[@]}  #This sets the Fanspeed
	
	sleep 7  #time between loops
done


