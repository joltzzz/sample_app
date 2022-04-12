class CommentsController < ApplicationController


    def create
        @micropost = Micropost.find(params[:micropost_id])
        @comment = @micropost.comments.new(comment_params)
        @comment.user = current_user   
        if @comment.save
            flash[:success] = "berhasil"
        else
            flash[:notice] = "ada error"
        end
        redirect_to micropost_comments_path(@micropost)
    end

    def destroy
        @micropost = Micropost.find(params[:micropost_id])
        @micropost.comments.find(params[:id]).destroy
        flash[:success] = "deleted successfully!"
        redirect_to micropost_comments_path(@micropost)
    end

    def index
        @micropost = Micropost.find(params[:micropost_id])
        @comment = Comment.all
    end

    def new
        @comment = Comment.new
    end

    def edit
        @micropost = Micropost.find(params[:micropost_id])
        @comment = @micropost.comments.find(params[:id])
    end

    def show
    end

    def update
        @micropost = Micropost.find(params[:micropost_id])
        @comment = Comment.find(params[:id])
        if @comment.update(comment_params)
            flash[:success] = "Updated Successfully!"
            redirect_to micropost_comments_path(@micropost)
        else
            render 'edit'
        end

    end

    private
    
        def comment_params 
            params
            .require(:comment)
            .permit(:content)
        end

end
