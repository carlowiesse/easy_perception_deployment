#!/usr/bin/env bash

msg0="Installing Docker"
msg1="Building Docker image"

# Check if Docker is installed.
# If not installed, install it.
if output=$(sudo docker --version > /dev/null 2>&1); then
    :
else
    echo $msg0
    echo "Reference: [ https://docs.docker.com/engine/install/ubuntu/ ]"
    sudo apt-get remove -y docker \
      docker-engine \
      docker.io \
      containerd \
      runc
    sudo apt-get update && \
    apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
   sudo apt-get update
   sudo apt-get install docker-ce docker-ce-cli containerd.io
fi

echo "Docker [ FOUND ]"

# Check if epd-foxy-base:GPU Docker Image has NOT been built.
# If true, build it.
if output=$(sudo docker images | grep roscon/epd-foxy-cyclonedds | grep GPU > /dev/null 2>&1); then
    echo "epd-foxy-base:GPU  Docker Image [ FOUND ]"
else
    # If there is internet connection,
    # Download public docker image.
    wget -q --spider http://google.com
    if [ $? -eq 0 ]; then
        echo $msg1
        #sudo docker pull cardboardcode/epd-foxy-base:GPU
        sudo docker build --tag roscon/epd-foxy-cyclonedds:GPU ../Dockerfiles/GPU+cycloneDDS/
    else
        echo "No internet available [ EXIT ]"
        return
    fi
    echo "epd-foxy-base:GPU  Docker Image [ CREATED ]"
fi

START_DIR=$(pwd)
cd ..

my_script="./root/epd_ros2_ws/src/easy_perception_deployment/easy_perception_deployment/gui/scripts/build.sh"

sudo docker run -it --rm \
--name epd_test_container \
-v $(pwd):/root/epd_ros2_ws/src/easy_perception_deployment \
--gpus=all \
roscon/epd-foxy-cyclonedds:GPU \
$my_script

cd $START_DIR
