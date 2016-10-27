# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  include Cloudinary::CarrierWave
  
  #process :convert => 'png'
  #process :tags => ['avatar']

  #version :standard do
    #process :resize_to_fill => [100, 150, :north]
  #end

  #version :thumbnail do
    #process :resize_to_fit => [50, 50]
  #end

end
  
  #storage :file
 
  #def store_dir
    #"uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  #end
  
  # 許可する画像の拡張子
  #def extension_white_list
    #%w(jpg jpeg gif png)
  #end

#end
