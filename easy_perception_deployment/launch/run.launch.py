# Copyright 2022 ROS-Industrial Consortium Asia Pacific
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

from launch_ros.substitutions import FindPackageShare
from launch import LaunchDescription
import launch_ros.actions
import json
import os

def generate_launch_description():

    pkg_share = FindPackageShare(package='easy_perception_deployment').find('easy_perception_deployment')

    filepath_to_input_image_json = os.path.join(pkg_share, 'config/input_image_topic.json')

    input_image_json = open(filepath_to_input_image_json)

    data = json.load(input_image_json)

    topic_settings = data['input_image_topic'].split(',')
    camera_name = topic_settings[0].strip()
    object_name = topic_settings[1].strip()
    print('camera name: ',camera_name)
    print('object name: ',object_name)

    return LaunchDescription([
        launch_ros.actions.Node(
            package='easy_perception_deployment',
            executable='easy_perception_deployment',
            output='screen',
            remappings=[('/easy_perception_deployment/image_input', '/'+camera_name+'/color/image_raw'),
                        ('/camera/color/image_raw', '/'+camera_name+'/color/image_raw'),
                        ('/camera/depth/image_rect_raw', '/'+camera_name+'/aligned_depth_to_color/image_raw'),
                        ('/camera/color/camera_info', '/'+camera_name+'/color/camera_info'),
                        ('/easy_perception_deployment/image_output', '/easy_perception_deployment/image_output_'+object_name),
                        ('/easy_perception_deployment/epd_p1_output', '/easy_perception_deployment/epd_p1_output_'+object_name),
                        ('/easy_perception_deployment/epd_p2_output', '/easy_perception_deployment/epd_p2_output_'+object_name),
                        ('/easy_perception_deployment/epd_p3_output', '/easy_perception_deployment/epd_p3_output_'+object_name),
                        ('/easy_perception_deployment/epd_tracking_output', '/easy_perception_deployment/epd_tracking_output_'+object_name),
                        ('/easy_perception_deployment/epd_localize_output', '/easy_perception_deployment/epd_localize_output_'+object_name)]
            ),
    ])
