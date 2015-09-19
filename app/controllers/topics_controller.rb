class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update, :destroy]
  before_action :set_cliq, only: [:new, :show, :create]
  before_action :get_replies, only: [:show]
  before_action :authenticate_user!, :only => [:new, :create, :report, :edit]
  before_action :check_if_locked, only: [:edit, :update]

  load_and_authorize_resource
  skip_authorize_resource :only => :show

  def show
    @topic = Topic.friendly.find(params[:id])
    add_cliq_to_session(@topic.cliq)
    @is_mod = check_if_mod(@topic)
    if impressionist(@topic, "message...", :unique => [:session_hash])
      @topic.update_columns(exp:@topic.increment(:exp, 1).exp)
    end
  end

  def create
    @topic = Topic.new(topic_params)
    @topic.cliq_id = Cliq.friendly.find(params[:cliq_id]).id
    @topic.user_id = current_user.id
    @cliq.touch
    respond_to do |format|
      if @topic.save
        format.html { redirect_to @topic.cliq, notice: 'Item was successfully created.' }
        format.json { render action: 'show', status: :created, location: @topic }
      else
        format.html { render action: 'new' }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end

  end

  def new
    @topic = Topic.new(cliq_id: Cliq.friendly.find(params[:cliq_id]).id)
  end

  def destroy
  end

  def edit
    unless check_if_owner?
      redirect_to [@topic.cliq, @topic], notice: "you do not have authority to edit"
    end
    # edit_permissions(params['id'], 'topic')
  end

  def update
    if @topic.update(topic_params)
      redirect_to [@topic.cliq, @topic], notice: "#{@topic.class} was successfully updated."
    else
      render :edit
    end
  end

  private


  def check_if_owner?
    if current_user
      @topic.user_id == current_user.id
    else
      false
    end
  end

  def check_if_locked
    if @topic.locked?
      redirect_to [@topic.cliq, @topic], notice: "#{@topic.class} is locked and can not be edited." unless topic_params.has_key?(:locked)
    end
  end

  def check_if_mod(topic)
    # if current_user
    #   current_user.roles.where(topic_id: topic.id, user_id: current_user.id, role:'mod').present?
    # else
    #   false
    # end
  end

  def get_replies
    @replies = @topic.replies
  end

  def set_cliq
    if @topic
      @cliq = Cliq.friendly.find(@topic.cliq_id)
      @ancestors = @cliq.ancestors
    else
      @cliq = Cliq.friendly.find(params[:cliq_id])
      end
  end

  def set_topic
    @topic = Topic.friendly.find(params[:id])
  end

  def topic_params
    params.require(:topic).permit(:subject, :body, :cliq_id, :sticky, :locked, :opened)
  end

end
