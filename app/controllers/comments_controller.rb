class CommentsController < ApplicationController
  # before_action :set_comment, only: [:show, :edit, :update, :destroy]


  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  # Heavily used https://www.youtube.com/watch?v=rTP1eMfI5Bs as a resource.
  def create
    @topic = Topic.find(params[:topic_id])
    @comment = @topic.comments.create(comment_params)
    @comment.user_id = current_user.id if current_user
    @comment.save

      if @comment.save
        redirect_to topic_path(@topic)
      else
        render 'new'
      end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @topic = Topic.find(params[:topic_id])
    @comment = @topic.comments.find(params[:id])
    @comment.destroy
    redirect_to topic_path(@topic)

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:content)
    end
end
