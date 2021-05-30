require_relative 'chat_event'

class StreamChatEvent
  def initialize(video_identifier, chat_event)
    @video_identifier = video_identifier
    @chat_event = chat_event
  end

  attr_reader :video_identifier

  def message
    @chat_event.rest_of_message
  end
end
