class WikiKeywordFinder
  def initialize(stream_chat_events)
    @stream_chat_events = stream_chat_events
  end

  def analyze
    KEYWORDS
      .map(&method(:first_instance_of_keyword_in_stream_chat_events))
      .reject(&:nil?)
      .each(&method(:pp))
  end

  private

  KEYWORDS = [
    "balon",
    "baron",
    "burger",
    "caniko",
    "canned water",
    "cunnyko",
    "funny water",
    "hazukashiful",
    "kaniko",
    "kichigai stalker",
    "kichigai",
    "menhera stalker",
    "menhera",
    "menhera",
    "muzukashiful",
    "onions",
    "pregnancy",
    "pregnant",
    "remote kid",
    "remote",
    "soy",
    "soylent",
    "stalker",
    "tabun maybe",
    "tabun",
    "wiki anon",
    "wiki",
    "wikianon"
  ].sort.freeze

  def first_instance_of_keyword_in_stream_chat_events(keyword)
    @stream_chat_events
      .detect { |stream_chat_event| message_includes_keyword?(keyword, stream_chat_event.message) }
  end

  def message_includes_keyword?(keyword, message)
    message.downcase.include?(keyword.downcase)
  end
end
