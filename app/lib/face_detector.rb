class FaceDetector
	def initialize
      #depends on openCV installation so copied into the directory for easier access
    @face_cascade_name = AssetHelper.assets_path("haarcascade_frontalface_alt.xml",'opencv') 
    asset = AssetHelper.assets_path("sample1.jpg")
    @frame = cv::imread(asset)
	end


	def detect

    frame_gray =  cv::Mat.new
    face_cascade = cv::CascadeClassifier.new

    puts face_cascade.load( @face_cascade_name ) ? ' loaded' : 'not loaded'
 
    faces = Std::Vector.new(cv::Rect)

    cv::cvt_color(@frame,frame_gray, CV_BGR2GRAY)
    cv::equalizeHist( frame_gray, frame_gray );


    face_cascade.detect_multi_scale( frame_gray, faces, 1.1, 2, );

    faces.each do |face|
      center = cv::Point.new(face.x + face.width*0.5, face.y + face.height*0.5)
      cv::ellipse( @frame, center, cv::Size.new( face.width*0.5, face.height*0.5), 0, 0, 360, cv::Scalar.new( 255, 0, 255 ), 4, 8, 0 );
    end
    cv::imshow("key_points",@frame)
    cv::wait_key(-1)
  end
  
end