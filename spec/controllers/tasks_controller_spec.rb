require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let(:user) { @request.env["devise.mapping"] = Devise.mappings[:user]; create(:user) }
  before(:each) do
    sign_in user
  end

  # GET /tasks
  context "#index" do
    let!(:user_task) { create(:task, user_id: user.id) }
    let!(:not_user_task) { create(:task, user_id: 0) }

    it "should redirect if user is down" do
      sign_out user
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end

    before do
      get :index
    end

    it { expect(assigns(:tasks).last).to eq(user_task) }
    it { expect(assigns(:tasks).first).to eq(user_task) }
    it { expect(assigns(:tasks).last).not_to eq(not_user_task) }
    it { expect(response).to have_http_status(200) }
  end

  # GET /task/:id
  context "#show" do
    let(:task) {create(:task, user_id: user.id)}

    before do
      get :show, params: {id: task.id}
    end

    it {expect(assigns(:task)).to eq(task)}
    it {expect(response).to have_http_status(200)}
  end

  # GET /task/new
  context "#new" do
    before do
      get :new
    end

    it { expect(response).to have_http_status(200) }
    it { expect(assigns(:task)).to be_a_new(Task) }
  end

  # GET /task/1/edit
  context "#edit" do
    let(:task) {create(:task, user_id: user.id)}

    before do
      get :edit, params: {id: task.id}
    end

    it {expect(assigns(:task)).to eq(task)}
    it {expect(response).to have_http_status(200)}
  end

  # POST /task
  context "#create" do
    let(:current_task) {build(:task)}
    let(:params) {{task: current_task.attributes}}

    before do
      post :create, params: params
    end

    it { expect(response).to redirect_to(root_path) }
    it { expect(assigns(:task).title).to eq(current_task.title) }
    it { expect(assigns(:task).theme).to eq(current_task.theme) }
  end

  # PATCH/PUT /task/:id
  context "#update" do
    let(:task_1) {create(:task, user_id: user.id)}
    let(:task_2) {build(:task, user_id: user.id)}
    let(:params) {{id: task_1.id, task: task_2.attributes}}

    before do
      put :update, params: params
    end

    it { expect(response).to redirect_to(root_path) }
    it { expect(assigns(:task).title).to eq(task_2.title) }
    it { expect(assigns(:task).theme).to eq(task_2.theme) }
  end

  # DELETE /task/:id
  context "#destroy" do
    let(:task) {create(:task, user_id: user.id)}

    before do
      delete :destroy, params: {id: task.id}
    end

    it { expect(Task.find_by(id: task.id)).to be_nil }
    it { expect(response).to have_http_status(302) }
  end

  # DELETE /task/delete_selected/:id
  context "#destroy selected" do
    let(:task) {create(:task, user_id: user.id)}
    let(:task_2) {create(:task, user_id: user.id)}
    let(:params) {{id: [task.id, task_2.id] * '&'}}

    before do
      delete :destroy_selected, params: params
    end

    it { expect(Task.find_by(id: task.id)).to be_nil }
    it { expect(Task.find_by(id: task_2.id)).to be_nil }
    it { expect(response).to have_http_status(204) }
  end

  #GET /task/status_switch/:id
  context "#status_switch" do
    let(:task) {create(:task, user_id: user.id)}

    before do
      get :status_switch, params: {id: task.id}
    end

    it { expect(assigns(:task).is_done).not_to eq(task.is_done) }
    it { expect(response).to have_http_status(302) }
  end
end