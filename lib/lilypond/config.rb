require_relative "../lilypond-ruby.rb"

module LilyPond
  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
    yield(@configuration) if block_given?
    @configuration
  end

  class Configuration
    attr_accessor :default_output, :destination_directory, :lilypond_path

    def initialize
      @default_output = :pdf
      @destination_directory = "."
      @lilypond_path = File.expand_path("../../../lilypond-2.24.1/bin/lilypond", __FILE__)
    end
  end
end