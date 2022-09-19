class CreateBookmarks < ActiveRecord::Migration[6.1]
  def change
    create_table :bookmarks do |t|

      t.integer  :question_id
      t.integer  :user_id
      t.string   :title, null: false

      t.timestamps
    end
  end
end
