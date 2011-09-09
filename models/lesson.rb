class Lesson
  include DataMapper::Resource

  # property <name>, <type>
  property :id,           Serial
  property :title,        String
  property :slug,         String, :format => /^[-_a-zA-Z0-9]+$/
  property :body,         Text
  property :video_title,  String
  property :poster_name,  String

  validates_presence_of   :video_title
  validates_presence_of   :slug
  validates_uniqueness_of :slug
end
