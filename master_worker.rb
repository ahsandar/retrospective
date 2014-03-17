require 'ropencv'
require 'pry'
include OpenCV



root_dir  = Dir.getwd
lib_dir = File.join(root_dir,'/app/lib')
Dir["#{lib_dir}/*.rb"].each do |f| 
  load(f)
end

person_detector = PersonDetector.new
feature_detector = FeatureDetector.new
face_detector = FaceDetector.new
#MasterDetector.detect(feature_detector)
video_splitter = VideoSplitter.new
video_splitter.split_video_to_frames