require_relative 'chat_event'

class YoutubeChatMessage < ::ChatEvent
  def initialize(timestamp, time_component_strings, rest_of_message)
    @timestamp = timestamp
    @time_component_strings = time_component_strings
    @rest_of_message = rest_of_message
  end

  def time_components_to_seconds_offset
    (time_components[0] * 60 * 60) + (time_components[1] * 60) + time_components[2]
  end

  attr_reader :timestamp, :time_component_strings, :rest_of_message

  private

  def time_components
    normalized_time_components.map(&:to_i)
  end

  def normalized_time_components
    return @time_component_strings unless @time_component_strings.size == 2

    [0, *@time_component_strings]
  end
end
