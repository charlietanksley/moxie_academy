migration 5, :create_discussions do
  up do
    create_table :discussions do
      column :id, Integer, :serial => true
      column :group_id, Integer
    end
  end

  down do
    drop_table :discussions
  end
end
