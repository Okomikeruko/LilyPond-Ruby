Gem::Specification.new do |s|
  s.name        = "LilyPond-Ruby"
  s.version     = "0.0.2.beta"
  s.summary     = "Access and control Lilypond from within Ruby"
  s.description = "This gem provides a library to access and control Lilypond from Ruby"
  s.authors     = ["Lee Whittaker"]
  s.email       = "whittakerlee81@gmail.com"
  s.files       = Dir["lib/**/*.rb", "bin/*"]
  s.executables << "lilypond"
  s.homepage    = "https://github.com/Okomikeruko/LilyPond-Ruby"
  s.license     = "MIT"
end