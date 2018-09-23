class TttsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!, except: [:index]
  before_action :set_ttt, only: [:show, :edit, :update, :destroy]

  # GET /tttsy
  # GET /ttts.json
  def index
    @ttts = Ttt.all
    @self = self
  end

  # GET /ttts/1
  # GET /ttts/1.json
  def show
  end

  # GET /ttts/new
  def new
    @ttt = Ttt.new
    @dateNow = self.getDateNow
    @self = self
  end

  # GET /ttts/1/edit
  def edit
    @dateNow = self.getDateNow
    @self = self
  end

  # POST /ttts
  # POST /ttts.json
  def create
    @ttt = Ttt.new(ttt_params)

    respond_to do |format|
      if @ttt.save
        format.html {redirect_to @ttt, notice: "Запись создана."}
        format.json {render :show, status: :created, location: @ttt}
      else
        format.html {render :new}
        format.json {render json: @ttt.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /ttts/1
  # PATCH/PUT /ttts/1.json
  def update
    respond_to do |format|
      if @ttt.update(ttt_params)
        format.html {redirect_to @ttt, notice: "Задача обновлена."}
        format.json {render :show, status: :ok, location: @ttt}
      else
        format.html {render :edit}
        format.json {render json: @ttt.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /ttts/1
  # DELETE /ttts/1.json
  def destroy
    @ttt.destroy
    respond_to do |format|
      format.html {redirect_to ttts_url, notice: "Задача удалена."}
      format.json {head :no_content}
    end
  end

  def destroy_selected
    params[:id].split("%").map do |id|
      ttt = Ttt.find_by(id: id)
      ttt.destroy
    end

    respond_to do |format|
      format.html {redirect_to "/", notice: "Выбранные задачи удалены."}
      format.json {head :no_content}
    end
  end

  def statusSwitch
    id = params[:id]
    ttt = Ttt.find_by(id: id)
    if ttt.is_done == 0
      ttt.update(is_done: 1)
    else
      ttt.update(is_done: 0)
    end

    respond_to do |format|
      format.html {redirect_to "/", notice: "Изменено."}
      format.json {head :no_content}
    end
  end


  def getDateNow
    r = Time.now
    "#{self.checkZero(r.year)}-#{self.checkZero(r.month)}-#{r.day}"
  end

  def checkZero num
    if num < 10
      return "0#{num}"
    end
  else
    num
  end

  def colorOfPriority id
    case id
    when 1
      "w3-light-green"
    when 2
      "w3-lime"
    when 3
      "w3-yellow"
    when 4
      "w3-orange"
    when 5
      "w3-deep-orange"
    else
      ""
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_ttt
    @ttt = Ttt.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def ttt_params
    params.require(:ttt).permit(:title, :theme, :priority, :term, :user_id, :is_done)
  end
end
