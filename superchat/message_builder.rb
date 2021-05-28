require_relative 'message'

module Superchat
  class MessageBuilder
    def initialize(serialized_chat_line)
      @serialized_chat_line = serialized_chat_line
    end

    def self.matches_general_format?(serialized_chat_line)
      serialized_chat_line.match?(LAZY_DETECTOR)
    end

    def build_message
      build_message_from_matches(retrieve_matches_from_serialization)
    end

    private

    LAZY_DETECTOR = /\A.* \| \*(.*\..*)\* .*/.freeze
    EXTRACTING_DETECTOR = /\A.* \| \*(?<currency_prefix>\D*)(?<amount>\d*,?\d*\.\d\d)\* (?<rest_of_message>.*)/.freeze

    def build_message_from_matches(match_data_from_serialization)
      Superchat::Message.new(match_data_from_serialization[:rest_of_message].split(':').first,
                             match_data_from_serialization[:currency_prefix].strip,
                             BigDecimal(match_data_from_serialization[:amount].gsub(',', '')))
    end

    def retrieve_matches_from_serialization
      @serialized_chat_line.match(EXTRACTING_DETECTOR)
    end
  end
end
