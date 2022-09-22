#!/usr/bin/env bash

msg1="Sourcing [ROS2]"
msg2="Sourcing [Local Package/Workspace]"
msg3="Deploying package."

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
cd $SCRIPTPATH

# Source ROS Foxy
# TODO Run check if folder exist.
echo $msg1
source /opt/ros/foxy/setup.bash

echo $msg2
# Check if the current easy_perception workspace has been built or not.
# If true, run selective colcon build.
# Otherwise, pass
cd ../../

# Source the epd_msgs workspace
cd ../epd_msgs
source install/setup.bash

# Source the main workspace
cd ../easy_perception_deployment
source install/setup.bash

# Launch easy_perception_deployment.
echo $msg3

echo
echo "== Custom Settings =="
export ROS_DOMAIN_ID=2
echo "ROS ID: ${ROS_DOMAIN_ID}"
export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
echo "$(ros2 doctor --report | grep middleware)"
echo
ifconfig
echo
echo "Visible ROS topics:"
ros2 topic list
echo

ros2 launch easy_perception_deployment run.launch.py

