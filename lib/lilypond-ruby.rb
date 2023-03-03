require "open3"

class LilyPond
  class << self

    def version
      output, error, status = Open3.capture3("bin/lilypond", "--version")
      if status.success?
        puts output
      else
        puts error
      end
    end

    def generate_pdf_with_lilypond(file_name, lilypond_code)
      Open3.popen3('bin/lilypond', '--pdf', file_name) do |stdin, stdout, stderr, wait_thr|
        # Write the Lilypond code to stdin
        stdin.write(lilypond_code)
        stdin.close

        # Wait for the process to complete
        Process.detach(wait_thr.pid)

        # Read and process the output and error streams
        loop do
          # Wait for output to become available for reading
          ready = IO.select([stdout, stderr])
          next unless ready

          # Read available data from the streams
          ready[0].each do |stream|
            data = stream.read_nonblock(1024)
            puts data # or process the data as necessary
          end
        rescue IO::WaitReadable, IO::WaitWritable
          # Continue waiting if the streams are not yet ready
          IO.select([stdout, stderr])
          retry
        rescue EOFError
          # Stop waiting if the streams have been closed
          break
        end
      end
    end

  end # end self
end # end LilyPond