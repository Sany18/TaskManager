class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  # GET /task.json
  def index
    @tasks = current_user.tasks
  end

  # GET /task/1
  # GET /task/1.json
  def show
  end

  # GET /task/new
  def new
    @task = current_user.tasks.new
    render layout: false
  end

  # GET /task/1/edit
  def edit
  end

  # POST /task
  # POST /task.json
  def create
    @task = current_user.tasks.new(task_params)

    respond_to do |format|
      if @task.save
        format.html {redirect_to '/', notice: "Task created."}
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
        format.html {redirect_to '/', notice: "Task updated."}
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

  # DELETE /task/delete_selected/:id
  def destroy_selected
    params[:id].split("&").map do |id|
      current_user.tasks.find_by(id: id).destroy
    end
  end

  #GET /task/status_switch/:id
  def status_switch
    id = params[:id]
    @task = current_user.tasks.find_by(id: id)
    if @task.is_done == false
      @task.update(is_done: true)
    else
      @task.update(is_done: false)
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
    params.require(:task).permit(:title, :theme, :priority, :due_date, :is_done)
  end
end