require 'ropencv'
include OpenCV

class PersonDetector

  def initialize

  end

  def detect_surf
    mat = cv::imread("sample1.jpg")
    detector = cv::FeatureDetector::create("SURF")
    keypoints = Std::Vector.new(cv::KeyPoint)
    detector.detect(mat,keypoints)

    puts "found #{keypoints.size} keypoints"
    puts "first keypoint is at #{keypoints[0].pt.x}/#{keypoints[0].pt.y}"

    cv::draw_keypoints(mat,keypoints,mat)
    cv::imshow("key_points",mat)
    cv::wait_key(-1)
  end

  def detect_person

    frame = cv::imread("sample1.jpg")
    detector = cv::HOGDescriptor.new
    puts detector.inspect
    people_detector_vec = cv::HOGDescriptor.get_default_people_detector
    default_people_detector_mat = cv::Mat.new(people_detector_vec.size, 1, cv::CV_32FC1, people_detector_vec.data, cv::Mat::AUTO_STEP)
    detector.setsvm_detector(default_people_detector_mat)
    founds = Std::Vector.new(cv::Rect)
    founds_filtered = Std::Vector.new(cv::Rect)
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
    cv::imshow("key_points",frame)
    cv::wait_key(-1)
  end

  def detect_face

    #depends on openCV installation so copied into the directory for easier access
    face_cascade_name = "#{Dir.getwd}/haarcascade_frontalface_alt.xml"; 


    frame_gray =  cv::Mat.new
    face_cascade = cv::CascadeClassifier.new

    puts face_cascade.load( face_cascade_name ) ? ' loaded' : 'not loaded'
 
    frame = cv::imread("sample1.jpg")
    faces = Std::Vector.new(cv::Rect)

    cv::cvt_color(frame,frame_gray, CV_BGR2GRAY)
    cv::equalizeHist( frame_gray, frame_gray );


    face_cascade.detect_multi_scale( frame_gray, faces, 1.1, 2, );

    puts faces.size

    faces.each do |face|
      center = cv::Point.new(face.x + face.width*0.5, face.y + face.height*0.5)
      cv::ellipse( frame, center, cv::Size.new( face.width*0.5, face.height*0.5), 0, 0, 360, cv::Scalar.new( 255, 0, 255 ), 4, 8, 0 );
    end
    cv::imshow("key_points",frame)
    cv::wait_key(-1)
  end

end

pd= PersonDetector.new
pd.detect_surf