FROM ros:foxy-ros-base-focal

RUN apt-get update && apt-get install -y \
      iputils-ping \
      ros-foxy-rmw-cyclonedds-cpp \
      ros-foxy-demo-nodes-cpp \
      ros-foxy-demo-nodes-py && \
    rm -rf /var/lib/apt/lists/*

ENV RMW_IMPLEMENTATION="rmw_cyclonedds_cpp"
ENV ROS_DOMAIN_ID="2"

