class BgSub

  attr_accessor :frame, :fgMaskMOG, :fgMaskMOG2, :pMOG, :pMOG2, :frames_dir, :output_dir

  def initialize(dir = 'sample_1_mp4')
    #depends on openCV installation so copied into the directory for easier access
    @frame = cv::Mat.new
    @fgMaskMOG = cv::Mat.new
    @fgMaskMOG2 = cv::Mat.new
    # @pMOG = ::BackgroundSubtractorMOG.new
    # @pMOG2 = ::BackgroundSubtractorMOG2.new
    @frames_dir = AssetHelper.assets_path("output/#{dir}",'images')
    @output_dir = AssetHelper.output_dir_filepath("#{dir}", 'images')
    @pMOG = cv::BackgroundSubtractor.new
    @pMOG2 = cv::BackgroundSubtractor.new
  end


  def detect

    Dir.glob("#{frames_dir}/*.jpg") do |file|
      frame = cv::imread(file)
      pMOG.apply(frame,gfMaskMOG)
      AssetHelper.write_frame_to_file(gfMaskMOG,"#{File.basename(file)}_subMOG",output_dir)
      pMOG2.apply(frame,gfMaskMOG2)
      AssetHelper.write_frame_to_file(gfMaskMOG2,"#{File.basename(file)}_subMOG2",output_dir)
    end
  end


end