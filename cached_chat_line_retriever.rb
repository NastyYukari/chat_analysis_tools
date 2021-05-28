class CachedChatLineRetriever
  def initialize(video_id)
    @video_id = video_id
  end

  def read_chat_lines_from_cache_or_download_a_copy_and_cache
    if cached_file_exists?
      detect_empty_files

      return read_cached_file
    end

    download_chat_lines_from_url.tap do |downloaded_chat_lines_from_url|
      File.write(yah_chat_cache_filename, downloaded_chat_lines_from_url)
    end
  end

  private

  def detect_empty_files
    return unless read_cached_file.lines.empty?

    puts("Consider removing or disallowing the URL for this file: #{yah_chat_cache_filename}")
  end

  def cached_file_exists?
    File.exists?(yah_chat_cache_filename)
  end

  def read_cached_file
    @read_cached_file ||= File.read(yah_chat_cache_filename)
  end

  def write_data_into_cached_file(downloaded_chat_lines_from_url)
    File.write(yah_chat_cache_filename, downloaded_chat_lines_from_url)
  end

  def download_chat_lines_from_url
    `chat_downloader https://www.youtube.com/watch?v=#{@video_id} --message_groups "messages, superchat"`
  end

  def yah_chat_cache_filename
    @yah_chat_cache_filename ||= yah_chat_cache_filename_calculator.filename
  end

  def yah_chat_cache_filename_calculator
    YahChatCacheFilenameCalculator.new(@video_id)
  end

  private

  class YahChatCacheFilenameCalculator
    def initialize(video_id)
      @video_id = video_id
    end

    def filename
      @filename ||= "yah.cache/#{@video_id}.yah.txt"
    end
  end
end
