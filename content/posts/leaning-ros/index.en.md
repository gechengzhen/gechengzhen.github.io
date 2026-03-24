---
title: "learning ros"
date: 2022-05-17T23:55:58+08:00
slug: leaning-ros
tags:
  - ROS
---

“learning ROS”


```plaintext
mkdir -p demo01_ws/src
cd demo01_ws/
catkin_make
cd src
catkin_create_pkg helloworld roscpp rospy std_msg
```


```c++
#include "ros/ros.h"
int main (int argc, char *argv[])
{
    ros::init(argc, argv, "hello_node");
    ROS_INFO("hello world");
    return 0;
}
```


```cmake
add_executable(haha src/helloworld_c.cpp)
target_link_libraries(haha ${catkin_LIBRARIES})
```


```plaintext
roscore
source ./devel/setup.bash
rosrun helloworld haha
```


```xml
<launch>
	<node pkg = "turtlesim" type = "turtlesim_node" name = "turtle_GUI"/>
  	<node pkg = "turtlesim" type = "turtle_teleop_key" name = "turtle_key"/>
    <node pkg = "hello_vscode" type = "hello_vscode_c" name = "hello" output = "screen"/>
</launch>
```


```plaintext
rospack list
rospack find turtlesim
roscd turtlesim
rosls turtlesim
apt search ros-noetic-* | grep -i gmapping
rosrun rqt_grah rqt_grah
```


```c++
#include "ros/ros.h"
#include "std_msgs/String.h"
#include <sstream>

int main (int argc, char *argv[])
{
    ros::init(argc, argv, "erGouZi");
    ros::NodeHandle nh;
    ros::Publisher pub = nh.advertise<std_msgs::String>("fang", 10);
    std_msgs::String msg;
    ros::Rate rate(10);
    int count = 0;
    ros::Duration(3).sleep();
    while (ros::ok())
    {
        count++;

        std::stringstream ss;
        ss << "hello --->" << count;
        //msg.data = "hello";
        msg.data = ss.str();
        pub.publish = (msg);
        ROS_INFO("The published data is:%s", ss.str().c_str());
        rate.sleep();
    }
    return 0;
}
```


```cmake
add_executable(demo01_pub src.demo01_pub.cpp)
target_link_libraries(demo01_pub ${catkin_LIBRARIES})
```


```c++
#include "ros/ros.h"
#include "std_msgs/String.h"

void doMsg(const std_msgs::String::ConstPtr &msg)
{
    ROS_INFO("cuiHua subsription data:%s", msg->data.c_str())
}

int main(int argc, char *argv[])
{
    ros::init(argc, argv, "cuiHua");
    ros::NodeHandle nh;
    ros::Subscriber sub = nh.subcribe("fang", 10, doMsg);
    ros::spin();
    return 0;
}
```


```cmake
add_executable(demo02_sub src/deom02_sub.cpp)
target_link_libraries(demo01_pub ${catkin_LIBARIES})
```


```plaintext
rqt_graph
```


---


`Person.msg`


```plaintext
string name
int32 age
float32 height
```


`package.xml`


```xml
<build_depend>message_generation</build_depend>
<exec_depend>message_runtime</exec_depend>
```


`CMakeLists.txt`


```cmake
find_package(cakin REQUIRED COMPONENTS
roscpp
rospy
std_msgs
message_generation
)
add_message_files(
FILES
Person.msg
)
generate_messages(
DEPENDENCIES
std_msgs
)
catkin_package(
CATKIN_DEPENDS roscpp rospy std_msgs message_runtime
)
```


`demo3_pub_person.cpp`


```c++
#include "ros/ros.h"
#include "plumbing_pub_sub/Person.h"

/*
	publisher:The publisher's message
		1.Include header files
			#include "plumbing_pub_sub/Person.h"
		2.Initialize the ROS node
		3.Create a node handle
		4.Create a publisher object
		5.Write release logic and release data
*/
int main(int argc, char *argv[])
{

    setlocale(LC_ALL, "");
    ROS_INFO("This is the publisher of the message")
    // 2.Initialize the ROS node
    ros::init(argc, argv, "banZhuRen");
    // 3.Create a node handle
    ros::NodeHandle nh;
    // 4.Create a publisher object
    ros::Publisher pub = nh.advertise<plumbing_pub_sub::Person>("liaoTian", 10);
    // 5.Write release logic and release data
    // 5-1.Create published data
    plumbing_pub_sub::Person person;
    person.name = "single";
    person.age = 1;
    person.height = 1.73;
    // 5-2.Setting the publication frequency

    ros::Rate rate(1);
    // 5-3.Circular release the data
    while(ros::ok())
    {
        person.age += 1;
        pub.publish(person);
        ROS_INFO("Published message:%s,%d,%.2f", person.name.c_str(), person.age, person.height);
        rate.sleep();
        ros::spinOnce();
    }
    return 0;
}
```


`CMakeLists.txt`


```cmake
add_executable(demo03_pub_person src/demo03_pub_person.cpp)
target_link_libraries(demo03_pub_person ${catkin_LIBRARIES})
add_dependencies(demo03_pub_person ${PROJECT_NAME}_generate_messages_cpp)
```


