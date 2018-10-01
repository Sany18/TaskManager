require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in FactoryBot.create(:user)
  end

  # GET /tasks
  context "#index" do
    it "should ret. 200 if user is up" do
      get :index
      expect(response.status).to eq(200)
    end

    it "should redirect if user is down" do
      sign_out FactoryBot.create(:user)
      get :index
      expect(response.status).to eq(302)
    end
  end

  # GET /task/1
  context "#show" do
    it "should show task" do
      get :show, params: {id: 1}
      expect(response.status).to eq(200)
    end
  end

  # GET /task/new
  context "#new" do
    it "should get new task" do
      get :new
      expect(response.status).to eq(200)
    end
  end

  # GET /task/1/edit
  context "#edit" do
    it "should direct to edit" do
      get :edit, params: {id: 1}
      expect(response.status).to eq(200)
    end
  end

  # POST /task
  context "#create" do
    it "should create task" do
      # sign_in FactoryBot.create(:user)
      post :create, params: {task: attributes_for(:task)}
      expect(response.status).to eq(302)
    end

    it "" do
      task1 = {task: build(:task, title: nil).attributes}
      post :create, params: task1
      expect(response.status).to eq(200)
    end
  end

  # PATCH/PUT /task/1
  context "#update" do
    it "should update task" do
      put :update, params: {id: 1, task: attributes_for(:task)}
      expect(response.status).to eq(302)
    end
  end

  # DELETE /task/1
  context "#destroy" do
    it "should destroy task" do
      delete :destroy, params: {id: 1}
      expect(response.status).to eq(302)
    end
  end

  # DELETE /task/delete_selected/1
  context "#destroy selected" do
    it "should delete selected task" do
      delete :destroy_selected, params: {id: '1%2'}
      expect(response.status).to eq(302)
    end
  end

  #GET /task/status_switch/1
  context "#status_switch" do
    it "should change status" do
      get :status_switch, params: {id: 1}
      expect(response.status).to eq(302)
    end
  end
end