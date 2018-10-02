class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :theme
      t.integer :priority
      t.datetime :term
      t.boolean :is_done, default: false
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end