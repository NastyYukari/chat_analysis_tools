require_relative 'stream_labs/donation_message_builder'
require_relative 'superchat/message_builder'
require_relative 'youtube_chat_message_builder'

class ChatEventReader
  def initialize(serialized_chat_lines)
    @serialized_chat_lines = serialized_chat_lines
  end

  def extract_chat_events_from_serialized_chat_lines
    @serialized_chat_lines.map(&method(:build_chat_event)).reject(&:nil?)
  end

  private

  def build_chat_event(serialized_chat_line)
    return unless only_one_pipe_character?(serialized_chat_line)

    if StreamLabs::DonationMessageBuilder.matches_general_format?(serialized_chat_line)
      return StreamLabs::DonationMessageBuilder.new(serialized_chat_line).build_message
    end

    if Superchat::MessageBuilder.matches_general_format?(serialized_chat_line)
      return Superchat::MessageBuilder.new(serialized_chat_line).build_message
    end

    YoutubeChatMessageBuilder.new(serialized_chat_line).build_message
  end

  def only_one_pipe_character?(serialized_chat_line)
    serialized_chat_line.chars.count('|') == 1
  end
end
