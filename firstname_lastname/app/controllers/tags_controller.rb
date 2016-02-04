class TagsController < ApplicationController

  def create
    @tag = Tag.new(tag_params)
    @tag.post_id = params[:post_id]
    if @tag.save
      flash[:notice] = "Thanks for taggin' that there post, hombre!"
      fail
      redirect_to post_url(@tag.post)
    else
      flash[:errors] = @tag.errors.full_messages
      redirect_to post_url(@tag.post)
    end
  end

  def destroy
    Tag.delete(params[:id])
    redirect_to post_url(params[:post_id])
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end

end
