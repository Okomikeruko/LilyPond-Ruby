require_relative "../lilypond-ruby.rb"

# The LilyPond module provides an interface for generating LilyPond notation.
module LilyPond
  # The Builder class is responsible for building LilyPond notation.
  class Builder
    # Creates a new LilyPond Builder object.
    def initialize
      @buffer = "\\version \"#{LilyPond.version_number}\"\n"
      @indent_level = 0
    end

    # Returns the current indentation level.
    #
    # @return [String] the current indentation level in spaces
    def indent
      " " * @indent_level * 2
    end

    # Generates a block of LilyPond notation.
    #
    # @param name [String] the name of the block
    # @param parallel [Boolean] whether the block should be parallel
    # @param options [Hash] the options for the block
    # @yield the block content
    def block(name = nil, parallel = false, options = {})
      @buffer << "#{indent}"
      @buffer << "\\#{name} " unless name == nil
      if options.any?
        @buffer << "\\with { \n"
        @indent_level +=1
        options.each do |key, value|
          @buffer << "#{indent}#{key.to_s.camelize_lower} = #"
          @buffer << (value.class.name == "String" ? "\"#{value}\"" : "#{value}")
          @buffer << "\n"
        end
        @indent_level -=1
        @buffer << "#{indent}} "
      end
      @buffer << "#{parallel ? "<<" : "{" }"
      if block_given?
        @buffer << "\n"
        @indent_level += 1
        yield
        @indent_level -= 1
        @buffer << "#{indent}#{parallel ? ">>" : "}" }\n"
      else
        @buffer << "#{parallel ? ">>" : "}" }\n"
      end
    end

    # Defines the content for a LilyPond variable.
    #
    # @param variable_name [String] the name of the variable
    # @param lyricmode [Boolean] whether the variable should be in lyric mode
    # @yield the variable content
    def define_content(variable_name = nil, lyricmode = false)
      @buffer << "#{indent}"
      @buffer << "#{variable_name} = " unless variable_name.nil?
      @buffer << "\\lyricmode " if lyricmode
      @buffer << "{\n"
      @indent_level += 1
      yield
      @indent_level -= 1
      @buffer << "}\n"
    end

    # Uses the content of a LilyPond variable.
    #
    # @param variable_name [String] the name of the variable to use
    def use_content(variable_name)
      @buffer << "#{indent}\\#{variable_name}\n"
    end

    # Appends a string of LilyPond notation to the buffer.
    #
    # @param string [String] the LilyPond notation to append
    def append(string)
      @buffer << "#{indent}#{string}\n"
    end

    # Returns the current buffer as a string of LilyPond notation.
    #
    # @return [String] the LilyPond notation buffer
    def to_s
      @buffer
    end

    class << self
      # Generates a sample LilyPond notation.
      #
      # @return [LilyPond::Builder] the LilyPond notation builder
      def sample
        parallel = true
        options = {
          :midi_maximum_volume => 0.4,
          :instrument_name     => "Piano"
        }
        ly = LilyPond::Builder.new

        ly.append "%% MUSIC %%"
        ly.define_content("global") do |global|
          ly.append "\\numericTimeSignature"
          ly.append "\\time 4/4"
          ly.append "s1 * 4 |"
          ly.append "\\bar \"|.\""
        end #global
        ly.define_content("sopranoMusic") do |sopranoMusic|
          ly.append "c'4 d'4 e'4 f'4 |"
          ly.append "c'4 d'4 e'4 f'4 |"
          ly.append "c'4 d'4 e'4 f'4 |"
          ly.append "c'4 d'4 e'4 f'4 |"
        end #sopranoMusic
        ly.append "%% LYRICS %%"
        ly.define_content("sopranoLyrics", true) do |sopranoLyrics|
          ly.append "do re me fa"
          ly.append "do re me fa"
          ly.append "do re me fa"
          ly.append "do re me fa"
        end #sopranoLyrics
        ly.append "%% BOOKS %%"
        ly.block("book") do |book|
          ly.block("score") do |score|
            ly.block(nil, parallel) do |score_content|
              ly.block("new Staff", parallel, options) do |staff|
                ly.block("new Voice", parallel) do |voice|
                  ly.use_content("global")
                  ly.use_content("sopranoMusic")
                end #voice
                ly.block("new Lyrics") do |lyrics|
                  ly.use_content("sopranoLyrics")
                end #lyrics
              end #staff
            end #score_content
            ly.block("midi")
            ly.block("layout")
          end #score
        end #book

        return ly
      end #sample()

    end #self
  end #Builder
end #LilyPond

# Adds a `camelize_lower` method to the String class.
class String
  # Converts an underscored string to camel case, except the first word remains downcase.
  #
  # Examples
  #
  #   "my_foo".camelize_lower #=> "myFoo"
  #
  # @return [String] the camelized string
  def camelize_lower
    self.split('_').map.with_index do |word, i|
      i == 0 ? word.downcase : word.capitalize
    end.join('')
  end
end
