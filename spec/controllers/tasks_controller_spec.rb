require 'rails_helper'
require 'controllers/user/lui'

RSpec.describe TasksController, type: :controller do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = create(:user)
    sign_in @user
  end

  let(:invalid_params) { {task: build(:task, title: nil).attributes} }
  let(:valid_params) { {task: build(:task).attributes} }

  # GET /tasks
  context "#index" do
    it "should ret. 200 if user is up" do
      Mario.new
      get :index
      expect(response).to have_http_status(200)
    end

    it "should redirect if user is down" do
      sign_out @user
      get :index
      expect(response).to have_http_status(302)
    end
  end

  # GET /task/:id
  context "#show" do
    it "should show task" do
      task = create(:task)
      get :show, params: {id: task.id}
      expect(response).to have_http_status(200)
    end
  end

  # GET /task/new
  context "#new" do
    it "should get new task" do
      get :new
      expect(response).to have_http_status(200)
    end
  end

  # GET /task/1/edit
  context "#edit" do
    it "should direct to edit" do
      task = create(:task)
      get :edit, params: {id: task.id}
      expect(response).to have_http_status(200)
    end
  end

  # POST /task
  context "#create" do
    it "should create task" do
      # sign_in FactoryBot.create(:user)
      post :create, params: valid_params
      expect(response).to have_http_status(302)
    end

    it "" do
      post :create, params: invalid_params
      expect(response).to have_http_status(200)
    end
  end

  # PATCH/PUT /task/:id
  context "#update" do
    it "should update task" do
      task = create(:task)
      put :update, params: {id: task.id, task: task.attributes}
      expect(response).to have_http_status(302)
    end
  end

  # DELETE /task/:id
  context "#destroy" do
    it "should destroy task" do
      task = create(:task)
      delete :destroy, params: {id: task.id}
      expect(response).to have_http_status(302)
    end
  end

  # DELETE /task/delete_selected/:id
  context "#destroy selected" do
    it "should delete selected task" do
      task = create(:task)
      delete :destroy_selected, params: {id: task.id}
      expect(response).to have_http_status(302)
    end
  end

  #GET /task/status_switch/:id
  context "#status_switch" do
    it "should change status" do
      task = create(:task)
      get :status_switch, params: {id: task.id}
      expect(response).to have_http_status(302)
    end
  end
end