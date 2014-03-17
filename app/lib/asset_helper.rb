class AssetHelper

  def self.assets_path(file,type = 'images')
    dir = Dir.getwd
    asset_dir = File.join('retrospective','app','assets', type ,file)
    dir.gsub!(File.basename(dir),asset_dir)
  end
end