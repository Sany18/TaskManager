require 'rails_helper'
include Shoulda::Matchers::ActiveModel

RSpec.describe Task, type: :model do
  describe "model:" do
    context "without a" do
      it "title" do
        subject { build(:task) }
        should validate_presence_of(:title)
      end
      it "theme" do
        subject { build(:task) }
        should validate_presence_of(:theme)
      end
      it "priority" do
        subject { build(:task) }
        should validate_presence_of(:priority)
      end
      it "user_id" do
        subject { build(:task) }
        should validate_presence_of(:user_id)
      end
    end

    it "empty task is not valid" do
      task = Task.new
      expect(task.valid?).to eq false
    end
  end
end