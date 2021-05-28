module StreamLabs
  class PersonSpecificStatsAnalyzer
    def initialize(extracted_donos)
      @extracted_donos = extracted_donos
    end

    def analyze
      puts("Streamlabs breakdown by based person")

      @extracted_donos
        .select { |dono| dono.is_a? StreamLabs::DonationMessage }
        .group_by(&:based_person)
        .sort_by { |_, donos_by_based_person| donos_by_based_person.map(&:pig_dollars).reduce(:+) }
        .reverse
        .each do |based_person, donos|
          puts("#{based_person}: $#{'%.2f' % donos.map(&:pig_dollars).reduce(:+).to_s('F')} pig doru")
        end
    end
  end
end
