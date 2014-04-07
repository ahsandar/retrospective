require 'ropencv'
require 'pry'
include OpenCV



root_dir  = Dir.getwd
lib_dir = File.join(root_dir,'/app/**')
Dir["#{lib_dir}/*.rb"].each do |f| 
  load(f)
end


video_operator = VideoOperator.new('sample_2.mp4')
#video_operator.split_video_to_frames
#video_operator.frames_per_sec


person_detector = PersonDetector.new('sample_2_mp4')
# feature_detector = FeatureDetector.new
haar_detector = HaarDetector.new('sample_2_mp4')
bg_sub = BgSub.new('sample_2_mp4')
MasterDetector.detect(bg_sub)

