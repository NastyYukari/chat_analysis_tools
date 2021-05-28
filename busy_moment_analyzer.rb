class BusyMomentAnalyzer
  def initialize(extracted_chat_events)
    @extracted_chat_events = extracted_chat_events
  end

  def analyze
    extract_busy_moment_chains.tap do |busy_moment_collection|
      puts "*Overall length: #{filter_by_length(busy_moment_collection).length}*"

      filter_by_length(busy_moment_collection).each do |busy_moments_chain|
        puts("Starting at: #{busy_moments_chain.first.timestamp}")
        puts("Length: #{busy_moments_chain.size}")
        puts("Sample of comments: ")
        pp(busy_moments_chain.map(&:rest_of_message))
        puts("Ending at: #{busy_moments_chain.last.timestamp}")
        puts "========"
      end
    end
  end

  private

  def filter_by_length(busy_moment_collection)
    busy_moment_collection.select { |busy_moments_chain| busy_moments_chain.length > 3 }
  end

  def extract_busy_moment_chains
    @extracted_chat_events
      .select { |chat_event| chat_event.is_a? YoutubeChatMessage }
      .each_cons(2)
      .reduce([[]]) do |collection_so_far, next_pair|
        ChainAdder.new(collection_so_far, next_pair).add
      end
  end

  class ChainAdder
    def initialize(existing_chains, next_pair)
      @existing_chains = existing_chains
      @next_pair = next_pair
    end

    def add
      if events_of_next_pair_are_at_least_a_second_apart? && next_event_succeeds_last_event_in_last_chain?
        push_new_event_to_last_chain
      elsif events_of_next_pair_are_at_least_a_second_apart?
        push_next_neighboring_events_to_existing_chains
      else
        @existing_chains
      end
    end

    private

    def push_new_event_to_last_chain
      @existing_chains[0, @existing_chains.size - 1].push(last_chain + [@next_pair.last])
    end

    def push_next_neighboring_events_to_existing_chains
      @existing_chains + [@next_pair]
    end

    def events_of_next_pair_are_at_least_a_second_apart?
      @next_pair.map(&:time_components_to_seconds_offset).reduce(:-) >= -1
    end

    def next_event_succeeds_last_event_in_last_chain?
      last_chain.last == @next_pair.first
    end

    def last_chain
      @existing_chains.last
    end
  end
end
