class AssetHelper

  def self.assets_path(file,type = 'images')
    dir = Dir.getwd
    asset_dir = File.join('retrospective','app','assets', type ,file)
    dir.gsub!(File.basename(dir),asset_dir)
  end

  def self.output_dir_filepath(file, dir='videos')
    output_path ||=FileUtils.mkdir_p assets_path("output/#{file.gsub('.','_')}",dir)
    output_path.first
  end


   def self.write_frame_to_file(frame, frame_name, output_path)
    file_name = File.join(output_path, frame_name)
    cv::imwrite(file_name, frame)
  end

end