class AddDefaultpwToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :defaultpw, :string
  end
end
