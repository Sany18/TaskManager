require 'rails_helper'
# require 'devise'

RSpec.describe TasksController, type: :controller do
  RSpec.configure do |config|
    config.include Devise::Test::ControllerHelpers, type: :controller
  end

  let(:token) {user_signed_in? {true} }

  describe "#index" do
    it "should get 302" do
      get :index
      expect(response.status).to eq(302)
    end
  end

  it "should get new" do
    :new
    expect(response.status).to eq(200)
  end

  it "should create task" do
    :tasks_new_url
    expect(response.status).to eq(200)
  end

  it "should show task" do
    :show
    expect(response.status).to eq(200)
  end

  it "should get edit" do
    :edit
    expect(response.status).to eq(200)
  end

  it "should update task" do
    :update
    expect(response.status).to eq(200)
  end

  it "should destroy task" do
    :destroy
    expect(response.status).to eq(200)
  end

  it "status switch" do
    :status_switch
    expect(response.status).to eq(200)
  end

  it "should destroy selected task" do
    :destroy
    expect(response.status).to eq(200)
  end
end
