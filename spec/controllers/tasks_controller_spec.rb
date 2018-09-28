require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in FactoryBot.create(:user)
  end

  describe "#index" do
    it "if user is up" do
      get :index
      expect(response.status).to eq(200)
    end

    it "if user is down" do
      sign_out FactoryBot.create(:user)
      get :index
      expect(response.status).to eq(302)
    end

    it "inner methods" do
    end
  end

  it "should get new" do
    get :new
    expect(response.status).to eq(200)
  end

  # it "should get show" do
  #   get :show
  #   expect(response.status).to eq(200)
  # end

  context "create task" do
    # let(:task) {{:title => "fake",
    #              :theme => "fake",
    #              :priority => "fake",
    #              :term => "fake",
    #              :user_id => "1",
    #              :is_done => "0"}}
    it "should create task" do
      post :create
      expect(response.status).to eq(200)
    end
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
