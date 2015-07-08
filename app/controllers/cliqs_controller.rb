class CliqsController < ApplicationController
  before_action :set_cliq, only: [:show, :edit, :update, :destroy, :admin]
  before_action :set_index_cliq, only: [:index]
  before_action :set_filter, only: [:index, :show]
  before_action :authenticate_user!, :except => [:index, :show]
  load_and_authorize_resource
  skip_authorize_resource :only => [:show, :index]

  def index
    @topics = Topic.all.where(sticky:false).order("updated_at desc").page(params[:page]).limit(20)
    @stickies = Topic.all.where(cliq_id: @cliq.id, sticky:true).order("updated_at desc")
  end

  def show
    @stickies = Topic.all.where(cliq_id: @cliq.id, sticky:true).order("updated_at desc")
    @descendants = get_descendants(10)
    @descendants << @cliq.id
    if @filter
      @topics = get_topics("exp desc", 20)
    else
      @topics = get_topics("updated_at desc", 20)
    end
  end

  # def new
  #   @top_cliq = Cliq.where(is_main:true).first
  #   current_cliq = Cliq.find(params[:cliq_id])
  #   @cliq = Cliq.new(name:params[:new], parent: current_cliq)
  #   @create = true
  # end

  def new
    @create = true
    @cliq = Cliq.friendly.find(cliq_params[:parent_id])
    @search = set_search
    @new_cliq = Cliq.new(cliq_params)
  end

  def create
    cliq = Cliq.find(params[:cliq][:parent_id])
    @newcliq = cliq.children.create(cliq_params)
    respond_to do |format|
      if @newcliq.id
        format.html { redirect_to @newcliq, notice: 'Cliq was successfully created.' }
        format.json { render action: 'show', status: :created, location: @newcliq }
      else
        @oldcliq = Cliq.where(name:@newcliq.name, ancestry:@newcliq.ancestry).first
        format.html { redirect_to @oldcliq, notice: "That Cliq already exists.  You've been taken there automatically" }
        format.json { render json: @oldcliq.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if params[:cliq].has_key(:parent_id)

    end
  end

  def admin
    @admin = true
    @stickies = Topic.all.where(cliq_id: @cliq.id, sticky:true).order("updated_at desc")

    @descendants = get_descendants(10)
    @descendants << @cliq.id
    @topics = Topic.where(cliq_id: @descendants).where("reports > ?", 0).order("updated_at desc").page(params[:page]).limit(20)
  end

  private

  def get_topics(order, limit)
    Topic.where(cliq_id: @descendants, sticky:false).order(order).page(params[:page]).limit(limit)
  end

  def get_stickies
    Topic.where(cliq_id: @descendants, sticky:true)
  end

  def get_descendants(limit)
    @cliq.descendants.select(:id).order("updated_at desc").limit(limit).collect(&:id)
  end

  def set_filter
    @filter = params[:filter] if params[:filter]
  end

  def set_index_cliq
    @cliq = Cliq.friendly.find(1)
  end
  def set_cliq
    @cliq = Cliq.friendly.find(params[:id])
  end

  # def set_cliq
  #   if params[:id] || params[:id] == @top_cliq.id
  #     @cliq = Cliq.find(params[:id])
  #   else
  #     @cliq = @top_cliq
  #   end
  # end

  # Never trust parameters from the scary internet, only allow the white list through.
  def cliq_params
    params.require(:cliq).permit(:search, :parent_id, :name).merge(cached_name: params[:cliq][:name].downcase)
  end

  def set_search
    Cliq.friendly.search(params[:cliq][:name], @cliq)
    #automatically return the correct search if it matches
    # redirect_to(@search['match']) if @search['match'].present?
  end

end
