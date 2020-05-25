class AddTagRefToMicroposts < ActiveRecord::Migration[6.0]
  def change
    add_reference :microposts, :tag, foreign_key: true
  end
end
