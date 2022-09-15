#include <chrono>
#include <functional>
#include <memory>
#include <string>

#include "rclcpp/rclcpp.hpp"

#include "topic_package/msg/next_position.hpp"

using namespace std::chrono_literals;

class CustomTopicPublisher : public rclcpp::Node
{
  public:
  using NextPositionData= topic_package::msg::NextPosition;
    CustomTopicPublisher()
    : Node("CustomTopicPublisher"), count_(0)
    {
      publisher_ = this->create_publisher<NextPositionData>(NextPositionData::TOPIC_NAME, 10);
      timer_ = this->create_wall_timer(
      500ms, std::bind(&CustomTopicPublisher::timer_callback, this));
    }

  private:
    void timer_callback()
    {
      static double location = 12.12212;
      auto message = NextPositionData();
      message.current_angle = location;
      location+=1;
      RCLCPP_INFO(this->get_logger(), "Publishing: %f", message.current_angle);
      publisher_->publish(message);
    }
    rclcpp::TimerBase::SharedPtr timer_;
    rclcpp::Publisher<NextPositionData>::SharedPtr publisher_;
    size_t count_;
};

int main(int argc, char const *argv[])
{
    rclcpp::init(argc, argv);
    rclcpp::spin(std::make_shared<CustomTopicPublisher>());
    rclcpp::shutdown();
    return 0;
}