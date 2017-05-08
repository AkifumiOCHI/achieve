class CommentsController < ApplicationController #コメントを投稿・保存するため
  def create #コメントを投稿・保存するためのアクション
    @blog = Blog.find(params[:blog_id]) #Blogを、blog_idのパラメータから探し出し、Blogに紐づくcommentとしてbuildする
    @comment = @blog.comments.build(comment_params) #comment_paramsを引数にとり、buildのタイミングでcontentが保存されるようにした
    @comment.user_id = current_user.id #その上で、コメントユーザidを現在のユーザから引っ張ってくる処理を行う。
    @notification = @comment.notifications.build(user_id: @blog.user.id) #commentに紐付いた、notificationを作成し、通知と受け手となるuser_idも保存

    respond_to do |format| #クライアント要求に応じてフォーマットを変更
      if @comment.save
        flash.now[:notice] = 'コメントを投稿しました！' #試してみたところ、アクションの下にflash.nowを入れ、js側にもflash関連の行を追加することが必要だった
        format.html {redirect_to blog_path(@blog), notice: 'コメントを投稿しました！'}
        format.js {render :index} #js形式でレスポンスを返す。（Ajaxではjson形式で返すことになっている）
        unless @comment.blog.user_id == current_user.id
          Pusher.trigger("user_#{@comment.blog.user_id}_channel", 'comment_created', {
            message: '作成したブログにコメントがつきました！'
          })
        end
        Pusher.trigger("user_#{@comment.blog.user_id}_channel", 'notification_created', {
          unread_counts: Notification.where(user_id: @comment.blog.user.id, read: false).count
        })
      else
        format.html {render :new}
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash.now[:notice] = 'コメントを削除しました！'
    respond_to do |format|
      format.html {redirect_to blog_path(@blog), notice: 'コメントを削除しました！' }
      format.js {render :index }
    end
  end

  private #ストロングパラメータ
    def comment_params
      params.require(:comment).permit(:content) #blog.idはpermitから抜いた
    end
end
