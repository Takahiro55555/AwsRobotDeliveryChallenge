#!/bin/bash

echo "###############################################################################"
echo "Workshop environment setup starting.."
echo "###############################################################################"

# Wait if apt is running. 
while :
do
    count=`ps -ef | grep apt.systemd.daily | grep lock_is_held | grep -v grep | wc -l`
    if [ $count = 0 ]; then
        break
    else
        echo "System update is running.. Wait until the complete"
        sleep 10
    fi
done

sudo apt-get update
source /opt/ros/$ROS_DISTRO/setup.sh
rosdep update

sudo pip3 install -U awscli
sudo pip3 install -U colcon-common-extensions colcon-ros-bundle
sudo pip3 install boto3

./install_utils/setup.bash
./setup_ROBOTIS_sample.sh
curl -o ./robot_ws/src/deps/aws_game_manager/certs/AmazonRootCA1.pem https://www.amazontrust.com/repository/AmazonRootCA1.pem

python3 ./ws_setup.py
