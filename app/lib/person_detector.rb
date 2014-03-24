class PersonDetector

  attr_accessor :frames_dir, :output_dir

  def initialize
    @frames_dir = AssetHelper.assets_path("output/sample_1_mp4",'videos') 
    @output_dir = AssetHelper.output_dir_filepath('sample_1', 'images')
  end

  def detect
    Dir.glob("#{frames_dir}/*.jpg") do |file|
    frame = cv::imread(file)
    detector = cv::HOGDescriptor.new
    puts detector.inspect
    people_detector_vec = cv::HOGDescriptor.get_default_people_detector
    default_people_detector_mat = cv::Mat.new(people_detector_vec.size, 1, cv::CV_32FC1, people_detector_vec.data, cv::Mat::AUTO_STEP)
    detector.setsvm_detector(default_people_detector_mat)
    founds = Std::Vector.new(cv::Rect)
   
    window = Std::Vector::Double.new()

    detector.detect_multi_scale(frame, founds, window)

    founds.each do |found|
      
      r = cv::Rect.new(found)
      r.x += (r.width*0.1).to_i
      r.width = (r.width*0.8).to_i
      r.y += (r.height*0.07).to_i
      r.height = (r.height*0.8).to_i
      cv::rectangle(frame, r.tl, r.br, cv::Scalar.new(0,255,0), 3)

    end
    AssetHelper.write_frame_to_file(frame,File.basename(file),output_dir)
  end
    # cv::imshow("key_points",@frame)
    # cv::wait_key(-1)
  end

end
