class HaarDetector

  attr_accessor :face_cascade_names, :frames_dir, :output_dir, :colors

  def initialize(dir = 'sample_1_mp4')
    #depends on openCV installation so copied into the directory for easier access
    harr_cascades = ["haarcascade_fullbody.xml","haarcascade_upperbody.xml","haarcascade_frontalface_alt.xml","haarcascade_frontalface_alt2.xml",
                     'haarcascade_profileface.xml']
    @colors = [[255,0,255],
               [29,24,171],[24,171,68],
               [255,235,42],[235,12,23],[235,142,12]]
    @face_cascade_names =[]
    harr_cascades.each do |haar_cascade|
      @face_cascade_names << AssetHelper.assets_path(haar_cascade,'opencv')
    end
    @frames_dir = AssetHelper.assets_path("output/#{dir}",'images')
    @output_dir = AssetHelper.output_dir_filepath("#{dir}", 'images')
  end


  def detect

    frame_gray =  cv::Mat.new
    face_cascade = cv::CascadeClassifier.new
    face_cascade_names.each_with_index do |face_cascade_name,index|
      puts face_cascade.load( face_cascade_name ) ? ' loaded' : 'not loaded'
      color = colors[index]
      Dir.glob("#{frames_dir}/*.jpg") do |file|
        frame = cv::imread(file)
        faces = Std::Vector.new(cv::Rect)

        cv::cvt_color(frame,frame_gray, CV_BGR2GRAY)
        cv::equalizeHist( frame_gray, frame_gray );


        face_cascade.detect_multi_scale( frame_gray, faces, 1.1, 2, );

        faces.each do |face|
          center = cv::Point.new(face.x + face.width*0.5, face.y + face.height*0.5)
          cv::ellipse( frame, center, cv::Size.new( face.width*0.5, face.height*0.5), 0, 0, 360, cv::Scalar.new( color[0], color[1], color[2] ), 4, 8, 0 );
        end
        AssetHelper.write_frame_to_file(frame,File.basename(file),output_dir)
      end
    end
    # cv::imshow("key_points",@frame)
    # cv::wait_key(-1)
  end


end