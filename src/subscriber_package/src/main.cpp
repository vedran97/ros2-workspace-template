#include "rclcpp/rclcpp.hpp"

#include "topic_package/msg/next_position.hpp"

using std::placeholders::_1;

class MinimalSubscriber : public rclcpp::Node
{
  public:
  using NextPositionData= topic_package::msg::NextPosition;
    MinimalSubscriber()
    : Node("CustomTopicSubscriber")
    {
      subscription_ = this->create_subscription<NextPositionData>(
      NextPositionData::TOPIC_NAME, 10, std::bind(&MinimalSubscriber::topic_callback, this, _1));
    }

  private:
    void topic_callback(const NextPositionData::SharedPtr msg) const
    {
      RCLCPP_INFO(this->get_logger(), "I received: %f", msg->current_angle);
    }
    rclcpp::Subscription<NextPositionData>::SharedPtr subscription_;
};

int main(int argc, char const *argv[])
{
    rclcpp::init(argc, argv);
    rclcpp::spin(std::make_shared<MinimalSubscriber>());
    rclcpp::shutdown();
    return 0;
}