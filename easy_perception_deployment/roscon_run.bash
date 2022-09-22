#!/usr/bin/env bash

echo "Camera: $1"
echo "Object: $2"

START_DIR=$(pwd)
cd ..

cp Configfiles/$1_$2/*.json easy_perception_deployment/config/
sudo cp Configfiles/$1_$2/*.json easy_perception_deployment/install/easy_perception_deployment/share/easy_perception_deployment/config/

my_script="./root/epd_ros2_ws/src/easy_perception_deployment/easy_perception_deployment/gui/scripts/launch.sh"

if docker ps | grep epd_test_container; then
  sudo docker exec -it epd_test_container $my_script
else
  sudo docker run -it --net=host --rm \
  --name epd_test_container \
  -v $(pwd):/root/epd_ros2_ws/src/easy_perception_deployment \
  --gpus=all \
  roscon/epd-foxy-cyclonedds:GPU \
  $my_script
fi

cd $START_DIR
