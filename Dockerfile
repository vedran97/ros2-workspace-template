FROM ubuntu:20.04 AS base

ENV DEBIAN_FRONTEND=noninteractive

# Copy container-setup scripts
COPY container-setup-scripts/ /container-setup-scripts/

# Install language support
RUN /container-setup-scripts/install-language-support.sh \
  && rm -rf /var/lib/apt/lists/*
ENV LANG en_US.UTF-8

# Install timezones
RUN /container-setup-scripts/install-timezones.sh \
  && rm -rf /var/lib/apt/lists/*

# Install ROS2
RUN /container-setup-scripts/install-ros2.sh \
  && rm -rf /var/lib/apt/lists/*

COPY 10-custom-rosdep.list /etc/ros/rosdep/sources.list.d/10-custom-rosdep.list
COPY base.yaml /etc/ros/rosdep/base.yaml

ENV ROS_DISTRO=foxy
ENV AMENT_PREFIX_PATH=/opt/ros/foxy
ENV COLCON_PREFIX_PATH=/opt/ros/foxy
ENV LD_LIBRARY_PATH=/opt/ros/foxy/lib
ENV PATH=/opt/ros/foxy/bin:$PATH
ENV PYTHONPATH=/opt/ros/foxy/lib/python3.8/site-packages
ENV ROS_PYTHON_VERSION=3
ENV ROS_VERSION=2

FROM base AS dev

RUN /container-setup-scripts/install-devtools.sh \
  && rm -rf /var/lib/apt/lists/*

ARG USERNAME=vedant
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Create a non-root user
RUN /container-setup-scripts/create-user.sh $USERNAME $USER_UID $USER_GID\
  && echo "source /usr/share/bash-completion/completions/git" >> /home/$USERNAME/.bashrc \
  && echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> /home/$USERNAME/.bashrc 

# Cleanup
RUN rm -rf /var/lib/apt/lists/* \
    && rm -rf /container-setup-scripts

RUN apt-get update \
   && apt-get autoremove -y \
   && apt-get clean -y \
   && rm -rf /var/lib/apt/lists/*
   
ENV DEBIAN_FRONTEND=dialog

ARG WORKSPACE=/workspaces/ros2-template-workspace

RUN echo "source /opt/ros/foxy/setup.bash;" >> /home/$USERNAME/.bashrc && \
    echo "if [ -f ${WORKSPACE}/install/setup.bash ]; then source ${WORKSPACE}/install/setup.bash; fi" >> /home/$USERNAME/.bashrc

USER $USERNAME
