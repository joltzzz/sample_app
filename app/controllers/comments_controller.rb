class CommentsController < ApplicationController
    def create
        @micropost = Micropost.find(params[:id])
        @comment = @micropost.comments.create(comment_params, user: current_user)
        if !@comment.save
            flash[:notice] = @comment.errors.full_message_to_sentence
        end
        redirect_to micropost_path(@micropost)
    end

    def destroy
        @micropost = Micropost.find(params[:id])
        @comment.destroy
        redirect_to micropost_path(@micropost)
    end

    private
    
        def comment_params 
            params
            .require(:comment)
            .permit(:content)
        end

end
