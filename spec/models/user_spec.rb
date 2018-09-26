require 'rails_helper'

RSpec.describe Task, type: :model do
  context "validation tests of task" do
    it "ensures title is present" do
      task = Task.new(title: "asdd")
      expect(task.valid?).to eq(false)
    end

    it "ensures theme is present" do
      task = Task.new(theme: "asdd")
      expect(task.valid?).to eq(false)
    end

    it "ensures priority is present" do
      task = Task.new(title: "asdd")
      expect(task.valid?).to eq(false)
    end

    it "ensures term is present" do
      task = Task.new(theme: "asdd")
      expect(task.valid?).to eq(false)
    end

    it "ensures user_id is present" do
      task = Task.new(theme: "asdd")
      expect(task.valid?).to eq(false)
    end

  end
end
