module StreamLabs
  class TotalStatsAnalyzer
    def initialize(extracted_donos)
      @extracted_donos = extracted_donos
    end

    def analyze
      @extracted_donos
        .select { |dono| dono.is_a? StreamLabs::DonationMessage }
        .map(&:pig_dollars)
        .reduce(:+)
        .tap do |pig_dollars|
          puts("Streamlabs Total: $#{display_pig_dollars_as_currency pig_dollars} pig doru "\
               "(#{display_pig_dollars_as_currency(in_jpy(pig_dollars))}円)")
        end
    end

    private

    def display_pig_dollars_as_currency(pig_dollars)
      '%.2f' % pig_dollars
    end

    def in_jpy(pig_dollars)
      ::CurrencyForVideoCalculator.new(pig_dollars, '$').calculate
    end
  end
end
