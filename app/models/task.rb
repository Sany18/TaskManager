class Task < ApplicationRecord
  validates_presence_of :title, :theme, :priority, :due_date, :user_id
end