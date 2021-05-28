require_relative '../chat_event'

module StreamLabs
  class DonationMessage < ::ChatEvent
    def initialize(based_person, pig_dollars)
      @based_person = based_person
      @pig_dollars = pig_dollars
    end

    attr_accessor :based_person, :pig_dollars
  end
end
