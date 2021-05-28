require_relative 'donation_message'

module StreamLabs
  class DonationMessageBuilder
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

    LAZY_DETECTOR = /\A.*\| \(Verified\, Moderator\) Streamlabs\: .* just tipped/.freeze

    EXTRACTING_DETECTOR =
      /\A.*\| \(Verified\, Moderator\) Streamlabs\: (?<based_person>.*) just tipped \$(?<pig_dollars>.*) dayo!/.freeze

    def build_message_from_matches(match_data_from_serialization)
      StreamLabs::DonationMessage.new(match_data_from_serialization[:based_person],
                                      BigDecimal(match_data_from_serialization[:pig_dollars]))
    end

    def retrieve_matches_from_serialization
      @serialized_chat_line.match(EXTRACTING_DETECTOR)
    end
  end
end
