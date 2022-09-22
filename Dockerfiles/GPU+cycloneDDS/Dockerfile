FROM cardboardcode/epd-foxy-base:GPU

RUN rm /etc/apt/sources.list.d/cuda.list
RUN rm /etc/apt/sources.list.d/nvidia-ml.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

RUN apt-get update && apt-get install -y \
      iputils-ping \
      ros-foxy-rmw-cyclonedds-cpp \
      ros-foxy-demo-nodes-cpp \
      ros-foxy-demo-nodes-py && \
    rm -rf /var/lib/apt/lists/*