```plaintext
souce ./devel/setup.bash
rostopic echo liaoTian
```


`demo04_sub_person.cpp`


```c++
#include "ros/ros.h"
#include "plumbing_pub_sub/Person.h"

/*
	Subscriber:Subscribes to message
		1.Include header files
			#include "plumbing_pub_sub/Person.h"
		2.Initialize the ROS node
		3.Create a node handle
		4.Create a subsriber object
		5.Process subscription data
		6.Call the 'spin()' function
*/
void doPerson(const plumbing_pub_sub::Person::ConstPtr& person)
{
    ROS_INFO("Subscriber information:%s,%d,%.2f", person->name.c_str(), person->age, person->height)
}
int main(int argc, char *argv[])
{
    setlocale(LC_ALL, "");
    ROS_IFNO("Subscriber implementation");
   // 2.Initialize the ROS node
    ros::init(argc, argv, "jiaZhang");
    // 3.Create a node handle
    ros::NodeHandle nh;
    // 4.Create a subsriber object
    ros::Subscriber sub = nh.subscribe("liaoTian", 10, doPerson);
    ros::spin();
	return 0;
}
```


`CMakeLists.txt`


```cmake
add_executable(demo04_sub_person src/demo04_sub_person.cpp)
add_dependencies(demo04_sub_person ${PROJECT_NAME}_generate_messages_cpp)
target_link_libraries(demo04_sub_person ${catkin_LIBRARIES})
```


`rqt_graph`


---


`AddInts.srv`


```c
int32 numl1
int32 numl2
---
int32 sum
```


`package.xml`


```xml
<bulid_depend>message_generation</bulid_depend>
<exec_depend>message_runtime</exec_depend>
```


`CMakeLists.txt`


```cmake
find_package(catkin REQUIRED COMPONENTS
	roscpp
	rospy
	std_msgs
	message_generation
)

add_service_files(
    FILES
    AddInts.srv
)

generate_messages(
	DEPENDENCIES
	std_msgs
)

catkin_package(
CATKIN_DEPENDA roscpp rospy std_msgs message_runtime
)
```


`demo01_server.cpp`


```c++
#include "ros/ros.h"
#include "plumbing_server_client/ADDInts.h"

/*
	Server-side implementation:parses the data submitted by the client, calculates and generates a response


*/
bool doNums(plumbing_server_client::AddInts::Request &request,
            plumbing_server_client::AddInts::Response &response)
{
    int num1 = request.num1;
    int num2 = request.num2;
    ROS_INFO("Request data received:num1 = %d, num2 = %d", num1,  num2);
    int sum = num1 + num2;
    response.sum = sum;
    ROS_INFO("Sum result: sum = %d", sum);
    return true;
}
int main(int argc, char *argv[])
{
    setlocale(LC_ALL,"");
    ros::init(argc, argv, "heiShui");
    ros::NodeHandle nh;
    ros::ServiceServer server = nh.advertiseService("addInts", doNums);
    ros::spin();

}
```


`CMakeLists.txt`


```cmake
add_executable(demo01_server src/demo01_server.cpp)
add_dependencies(demo01_server ${PROHECT_NAME}_gencpp)
target_link_libraries(demo01_server
	${catkin_LIBRARIES}
)
```


```xml
<robot name = "mycar">
	<link name = "base_footprint">
		<visual>
			<geometry>
				 <box size = "0.0001 0.0001 0.0001" />
				<!-- <cylinder radius = "0.1" length = "2"/> -->
				<!-- <sphere radius = "1" /> -->
			</geometry>

		</visual>
	</link>


	<link name = "base_link">
		<visual>
			<geometry>
				 <box size = "0.3 0.2 0.1" />
				<!-- <cylinder radius = "0.1" length = "2"/> -->
				<!-- <sphere radius = "1" /> -->
			</geometry>
			<origin xyz = "0 0 0" rpy = "0 0 0"/>
			<material name = "car_color">
				<color rgba = "0.5 0.3 0.7 0.5"/>
			</material>

		</visual>
	</link>
	<link name = "camera">
		<visual>
			<geometry>
				 <box size = "0.02 0.05 0.05" />
				<!-- <cylinder radius = "0.1" length = "2"/> -->
				<!-- <sphere radius = "1" /> -->
			</geometry>
			<origin xyz = "0 0 0.025" rpy = "0 0 0"/>
			<material name = "camare_color">
				<color rgba = "0.7 0.2 0.3 0.5"/>
			</material>

		</visual>
	</link>
	<joint name = "link2footprint" type = "fixed">
		<parent link = "base_footprint"/>
		<child link = "base_link"/>
		<origin xyz = "0 0 0.05" rpy = "0 0 0"/>

	</joint>
	<joint name = "camera2base" type = "continuous">
		<parent link = "base_link"/>
		<child link = "camera"/>
		<origin xyz = "0.12 0 0.05" rpy = "0 0 0"/>
		<axis xyz = "0 0 1"/>
	</joint>
</robot>

```