migration 6, :create_comments do
  up do
    create_table :comments do
      column :id, Integer, :serial => true
      column :discussion_id, Integer
      column :body, Text
    end
  end

  down do
    drop_table :comments
  end
end
