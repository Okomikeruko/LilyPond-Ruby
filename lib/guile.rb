require 'ffi'

module Guile
  extend FFI::Library

  # Load the Guile shared library
  ffi_lib 'libguile-2.2.so.1'

  # Define the Guile functions we want to call
  attach_function :scm_init_guile, [:int], :void
  attach_function :scm_c_eval_string, [:string], :void
end

# Initialize Guile
Guile.scm_init_guile(0)

# Evaluate a Guile script
Guile.scm_c_eval_string('(display "Hello, Guile!")')
puts "\n"