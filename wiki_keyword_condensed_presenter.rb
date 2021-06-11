class WikiKeywordCondensedPresenter
  def initialize(stream_chat_events)
    @stream_chat_events = stream_chat_events
  end

  def present
    @stream_chat_events.group_by(&:video_identifier).each do |video_identifier, stream_chat_events_for_video|
      present_stream_chat_events_for_video(video_identifier, stream_chat_events_for_video)
    end
  end

  private

  def present_stream_chat_events_for_video(video_identifier, stream_chat_events_for_video)
    puts("Displaying instances for #{video_identifier}")

    stream_chat_events_for_video.map(&:chat_event).each do |chat_event|
      puts("[#{chat_event.timestamp}] #{chat_event.rest_of_message}")
    end
  end
end
