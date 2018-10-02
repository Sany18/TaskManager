require 'rails_helper'
include Shoulda::Matchers::ActiveModel

RSpec.describe User, type: :model do
  describe "model:" do
    context "without a" do
      it "first_name" do
        subject { build(:user) }
        should validate_presence_of(:first_name)
      end
      it "last_name" do
        subject { build(:user) }
        should validate_presence_of(:last_name)
      end
      it "email" do
        subject { build(:user) }
        should validate_presence_of(:email)
      end
      it "password" do
        subject { build(:user) }
        should validate_presence_of(:password)
      end
    end

    it "empty model is not valid" do
      user = User.new
      expect(user.valid?).to eq false
    end
  end
end
