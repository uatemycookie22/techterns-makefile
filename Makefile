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

update:
	git pull --rebase origin main

start:
	sudo docker start wb0 || true ;
	sudo docker start stt0 || true ;
	sudo docker start mqtt0 || true ;
	sudo docker start audio_input0 || true 
stop:
	sudo docker stop wb0 || true ;
	sudo docker stop stt0 || true ;
	sudo docker stop mqtt0 || true ;
	sudo docker stop audio_input0 || true 

rm:
	sudo docker rm wb0 || true ;
	sudo docker rm stt0 || true ;
	sudo docker rm mqtt0 || true ;
	sudo docker rm audio_input0 || true 

images:
	sudo make clean-images ;
	cd ./techterns && sudo docker build -t stt0 . ; #stt initiation 
	cd ./audio-output && sudo docker build -t wb0 . ; #web page initiation 
	cd ./audio-input && sudo docker build -t audio_input0 .  #audio_input initiation 

reimage-stt0:
	sudo docker image rm stt0 || true ;
	sudo docker build -t stt0 .

run:
	sudo make clean-containers
	sudo docker run --name mqtt0 -d -p 1883:1883 ibmosquito/techterns:1.0.0 ;
	echo MQTT online… ;
	sudo docker run --name stt0 --privileged --network host -d stt0 ;
	echo stt0 online… ;
	sudo docker run --name wb0 -p 5200:5200 --network host -d wb0 ;
	echo wb0 online… ;
	echo You are now inside the audio_input0 container. && sudo docker run --name audio_input0 --privileged --network host -ti audio_input0 /bin/bash 

run-containers:
	make clean ; #Stop and remove any previous container or image created from the last run
	make images ;
	make run
	
clean-images:
	sudo docker image rm wb0 || true ;
	sudo docker image rm stt0 || true ;
	sudo docker image rm audio_input0 || true

clean-containers:
	sudo make stop
	sudo make rm
	
clean:
	sudo make clean-containers ;
	sudo make clean-images


.PHONY: build images start stop rm run run-containers clean-images clean

                                 
