module LilyPond
  class Builder
    def book
    end

    def bookpart
    end

    def header
    end

    def score
    end

    def staffgroup(type)
    end

    def staff
    end

    def voice
    end

    def music_block
    end

    def lyric_block
    end

    def layout
    end

    def midi
    end

    def to_s
    end

    def write(filename)
    end
  end
end

class MyBuilder < LilyPond::Builder
  def initialize
    @buffer = ''
  end

  def book
    @buffer << "% #{book.name} \n"
    @buffer << "\\book { \n"
    yield
    @buffer << "} \n"
  end
end