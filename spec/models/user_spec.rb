require 'rails_helper'

RSpec.describe User, type: :model do
  describe "model:" do
    context "without a" do
      it "first_name" do
        user = User.new(first_name: nil,
                        last_name: Faker::Name::last_name,
                        email: "qwe@aweqwe",
                        password: "asaasddd")
        expect(user).to_not be_valid
      end
      it "last_name" do
        user = User.new(first_name: Faker::Name::first_name,
                        last_name: nil,
                        email: "qwe@aweqwe",
                        password: "asaasddd")
        expect(user).to_not be_valid
      end
      it "email" do
        user = User.new(first_name: Faker::Name::first_name,
                        last_name: Faker::Name::last_name,
                        email: nil,
                        password: "asaasddd")
        expect(user).to_not be_valid
      end
      it "password" do
        user = User.new(first_name: Faker::Name::first_name,
                        last_name: Faker::Name::last_name,
                        email: "asd@asd",
                        password: nil)
        expect(user).to_not be_valid
      end
    end

    it "empty model is not valid" do
      user = User.new
      expect(user.valid?).to eq false
    end

    it "has a unique email" do
      user = User.create(first_name: Faker::Name::first_name,
                      last_name: Faker::Name::last_name,
                      email: "qwe@aweqwe",
                      password: "asaasddd")
      expect(user).to be_valid
      user1 = User.create(first_name: Faker::Name::first_name,
                       last_name: Faker::Name::last_name,
                       email: "qwe@aweqwe",
                       password: "asaasddd")
      expect(user1).to_not be_valid
    end
  end
end
