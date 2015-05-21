class CliqsController < ApplicationController
  before_action :set_cliq, only: [:index, :show, :edit, :update, :destroy, :admin]
  before_action :set_search, only: [:index, :show]
  before_action :set_filter, only: [:index, :show]
  before_action :authenticate_user!, :except => [:index, :show]
  load_and_authorize_resource
  skip_authorize_resource :only => [:show, :index]

  def index
    @descendants = get_descendants(10)
    @descendants << @cliq.id
    @topics = get_topics("updated_at desc", 20)
  end

  def show
    unless @search['temp']
      @descendants = get_descendants(10)
      @descendants << @cliq.id
    end
    if @filter
      @topics = get_topics("exp desc", 20)
    else
      @topics = get_topics("updated_at desc", 20)
    end
  end

  def new
    @top_cliq = Cliq.where(is_main:true).first
    current_cliq = Cliq.find(params[:cliq_id])
    @cliq = Cliq.new(name:params[:new], parent: current_cliq)
    @create = true
  end

  def create
    cliq = Cliq.find(params[:cliq][:parent_id])
    if params[:cliq][:is_category] == '1'
      @newcliq = cliq.children.create name: params[:cliq][:title].downcase, is_category: true
    else
      @newcliq = cliq.children.create name: params[:cliq][:title].downcase
    end

    respond_to do |format|
      if @newcliq
        format.html { redirect_to @newcliq, notice: 'Cliq was successfully created.' }
        format.json { render action: 'show', status: :created, location: @newcliq }
      else
        format.html { render action: 'new' }
        format.json { render json: @newcliq.errors, status: :unprocessable_entity }
      end
    end
  end

  def admin
    @admin = true
    @descendants = get_descendants(10)
    @descendants << @cliq.id
    @topics = Topic.where(cliq_id: @descendants).where("reports > ?", 0).order("updated_at desc").page(params[:page]).limit(20)
  end

  private

  def get_topics(order, limit)
    Topic.where(cliq_id: @descendants).order(order).page(params[:page]).limit(limit)
  end

  def get_descendants(limit)
    @cliq.descendants.select(:id).order("updated_at desc").limit(limit).collect(&:id)
  end

  def set_filter
    @filter = params[:filter] if params[:filter]
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_cliq
    if params[:id] || params[:id] == @top_cliq.id
      @cliq = Cliq.find(params[:id])
    else
      @cliq = @top_cliq
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def cliq_params
    params.require(:cliq).permit(:subject, :body, :user_id, :search)
  end

  def set_search
    @search = {'match' => nil}
    @search = Cliq.search(params[:cliq][:search], @cliq) if params.include?(:cliq)
    #automatically return the correct search if it matches
    # redirect_to(@search['match']) if @search['match'].present?
  end

end
