require_relative '../currency_for_video_calculator'

module Superchat
  class BreakdownByCurrencyAnalyzer
    def initialize(extracted_donos)
      @extracted_donos = extracted_donos
    end

    def analyze
      puts("Superchat breakdown by currency")

      @extracted_donos
        .select { |dono| dono.is_a? Superchat::Message }
        .group_by(&:currency)
        .each do |currency, donos|
          total_dono = sum_dono_amount(donos)
          total_dono_in_jpy = in_jpy(total_dono, currency)
          puts("Total by currency type #{currency}: #{currency}#{amount_in_currency_format(total_dono)} "\
               "(#{amount_in_currency_format(total_dono_in_jpy)}円)")
        end
    end

    private

    def in_jpy(amount, currency)
      ::CurrencyForVideoCalculator.new(amount, currency).calculate
    end

    def sum_dono_amount(donos)
      donos.map(&:amount).reduce(:+)
    end

    def amount_in_currency_format(amount)
      '%.2f' % amount.to_s("F")
    end
  end
end
