class RenameTermToDueDate < ActiveRecord::Migration[5.2]
  def change
    def up
      rename_column :task, :term, :due_date
    end

    def down
      rename_column :task, :due_date, :term
    end
  end
end