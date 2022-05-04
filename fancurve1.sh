#! /bin/bash

echo Starting FanCurve!

#Sets fanControlState to 1,  add -a "[gpu:0]/GpuPowerMizerMode=0" to change powerstates on launch  (0, 1, 2)
default=(nvidia-settings -a "[gpu:0]/GPUFanControlState=1")
${default[@]}

while :
do

#Assigns GPU temp to 'TEMP'
temp=$(nvidia-smi -q -d temperature | grep "GPU Current Temp" | tr -d ':''C' | awk '{print $4'})

	#these decide the target fan speed
	if [[ $temp -ge 45 && $temp -lt 50 ]]
	then
	 default=(nvidia-settings -a "[fan:0]/GPUTargetFanSpeed=25")	#45c-50c
	
	elif [[ $temp -ge 50 && $temp -lt 65 ]]
	then
	 default=(nvidia-settings -a "[fan:0]/GPUTargetFanSpeed=45")	#50c-65c
	
	elif [[ $temp -ge 65 && $temp -lt 85 ]]
	then
	 default=(nvidia-settings -a "[fan:0]/GPUTargetFanSpeed=65")	#65c-85c
	
	elif [[ $temp -ge 85 ]]
	then
	 default=(nvidia-settings -a "[fan:0]/GPUTargetFanSpeed=100")	#over 85c
	
	else	
	 default=(nvidia-settings -a "[fan:0]/GPUTargetFanSpeed=25")	#Under 45c
	fi
		
	${default[@]}  #This sets the Fanspeed
	
	sleep 7  #time between loops
done


