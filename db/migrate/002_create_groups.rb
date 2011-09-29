migration 2, :create_groups do
  up do
    create_table :groups do
      column :id, Integer, :serial => true
      column :name, String, :length => 255
      column :password, String, :length => 255
    end
  end

  down do
    drop_table :groups
  end
end
