require 'rails_helper'

RSpec.describe Task, type: :model do
  describe "model:" do
    context "without a" do
      it "title" do
        task = Task.new(title: nil,
                        theme: "asd",
                        priority: "1",
                        term: "1234-12-12",
                        user_id: 1)
        expect(task).to_not be_valid
      end
      it "last_name" do
        task = Task.new(title: "a",
                        theme: nil,
                        priority: "1",
                        term: "1234-12-12",
                        user_id: 1)
        expect(task).to_not be_valid
      end
      it "email" do
        task = Task.new(title: "a",
                        theme: "asd",
                        priority: nil,
                        term: "1234-12-12",
                        user_id: 1)
        expect(task).to_not be_valid
      end
      it "password" do
        task = Task.new(title: "a",
                        theme: "asd",
                        priority: "1",
                        term: nil,
                        user_id: 1)
        expect(task).to_not be_valid
      end
      it "password" do
        task = Task.new(title: "a",
                        theme: "asd",
                        priority: "1",
                        term: "1234-12-12",
                        user_id: nil)
        expect(task).to_not be_valid
      end
    end

    it "empty task is not valid" do
      task = Task.new
      expect(task.valid?).to eq false
    end
  end
end