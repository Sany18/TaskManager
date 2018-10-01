class TasksController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!, except: [:index]
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  # GET /task.json
  def index
    if user_signed_in?
      @tasks = Task.all.where(user_id: current_user.id)
      @self = self
    else
      respond_to do |page|
        page.html {redirect_to new_user_session_path, notice: "You need to sign in first."}
      end
    end
  end

  # GET /task/1
  # GET /task/1.json
  def show
  end

  # GET /task/new
  def new
    @task = Task.new
  end

  # GET /task/1/edit
  def edit
  end

  # POST /task
  # POST /task.json
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html {redirect_to @task, notice: "Task created."}
        format.json {render :show, status: :created, location: @task}
      else
        format.html {render :new}
        format.json {render json: @task.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /task/1
  # PATCH/PUT /task/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html {redirect_to @task, notice: "Task updated."}
        format.json {render :show, status: :ok, location: @task}
      else
        format.html {render :edit}
        format.json {render json: @task.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /task/1
  # DELETE /task/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html {redirect_to tasks_url, notice: "Task deleted."}
      format.json {head :no_content}
    end
  end

  # DELETE /task/delete_selected/1
  def destroy_selected
    params[:id].split("%").map do |id|
      task = Task.find_by(id: id)
      task.destroy
    end

    respond_to do |format|
      format.html {redirect_to "/", notice: "Selected tasks deleted."}
      format.json {head :no_content}
    end
  end

  #GET /task/status_switch/1
  def status_switch
    id = params[:id]
    task = Task.find_by(id: id)
    if task.is_done == 0
      task.update(is_done: 1)
    else
      task.update(is_done: 0)
    end

    respond_to do |format|
      format.html {redirect_to "/", notice: "Changed."}
      format.json {head :no_content}
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def task_params
    params.require(:task).permit(:title, :theme, :priority, :term, :user_id, :is_done)
  end
end
