require_relative 'youtube_chat_message'

class YoutubeChatMessageBuilder
  def initialize(serialized_chat_line)
    @serialized_chat_line = serialized_chat_line
  end

  def build_message
    build_message_from_matches(retrieve_matches_from_serialization)
  end

  private

  EXTRACTING_DETECTOR = /\A(?<timestamp>.*) \| (?<rest_of_message>.*)/.freeze

  def build_message_from_matches(match_data_from_serialization)
    YoutubeChatMessage.new(match_data_from_serialization[:timestamp],
                           match_data_from_serialization[:timestamp].split(':'),
                           match_data_from_serialization[:rest_of_message])
  end

  def retrieve_matches_from_serialization
    @serialized_chat_line.match(EXTRACTING_DETECTOR)
  end
end
