#Authors: Lysander --If you edit something in this file, put your name/nickname here!

#include checks.mk

#Constants


#Initiation

#PHONY rules
build:
	git clone https://github.com/uatemycookie22/audio-input ;
	git clone https://github.com/uatemycookie22/audio-output ;
	git clone https://github.com/playground/techterns ;
	cd ./audio-input && git checkout -t origin/node ;
	cd ./techterns && git checkout -t origin/techterns_lysander 

run-containers:
	make clean ; #Stop and remove any previous container or image created from the last run
	sudo docker run --name mqtt0 -d -p 1883:1883 ibmosquito/techterns:1.0.0 ;
	echo MQTT online… ;
	cd ./techterns && sudo docker build -t stt0 . #stt initiation ;	
	sudo docker run --name stt0 --privileged --network host -d stt0 ;
	echo stt0 online… ;
	cd ./audio-output && sudo docker build -t wb0 . #web page initiation ;
	sudo docker run --name wb0 -p 5200:5200 -d wb0 ;
	echo wb0 online… ;
	cd ./audio-input && sudo docker build -t audio_input0 . #audio_input initiation ;
	echo You are now inside the audio_input0 container. && sudo docker run --name audio_input0 --privileged --network host -ti audio_input0 /bin/bash ;
clean:
	sudo docker stop wb0 || true && docker rm wb0 || true ;
	sudo docker stop stt0 || true && docker rm stt0 || true ;
	sudo docker stop mqtt0 || true && docker rm mqtt0 || true ;
	sudo docker stop audio_input0 || true && docker rm audio_input0 || true ;
	sudo docker image rm wb0 || true ;
	sudo docker image rm stt0 || true ;
	sudo docker image rm audio_input0 || true


.PHONY: run-containers clean

                                 