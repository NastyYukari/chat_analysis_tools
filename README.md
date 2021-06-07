Sample usage.
```ruby
require_relative 'chat_analysis_tools'

def extract_all_chat_events_from_public_stream_urls
  VIDEO_IDENTIFIERS.map(&method(:extract_chat_events_for_video)).reduce(:+)
end

def extract_all_stream_chat_events
  VIDEO_IDENTIFIERS
    .map do |video_identifier|
      [video_identifier,
       extract_chat_events_for_video(video_identifier).select { |chat_event| chat_event.is_a?(YoutubeChatMessage) }]
    end
    .flat_map do |video_identifier, chat_events|
      chat_events.map { |chat_event| StreamChatEvent.new(video_identifier, chat_event) }
    end
end

def extract_chat_events_for_video(video_id)
  chat_events_from_chat_lines_string(read_chat_lines_from_cache_or_download_a_copy_and_cache(video_id))
end

def chat_events_from_chat_lines_string(string)
  ChatEventReader.new(string.split("\n")).extract_chat_events_from_serialized_chat_lines
end

def read_chat_lines_from_cache_or_download_a_copy_and_cache(video_id)
  CachedChatLineRetriever
    .new(video_id)
    .read_chat_lines_from_cache_or_download_a_copy_and_cache
end

WIKI_KEYWORDS = [
  "balon",
  "baron",
].sort.freeze

WikiKeywordFinder.new(extract_all_stream_chat_events, WIKI_KEYWORDS).analyze
BusyMomentAnalyzer.new(extract_all_chat_events_from_public_stream_urls).analyze
```
