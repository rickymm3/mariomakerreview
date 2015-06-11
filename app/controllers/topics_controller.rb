class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update, :destroy]
  before_action :set_cliq, only: [:new, :show, :create]
  before_action :get_replies, only: [:show]
  before_action :authenticate_user!, :only => [:new, :create, :report]
  load_and_authorize_resource
  skip_authorize_resource :only => :show

  def show
    @topic = Topic.find(params[:id])
    @is_mod = check_if_mod(@topic)
    if impressionist(@topic, "message...", :unique => [:session_hash])
      @topic.update_columns(exp:@topic.increment(:exp, 1).exp)
    end
  end

  def create
    @topic = Topic.new(topic_params)
    @topic.cliq_id = params['cliq_id']
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
    @topic = Topic.new(cliq_id: params[:cliq_id])
  end

  def destroy
  end

  def edit
    # edit_permissions(params['id'], 'topic')
  end

  def update
    if @topic.update(topic_params)
      redirect_to @topic, notice: "#{@topic.class} was successfully updated."
    else
      render :edit
    end
  end

  private

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
      @cliq = Cliq.find(@topic.cliq_id)
      @ancestors = @cliq.ancestors
    else
      @cliq = Cliq.find(params[:cliq_id])
      end
  end

  def set_topic
    @topic = Topic.find(params[:id])
  end

  def topic_params
    params.require(:topic).permit(:subject, :body, :cliq_id, :sticky, :locked)
  end

end
