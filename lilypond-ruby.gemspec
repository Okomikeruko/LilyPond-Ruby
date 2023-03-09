Gem::Specification.new do |s|
  s.name        = "LilyPond-Ruby"
  s.version     = "0.1.4.6"
  s.summary     = "Access and control Lilypond from within Ruby"
  s.description = <<~END_OF_STRING
    This gem provides a library to access and control Lilypond within Ruby.
    It contains the libraries and binary files for LilyPond 2.24.1 and
    Guile 2.2.3. \n\n
    It also provides a builder tool for generating LilyPond files dynamically
    with Ruby.
  END_OF_STRING
  s.authors     = ["Lee Whittaker"]
  s.email       = "whittakerlee81@gmail.com"
  s.files       = Dir["lib/**/*.rb", "lilypond-2.24.1/**/*"]
  s.homepage    = "https://github.com/Okomikeruko/LilyPond-Ruby"
  s.license     = "MIT"

  s.add_runtime_dependency "ffi", '~> 1.15', '>= 1.15.5'
end