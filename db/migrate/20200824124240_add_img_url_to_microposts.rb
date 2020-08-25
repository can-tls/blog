class AddImgUrlToMicroposts < ActiveRecord::Migration[6.0]
  def change
    add_column :microposts, :img_url, :string
  end
end
