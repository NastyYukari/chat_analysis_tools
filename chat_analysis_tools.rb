# Calculates every Streamlabs donation given during a public stream.

# .python-version 3.9.5
# .ruby-version 2.7.2

require 'bigdecimal'
require_relative 'stream_chat_event'
require_relative 'chat_event_reader'
require_relative 'cached_chat_line_retriever'
require_relative 'video_identifiers'
require_relative 'busy_moment_analyzer'
require_relative 'wiki_keyword_finder'
require_relative 'stream_labs/total_stats_analyzer'
require_relative 'stream_labs/person_specific_stats_analyzer'
require_relative 'superchat/breakdown_by_currency_analyzer'

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

WikiKeywordFinder.new(extract_all_stream_chat_events).analyze
BusyMomentAnalyzer.new(extract_all_chat_events_from_public_stream_urls).analyze
