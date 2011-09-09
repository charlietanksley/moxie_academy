class Lesson
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :title, String
  property :slug, String
  property :body, Text
  property :video_title, String
  property :poster_name, String
end
