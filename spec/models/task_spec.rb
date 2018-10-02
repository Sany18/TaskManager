require 'rails_helper'

RSpec.describe Task, type: :model do
  describe "model:" do
    context "without a" do
      it "title" do
        task = build(:task, title: nil)
        expect(task).to_not be_valid
      end
      it "theme" do
        task = build(:task, theme: nil)
        expect(task).to_not be_valid
      end
      it "priority" do
        task = build(:task, priority: nil)
        expect(task).to_not be_valid
      end
      it "user_id" do
        task = build(:task, user_id: nil)
        expect(task).to_not be_valid
      end
    end

    it "empty task is not valid" do
      task = Task.new
      expect(task.valid?).to eq false
    end
  end
end