class WikiKeywordBrutePresenter
  def initialize(chat_events)
    @stream_chat_events = stream_chat_events
  end

  def present
    @stream_events.map(&method(:pp))
  end
end
