require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  describe "Task controller" do
    it "should get index" do
      get :index
      expect(response.status).to eq(200)
    end

    it "should get new" do
      get :new
      expect(response.status).to eq(200)
    end

    it "should create task" do
      post :tasks_new_url
      expect(response.status).to eq(200)
    end

    it "should show task" do
      get :show
      expect(response.status).to eq(200)
    end

    it "should get edit" do
      get :edit
      expect(response.status).to eq(200)
    end

    it "should update task" do
      put :update
      expect(response.status).to eq(200)
    end

    it "should destroy task" do
      delete :destroy
      expect(response.status).to eq(200)
    end

    it "status switch" do
      get :status_switch
      expect(response.status).to eq(200)
    end

    it "should destroy selected task" do
      delete :destroy
      expect(response.status).to eq(200)
    end
  end
end
