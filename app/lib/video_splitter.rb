class VideoSplitter


  def initialize(file = 'sample_1.mp4')
    @video_file = cv::VideoCapture.new(video_path(file))
    @output_path = output_path(file)
    @frame = cv::Mat.new
    setup_file_attributes
  end

  def setup_file_attributes
    @total_frames = @video_file.get(CV_CAP_PROP_FRAME_COUNT).to_i
    @fps = @video_file.get(CV_CAP_PROP_FPS);
  end

  def split_video_to_frames
    for i in 0...@total_frames
      grab = @video_file.grab
      output = @video_file.retrieve(@frame)
      break unless output || grab
      write_frame_to_file(@frame,frame_name(i))
    end
  end

  def write_frame_to_file(frame,frame_name)
    file_name = File.join(@output_path,frame_name)
    cv::imwrite(file_name,frame)
  end

  def frame_name(number)
  	 "frame_#{number}_#{Time.now.strftime('%Y%m%d%H%M%S%L')}.jpg"
  end

  def video_path(file)
    AssetHelper.assets_path(file,'videos')
  end

  def output_path(file)
    output_path ||=FileUtils.mkdir_p AssetHelper.assets_path("output/#{file.gsub('.','_')}",'videos')
    output_path
  end
  
end