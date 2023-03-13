require "open3"
require "lilypond/builder"
require "lilypond/config"
require "guile"

module LilyPond
  class << self
    def version
      output, error, status = Open3.capture3(path, "--version")
      if status.success?
        puts output
      else
        puts error
      end
    end

    def version_number
      output, error, status = Open3.capture3(path, "--version")
      if status.success?
        return output.match(/GNU LilyPond (\d+\.\d+\.\d+)/)[1]
      else
        return "#{error}"
      end
    end

    # Approved output types: `[:pdf, :svg, :png]` If none is provided, it defaults to
    # LilyPond.configuration.default_output, which initializes as `:pdf`
    def generate_with_lilypond(file_name, lilypond_code, output_type = nil)
      tempfile = Tempfile.new(file_name)
      tempfile.write(lilypond_code)
      tempfile.close
      output_type ||= default_output
      Dir.chdir(destination) do
        Open3.popen3(path, "--#{output_type}", tempfile.path) do |stdin, stdout, stderr, wait_thr|
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
      File.delete(tempfile.path)
    end

    private
      def default_output
        LilyPond.configuration.default_output
      end

      def destination
        LilyPond.configuration.destination_directory
      end

      def path
        LilyPond.configuration.lilypond_path.to_s
      end

  end # end self
end # end LilyPond