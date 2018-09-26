class Task < ApplicationRecord
  validates_presence_of :title, :theme, :priority, :term, :user_id
end
