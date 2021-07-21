# techterns-makefile P-TECH 2021 Summer Interns (TechTerns)

## About
This repository contains a Makefile to download and run all four containers for the TechTerns Containerized Speech and Text System (CSTS). This system was designed for modularity and ease of deployment. Anyone who wishes to use the repository can build onto it without changing fundamental aspects of it by simply adding another repository and connecting to the MQTT message broker.

## Packages

#Required
The following packages are required for use of the CSTS:
- Git, Curl, and Make can be installed by running (on Linux and MacOS) ```sudo apt update && sudo apt install -y git make curl```
- Docker can be installed by running (on Linux and MacOS) ```curl -sSL https://get.docker.com/ | sh

#Optional
The following packages are not required, but advised to install for debugging or development: 
- jq vim net-tools, NPM, and Mosquitto can be installed  by running (on Linux and MacOS) ```sudo apt install -y jq vim net-tools npm mosquitto-clients```

## Deployment
The Makefile is used to shorten the steps to get the system running by running multiple commands with a single 'make' command.
- Run ```make build``` while in the local repository's directory to clone all TechTerns repositories.
- For now, you must add an .env-local file containing environment variables for the Watson Speech-To-Text and Text-To-Speech API keys. 
- Run ```make run-containers``` to build the images and run all the containers, leaving you inside the bash of the Audio Input container at the end. 
- Inside the Audio Input container bash, you can run ```npm run record:5wav``` to record a 5 second wav file, then ```npm format-audio:temp``` to format it as a JSON, and finally ```npm run audio-pub:temp``` to publish the audio to the MQTT message broker. To do all of these steps at once, run ```npm run all```.
- Connect to ```<PUBLIC_IP>:5200/stuff``` in your browser, where ```<PUBLIC_IP>``` is your public IP address.

