class CreateTags < ActiveRecord::Migration[6.0]
  def change
    create_table :tags do |t|
      t.string :name
      t.references :micropost, foreign_key: true

      t.timestamps
    end
    #change_column :tags, :microposts, :integer, :null => true

  end
end
