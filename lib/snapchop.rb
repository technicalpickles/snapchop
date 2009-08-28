module SnapChop
  extend self

  def run(options)
    options[:codec] ||= "png"

    arguments = binary_arguments(options)
    execute_binary(arguments)
  end

  def binary_arguments(options)
    [
      "-i #{options[:input]}",      # input file
      options[:force] ? "-y" : nil, # overwrite output file
      "-vcodec #{options[:codec]}", # specify output format
      "-vframes 1",                 # take one frame
      "-an",                        # disable audio recording
      "-f rawvideo",                # force format to rawvideo
      options[:output]              # output file
    ].compact
  end

  def execute_binary(arguments)
    `ffmpeg #{arguments.join(' ')} >/dev/null 2>&1`
  end
end
