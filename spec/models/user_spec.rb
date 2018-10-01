require 'rails_helper'

RSpec.describe User, type: :model do
  describe "model:" do
    context "without a" do
      it "first_name" do
        user = build(:user, first_name: nil)
        expect(user).to_not be_valid
      end
      it "last_name" do
        user = build(:user, last_name: nil)
        expect(user).to_not be_valid
      end
      it "email" do
        user = build(:user, email: nil)
        expect(user).to_not be_valid
      end
      it "password" do
        user = build(:user, password: nil)
        expect(user).to_not be_valid
      end
    end

    it "empty model is not valid" do
      user = User.new
      expect(user.valid?).to eq false
    end
  end
end
