class Product < ActiveRecord::Base
  mount_uploader :main_image, ImageUploader
  mount_uploader :sub1_image, ImageUploader
  mount_uploader :sub2_image, ImageUploader
end
