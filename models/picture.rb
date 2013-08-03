class Picture < ActiveRecord::Base
  belongs_to :users
  before_destroy :delete_picture_file_from_disk

  private
  # 用于删除picture model时，同时删除对应的附件图片
  def delete_picture_file_from_disk
    if File.exist?(path)
      File.delete(path)
    end
  end
end
