class FeatureDetector
  
  def initialize
     @img = cv::imread(AssetHelper.assets_path("sample1.jpg"))
  end

  def detect
  
    detector = cv::FeatureDetector::create("SURF")
    keypoints = Std::Vector.new(cv::KeyPoint)
    detector.detect(@img,keypoints)

    puts "found #{keypoints.size} keypoints"
    puts "first keypoint is at #{keypoints[0].pt.x}/#{keypoints[0].pt.y}"

    cv::draw_keypoints(@img,keypoints,@img)
    cv::imshow("key_points",@img)
    cv::wait_key(-1)
  end
  
end
