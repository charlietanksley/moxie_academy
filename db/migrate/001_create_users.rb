migration 1, :create_users do
  up do
    create_table :users do
      column :id, Integer, :serial => true
      column :email, String, :length => 255
      column :group_id, Integer
    end
  end

  down do
    drop_table :users
  end
end
