class CommentsController < ApplicationController
    def create
        @comment = current_user.comments.new(comment_params)
        if !@comment.save
            flash[:notice] = @comment.errors.full_message_to_sentence
        end

        redirect_to post_path(params[:micropost_id])


    end

    def destroy
        @micropost = Micropost.find(params[:id])
    end

    private

    def comment_params
        params
            .require(:comment)
            .permit(:content)
            .merge(micropost_id: params[:micropost_id])
    end
end
