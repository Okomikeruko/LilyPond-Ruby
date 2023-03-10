# LilyPond Ruby
[![Gem Version](https://badge.fury.io/rb/LilyPond-Ruby.svg)](https://badge.fury.io/rb/LilyPond-Ruby)
[![GitHub version](https://badge.fury.io/gh/Okomikeruko%2FLilyPond-Ruby.svg)](https://badge.fury.io/gh/Okomikeruko%2FLilyPond-Ruby)

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

## Configuration
I built this gem with Rails in mind, so in my app's `config/initializers` directory
I added the `lilypond.rb`file with the following information:

```ruby
require "lilypond-ruby"

LilyPond.configuration do |config|
  config.default_output = :pdf # options: [:pdf, :svg, :png]
  config.destination_directory = "storage/lilypond" # (TODO: make this work)
  config.lilypond_path = File.expand_path("../../../lilypond-2.24.1/bin/lilypond", __FILE__) # wherever your LilyPond installation is.
end
```

## Usage

Here's an example of how to use LilyPond Ruby to generate a PDF file from a LilyPond file:
```ruby
require 'lilypond-ruby'

lilypond_code = File.read('score.ly')
file_name = 'score.ly'

LilyPond.generate_pdf_with_lilypond(file_name, lilypond_code)
```

## Contributing
Bug reports and pull requests are welcome on GitHub at
https://github.com/Okomikeruko/LilyPond-Ruby. This project is intended to be a
safe, welcoming space for collaboration, and contributors are expected to adhere
to the [Contributor Covenant](https://www.contributor-covenant.org/)
code of conduct.

## License
The gem is available as open source under the terms of the
[MIT License](https://opensource.org/licenses/MIT).