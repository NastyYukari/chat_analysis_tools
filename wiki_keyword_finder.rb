class WikiKeywordFinder
  def initialize(stream_chat_events, keywords)
    @stream_chat_events = stream_chat_events
    @keywords = keywords
  end

  def analyze
    @keywords
      .flat_map(&method(:all_instances_of_keyword_in_stream_chat_events))
      .reject(&:nil?)
  end

  private

  def first_instance_of_keyword_in_stream_chat_events(keyword)
    @stream_chat_events
      .detect { |stream_chat_event| message_includes_keyword?(keyword, stream_chat_event.message) }
  end

  def all_instances_of_keyword_in_stream_chat_events(keyword)
    @stream_chat_events
      .select { |stream_chat_event| message_includes_keyword?(keyword, stream_chat_event.message) }
  end

  def message_includes_keyword?(keyword, message)
    message.downcase.include?(keyword.downcase)
  end
end
