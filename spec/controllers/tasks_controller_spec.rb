require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let(:user) {@request.env["devise.mapping"] = Devise.mappings[:user]; create(:user)}
  before(:each) do
    sign_in user
  end

  # GET /tasks
  context "#index" do
    let!(:user_task) { create(:task, user_id: user.id) }
    let!(:not_user_task) { create(:task, user_id: 0) }
    it "have tasks" do
      get :index
      expect( assigns(:tasks).last ).to eq( user_task )
      expect( assigns(:tasks).last ).not_to eq( not_user_task )
    end

    it "should ret. 200 if user is up" do
      get :index
      expect( response ).to have_http_status( 200 )
    end

    it "should redirect if user is down" do
      sign_out user
      get :index
      expect(response).to redirect_to( new_user_session_path )
    end
  end

  # GET /task/:id
  context "#show" do
    let!(:task) {create(:task, user_id: user.id)}
    let!(:params) {{id: task.id}}

    it "have task" do
      get :show, params: params
      expect( assigns(:task) ).to eq( task )
    end

    it "should return 200" do
      get :show, params: params
      expect(response).to have_http_status(200)
    end
  end

  # GET /task/new
  context "#new" do
    it "should return 200" do
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
    let!(:task) {create(:task, user_id: user.id)}
    let!(:params) {{id: task.id}}

    it "have task" do
      get :show, params: params
      expect( assigns(:task) ).to eq( task )
    end

    it "should direct to edit (return 200)" do
      get :edit, params: params
      expect(response).to have_http_status(200)
    end
  end

  # POST /task
  context "#create" do
    let!(:current_task) { build(:task) }
    let!(:params) {{ task: current_task.attributes }}
    it "should return 200" do
      post :create, params: params
      expect(response).to redirect_to( root_path )
    end

    it "must create current task" do
      post :create, params: params
      expect( assigns(:task).title ).to eq( current_task.title )
      expect( assigns(:task).theme ).to eq( current_task.theme )
    end
  end

  # PATCH/PUT /task/:id
  context "#update" do
    let!(:task_1) { create(:task, user_id: user.id) }
    let!(:params_1) {{ id: task_1.id, task: task_1.attributes }}

    it "get current task" do
      put :update, params: params_1
      expect( assigns(:task) ).to eq( task_1 )
    end

    let!(:task_2) { build(:task, user_id: user.id) }
    let!(:params_2) {{ id: task_1.id, task: task_2.attributes }}

    it "must update current task" do
      put :update, params: params_2
      expect( assigns(:task).title ).to eq( task_2.title )
      expect( assigns(:task).theme ).to eq( task_2.theme )
    end

    it "should redirect to root" do
      put :update, params: params_1
      expect(response).to redirect_to( root_path )
    end
  end

  # DELETE /task/:id
  context "#destroy" do
    let!(:task) { create(:task, user_id: user.id) }
    let!(:params) {{ id: task.id }}

    it "destroy task" do
      delete :destroy, params: params
      expect( Task.find_by(id: task.id) ).to be_nil
    end

    it "status 302" do
      delete :destroy, params: params
      expect(response).to have_http_status(302)
    end
  end

  # DELETE /task/delete_selected/:id
  context "#destroy selected" do
    let!(:task) { create(:task, user_id: user.id) }
    let!(:task_2) { create(:task, user_id: user.id) }
    let!(:params) {{ id: [task.id, task_2.id] * '&' }}

    it "destroy tasks" do
      puts params
      delete :destroy, params: params
      expect( Task.find_by(id: task.id) ).to be_nil
      expect( Task.find_by(id: task_2.id) ).to be_nil
    end

    it "status 204" do
      delete :destroy_selected, params: params
      expect(response).to have_http_status(204)
    end
  end

  #GET /task/status_switch/:id
  context "#status_switch" do
    let!(:task) {create(:task, user_id: user.id)}
    let!(:params) {{id: task.id}}

    it "shange status" do
      get :status_switch, params: params
      expect( assigns(:task).is_done ).not_to eq( task.is_done )
    end

    it "should return 302" do
      get :status_switch, params: params
      expect(response).to have_http_status(302)
    end
  end
end