class MessagesController < ApplicationController
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end

  def index
    @messages = @conversation.messages #会話に紐づくメッセージを取得する。
    if @messages.length > 10 #もしメッセージが10以上続いたら
      @over_ten = true #10以上のフラグを立てて、
      @messages = @messages[-10..-1] #メッセージを10までに表示数を絞る
    end

    if params[:m] #もしそうでなければ
      @over_ten = false #10より大きいフラグを無効にして
      @messages = @conversation.messages #全てのメッセージを取得する。
    end

    if @messages.last #もしメッセージが最新（最後）のメッセージで、
      if @messages.last.user_id != current_user.id #かつユーザIDが自分（ログインユーザ）でなければ
        @messages.last.read = true # その最新（最後）のメッセージを既読にする
      end
    end

    @message = @conversation.messages.build #新規投稿のメッセージ用の変数を作成する
  end

  def create
    @message = @conversation.messages.build(message_params) #HTTPリクエスト上のパラメータを利用して会話にひもづくメッセージを生成
    if @message.save
      redirect_to conversation_messages_path(@conversation)
    end
  end

  private
    def message_params
      params.require(:message).permit(:body, :user_id)
    end
end
