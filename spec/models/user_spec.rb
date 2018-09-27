require 'rails_helper'

RSpec.describe User, type: :model do
  describe "User model:" do

    it "empty user model is not valid" do
      user = User.new
      expect(user.valid?).to eq false
    end

    it "has not empty username" do
      user = User.new(first_name: "")
      expect(user).to_not be_valid
    end

    # it "create user user" do
    #   expect(@user).to eq(true)
    # end

      #
      # before(:all) do
      #   @user1 = create(:user)
      # end
      #
      # it "has a unique username" do
      #   user2 = build(:user, username: @user1.username)
      #   expect(user2).to_not be_valid
      # end
      #
      # it "has a unique email" do
      #   user2 = build(:user, email: @user1.email)
      #   expect(user2).to_not be_valid
      # end
      #
      # it "is not valid without a password" do
      #   user2 = build(:user, password: nil)
      #   expect(user2).to_not be_valid
      # end
      #
      # it "is not valid without a password confirmation" do
      #   user2 = build(:user, password_confirmation: nil)
      #   expect(user2).to_not be_valid
      # end
      #
      # it "is not valid without a username" do
      #   user2 = build(:user, username: nil)
      #   expect(user2).to_not be_valid
      # end
      #
      # it "is not valid without an email" do
      #   user2 = build(:user, email: nil)
      #   expect(user2).to_not be_valid
      # end
      #
      # it "is can do confirmation via email" do
      #   user = create(:user)
      #   user.email_activate
      #   expect(user.email_confirmed && !user.confirm_token).to be true
      # end

    # end
  end
end
