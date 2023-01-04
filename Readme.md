# Intent of the repository : 

1. I created this repository , so that fellow ros2 developers have access to a dockerized ros2-foxy workspace on an ubuntu 20.04 base.
2. My goal is to include gdb , line coverage , cpp lint , gtest , ros package debian generation and sanitization.
3. This workspace can be minimzed and also be used for pure c++ development, using ros2 as a build and execute system.
4. I have added sample packages for understanding publishing and subscribing to custom ros2 topics.
5. I plan to add sample packages showcasing gtest, action server and other ros2 basics.
6. I might extend it to ros2 galactic, and I think it can be seamlessly done by replacing all references of foxy to galactic in the dockerfile and container setup scripts.

# Initial Setup :

1. Install vs-code editor on your ubuntu 20.04 host OS : https://linuxize.com/post/how-to-install-visual-studio-code-on-ubuntu-20-04/
2. Install docker on your ubuntu 20.04 host OS : https://docs.docker.com/engine/install/ubuntu/
3. Please remember to follow all the steps in docker installation, and verifying it's successful installation @ https://docs.docker.com/engine/install/ubuntu/#next-steps > https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user (Step 1 2 3 4)
4. Install following extensions on your VSCode: 
    1. Docker : https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker
    2. Remote-Containers :  https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers
5. Clone this repository using:
    > ``` git clone https://github.com/vedran97/ros2-workspace-template.git ```
6. From the current working directory, cd to ros2-workspace-template repo which u just cloned
7. Open a terminal in ros2-workspace-template and type 
    > ``` code . ```
8. A VSCode popup should arise which says "Open folder in Container" where you choose Yes OR press F1,search for "Open Folder in Container" and execute the command
9. Now wait for the build process to finish, once it's completed, you have a fully functional ROS2 workspace with example packages
11. When the container is built for the first time, a error will popup saying "Failed to enable ROS Extension" , just choose the reload window option
10. Set up ROS dependencies using the following section

# Setting up ROS-Dependencies :

1. Once the repo is opened in a container, you have to install ROS2-dependencies. To do this, follow these steps:
    1. Press "Ctrl+Shift+B" to run VSCode tasks popup, choose "ROS: Install dependencies" option from it. 
    2. Wait for installation to finish,once it is done, now you can go ahead and install sanitization dependencies

# Setting up Sanitizers :

1. Press "Ctrl+Shift+B" to run VSCode tasks popup, choose "C++: Install Sanitizer dependencies" option from it. 
2. Wait for installation to finish,once it is done, now you can go ahead and build the packages inside the repos
    

# Building Packages : 

1. Press "Ctrl+Shift+B" to run VSCode tasks popup, and select "ROS:Build Package"
2. It will ask you to choose default build configuration, choose one and press enter
3. Then add the exact package name you need to build, and press enter.If u keep it blank, all packages shall build.
4. If the builds complete successfully, you have packages ready to use

# Running Nodes : 

1. Once done building quit the terminal session, open a new terminal instance(Ctrl+Shift+`), which will run ./bashrc configuration again and source all the recently built packages for you 
2. This allows you to directly use "ros2 run package_name node_name" without specifically sourcing anything
3. Enjoy!

# How do you reuse it ? :

1. Once you have cloned this repository and want to use it for your own project , first change this directory's name to whatever you want
2. Change line 55 of Dockerfile `ARG WORKSPACE=/workspaces/ros2-template-workspace` to `ARG WORKSPACE=/workspaces/your_workspace_name`
3. cd to this now renamed directory and delete the git artifacts by `sudo rm -rf .git` and then you are free to initialize your own git repository
4. Follow the  Initial Setup headline's from step 6    
