migration 3, :create_lessons do
  up do
    create_table :lessons do
      column :id, Integer, :serial => true
      column :title, String, :length => 255
      column :slug, String, :length => 255
      column :body, Text
      column :video_title, String, :length => 255
      column :poster_name, String, :length => 255
    end
  end

  down do
    drop_table :lessons
  end
end
