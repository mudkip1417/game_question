class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|

      t.integer  :game_id
      t.integer  :user_id
      t.string   :title, null: false
      t.text     :question, null: false
      t.boolean  :is_active, null: false, default: true

      t.timestamps
    end
  end
end
