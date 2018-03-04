#!/bin/bash
##echo "task running"
##EmontoPV bash script

##echo "setting variables"
##My PVOutput Settings
PVOUTPUTSYSID=XXXX
PVOUTAPI=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
EMONAPI=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
EMONHOST="localhost"

##echo "Fetching values"
##Fetch and setup parameters
PVLogDate=$(date +%Y%m%d)
printf -v PVLogTime '%(%H:%M)T'
PVEnergyvalue=$(wget -qO- 'http://$EMONHOST/emoncms/feed/value.json?id=7&apikey=${EMONAPI}')
PVCurrentConsumption=$(wget -qO- 'http://$EMONHOST/emoncms/feed/value.json?id=9&apikey= ${EMONAPI}')
PVVoltage=$(wget -qO- 'http://$EMONHOST/emoncms/feed/value.json?id=13&apikey= ${EMONAPI}')

##echo Posting data to pvout
##echo Date=$PVLogDate Time=$PVLogTime Generating=$PVEnergyvalue Consuming=$PVCurrentConsumption
wget -qO- "https://pvoutput.org/service/r2/addstatus.jsp?sid=${PVOUTPUTSYSID}&key=${PVOUTAPI}&d=${PVLogDate}&t=${PVLogTime}&v2=${PVEnergyvalue}&v4=${PVCurrentConsumption}&v6=${PVVoltage}"
##echo Finished
