require_relative '../chat_event'

module Superchat
  class Message < ::ChatEvent
    def initialize(based_person, currency, amount)
      @based_person = based_person
      @currency = currency
      @amount = amount
    end

    attr_accessor :based_person, :currency, :amount
  end
end
