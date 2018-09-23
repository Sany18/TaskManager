class CreateTtts < ActiveRecord::Migration[5.2]
  def change
    create_table :ttts do |t|
      t.string :title
      t.string :theme
      t.integer :priority
      t.datetime :term
      t.integer :user_id
      t.integer :is_done, default: 0

      t.timestamps
    end
  end
end