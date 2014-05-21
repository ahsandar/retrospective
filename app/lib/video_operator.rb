class VideoOperator
 
 attr_accessor :video_file, :output_dir_path, :cmd, :fps

  def initialize(file = 'sample_1.mp4')
    @video_file = video_path(file)
    @output_dir_path = AssetHelper.output_dir_filepath(file)
    @cmd = CommandService.new
    @fps = 1
  end

  
  def split_video_to_frames
    #ffmpeg -i Video.mpg Pictures%d.jpg
    cmd << 'ffmpeg'
    cmd << '-i'
    cmd << video_file
    cmd << '-r 4' 
    cmd << output_file_path
    start_time = Time.now
    cmd.execute!
    end_time = Time.now
    puts end_time - start_time
  end

  def frames_per_sec
    puts 'getting fps'
    ffprobe(video_file) do |output|
      puts output
      @fps = extract_fps(output)
   end
   puts fps
  end

  def ffprobe(video_file, &block)
    cmd << 'ffprobe'
    cmd << video_file
    output = cmd.execute!
    yield output if block_given?
  end
   
   def extract_fps(output)
    fps_regex = /(\d*\D*\d*)\D*fps/
    result = output.match(fps_regex)
    puts result.inspect
    result[1]
   end

  def frame_name
  	 "frame_%d_#{Time.now.strftime('%Y%m%d%H%M%S%L')}.jpg"
  end

  def output_file_path
    File.join(output_dir_path,frame_name)
  end

  def video_path(file)
    AssetHelper.assets_path(file,'videos')
  end

  
  
end