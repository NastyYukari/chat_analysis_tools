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
