require 'ropencv'
require 'pry'
include OpenCV



root_dir  = Dir.getwd
lib_dir = File.join(root_dir,'/app/**')
Dir["#{lib_dir}/*.rb"].each do |f| 
  load(f)
end

person_detector = PersonDetector.new
feature_detector = FeatureDetector.new
haar_detector = HaarDetector.new
MasterDetector.detect(haar_detector)

# video_operator = VideoOperator.new
# video_operator.split_video_to_frames
#video_operator.fps