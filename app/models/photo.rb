class Photo < ActiveRecord::Base
  #attr_accessible :description, :link, :thumbnail, :title
  attr_protected :id

  validates_presence_of :link, :thumbnail_small

  has_many :project_photos

  def thumb size
    filename = thumbnail_large
    unless filename =~ /^https?:\/\//
      dirname = File.dirname(filename)
      basename = File.basename(filename, ".*")
      extname = File.extname(filename)
      newname = File.join(dirname, "#{basename}-#{size}#{extname}")
      if File.exist?(File.join(PHOTOS_PATH, newname))
        filename = newname
      end
    end
    filename
  end

end
