# LilyPond Ruby
LilyPond Ruby is a Ruby library for controlling LilyPond, a music notation
software. It allows LilyPond files, compile them into various formats
(such as PDF or MIDI), and access LilyPond's various functions and features
through Ruby code.

## Installation
To install LilyPond Ruby, run the following command:
```
gem install LilyPond-Ruby
```
Or add this line to your application's Gemfile:
```
gem "LilyPond-Ruby"
```
And then execute:
```
bundle install
```

## Usage
Here's an example of how to use LilyPond Ruby to genearate a PDF file from a
LilyPond file:
```
require 'lilypond-ruby'
lilypond_file = IO.open("score.ly")
file_name = "score"

LilyPond.generate_pdf_with_lilypond(file_name, lilypond_file)
```

## Contributing
Bug reports and pull requests are welcome on GitHub at
https://github.com/your_username/RubyLy. This project is intended to be a safe,
welcoming space for collaboration, and contributors are expected to adhere
to the [Contributor Covenant](https://www.contributor-covenant.org/)
code of conduct.

## License
The gem is available as open source under the terms of the
[MIT License](https://opensource.org/licenses/MIT).