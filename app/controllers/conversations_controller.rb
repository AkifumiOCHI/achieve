class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @conversations = Conversation.all
  end # 全てのユーザと会話一覧を取得する。

  def create
    if Conversation.between(params[:sender_id],params[:recipient_id]).present? #該当のユーザ間での会話が過去に存在しているかを確認する
      @conversation = Conversation.between(params[:sender_id],params[:recipient_id]).first #あれば取得する。
    else
      @conversation = Conversation.create!(conversation_params) #なければ強制的に生成する
    end

    redirect_to conversation_messages_path(@conversation) #何れにしてもメッセージの一覧画面に遷移させる
  end


  private
    def conversation_params
      params.permit(:sender_id, :recipient_id)
    end
end
