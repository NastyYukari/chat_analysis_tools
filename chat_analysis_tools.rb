# Calculates every Streamlabs donation given during a public stream.

# .python-version 3.9.5
# .ruby-version 2.7.2

require 'bigdecimal'
require_relative 'chat_event_reader'
require_relative 'cached_chat_line_retriever'
require_relative 'video_identifiers'
require_relative 'busy_moment_analyzer'
require_relative 'stream_labs/total_stats_analyzer'
require_relative 'stream_labs/person_specific_stats_analyzer'
require_relative 'superchat/breakdown_by_currency_analyzer'

def run_stats(extracted_chat_events)
  # StreamLabs::TotalStatsAnalyzer.new(extracted_chat_events).analyze
  # Superchat::BreakdownByCurrencyAnalyzer.new(extracted_chat_events).analyze
  BusyMomentAnalyzer.new(extracted_chat_events).analyze
end

def extract_all_donos_from_public_stream_urls
  VIDEO_IDENTIFIERS
    .map do |video_id|
      donos_from_chat_lines_string(
        read_chat_lines_from_cache_or_download_a_copy_and_cache(video_id)
      )
    end
    .reduce(:+)
end

def donos_from_chat_lines_string(string)
  ChatEventReader.new(string.split("\n")).extract_donos_from_serialized_chat_lines
end

def read_chat_lines_from_cache_or_download_a_copy_and_cache(video_id)
  CachedChatLineRetriever
    .new(video_id)
    .read_chat_lines_from_cache_or_download_a_copy_and_cache
end

run_stats(extract_all_donos_from_public_stream_urls)
