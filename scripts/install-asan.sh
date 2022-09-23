#! /bin/sh

colcon mixin add default https://raw.githubusercontent.com/colcon/colcon-mixin-repository/master/index.yaml
colcon mixin update default

git clone https://github.com/colcon/colcon-sanitizer-reports.git
cd colcon-sanitizer-reports
python3 setup.py install

cd ../ 

rm -rf colcon-sanitizer-reports