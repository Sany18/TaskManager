require 'rails_helper'
require 'controllers/user/lui'

RSpec.describe TasksController, type: :controller do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = create(:user)
    sign_in @user
  end

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
    let(:params) { task = create(:task); {id: task.id} }
    it "should show task" do
      get :show, params: params
      expect(response).to have_http_status(200)
    end
  end

  # GET /task/new
  context "#new" do
    it "should get new task" do
      get :new
      expect(response).to have_http_status(200)
    end
    it "should have new Task" do
      get :new
      expect(assigns(:task)).to be_a_new(Task)
    end
  end

  # GET /task/1/edit
  context "#edit" do
    let(:params) { task = create(:task); {id: task.id} }
    it "should direct to edit" do
      get :edit, params: params
      expect(response).to have_http_status(200)
    end
  end

  # POST /task
  context "#create" do
    let(:params) { {task: build(:task).attributes} }
    it "should create task" do
      # sign_in FactoryBot.create(:user)
      post :create, params: params
      expect(response).to have_http_status(302)
    end

    it "should have new Task" do
      get :new
      expect(assigns(:task)).to be_a_new(Task)
    end
  end

  # PATCH/PUT /task/:id
  context "#update" do
    let(:params) { task = create(:task); {id: task.id, task: task.attributes} }
    it "should update task" do
      put :update, params: params
      expect(response).to have_http_status(302)
    end
  end

  # DELETE /task/:id
  context "#destroy" do
    let(:params) { task = create(:task); {id: task.id} }
    it "should destroy task" do
      delete :destroy, params: params
      expect(response).to have_http_status(302)
    end
  end

  # DELETE /task/delete_selected/:id
  context "#destroy selected" do
    let(:params) { task = create(:task); {id: task.id} }
    it "should delete selected task" do
      delete :destroy_selected, params: params
      expect(response).to have_http_status(302)
    end
  end

  #GET /task/status_switch/:id
  context "#status_switch" do
    let(:params) { task = create(:task); {id: task.id} }
    it "should change status" do
      get :status_switch, params: params
      expect(response).to have_http_status(302)
    end
  end
end