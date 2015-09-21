class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update, :destroy]
  attr_accessor :upvote

  # GET /topics
  # GET /topics.json
  def index
    if params[:sort]
      @topics = Topic.includes(:comments).sort_by { |topic| topic.comments.count }.reverse
    elsif params[:sort_upvotes]
      @topics = Topic.includes(:upvotes).sort_by { |topic| topic.upvotes.count}.reverse
    else
      @topics = Topic.all.order('created_at DESC')
    end
  end

  def user_location
    @location = Net::HTTP.get_response(URI.parse('http://ipinfo.io/region')).body
  end

  def upvote
    @topic = Topic.find(params[:id])
    @topic.upvotes_count += 1
    @topic.save
    redirect_to(topic_path)
  end

  def sort_title
    # @topics = Topic.all.sort_by { |obj| obj.created_at}
    @topics = Topic.all.order('created_at DESC')
  end

  def sort_most_comments
    # @topics = Topic.joins(:comments).group("comments.id").count.sort
    Topic.includes(:comments).group('topics.title').count('comments.id')
  end

  def count_comments
    @count = Topic.find(params[:id]).comments.count
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
  end

  # GET /topics/new
  def new
    @topic = current_user.topics.build
  end

  # GET /topics/1/edit
  def edit
  end

  # POST /topics
  # POST /topics.json
  def create
    @topic = current_user.topics.build(topic_params)

    respond_to do |format|
      if @topic.save
        format.html { redirect_to @topic, notice: 'Topic was successfully created.' }
        format.json { render :show, status: :created, location: @topic }
      else
        format.html { render :new }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /topics/1
  # PATCH/PUT /topics/1.json
  def update
    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to @topic, notice: 'Topic was successfully updated.' }
        format.json { render :show, status: :ok, location: @topic }
      else
        format.html { render :edit }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to topics_url, notice: 'Topic was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      @topic = Topic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def topic_params
      params.require(:topic).permit(:title, :content, :likes)
    end
end
