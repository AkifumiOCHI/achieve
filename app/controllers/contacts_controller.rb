class ContactsController < ApplicationController
  before_action :authenticate_user!

  def new
      if params[:back]
          @contact = Contact.new(contacts_params)
      else
          @contact = Contact.new
      end
  end

  def create
      @contact = Contact.create(contacts_params)
      @contact.email = current_user.email
      if @contact.save
         redirect_to root_path, notice: "お問い合わせいただきありがとうございました！"
         NoticeMailer.sendmail_contact(@contact).deliver
      else
         render 'new'
      end
  end

  def confirm
      @contact = Contact.new(contacts_params)
      render :new if @contact.invalid?
  end

  private
   def contacts_params
       params.require(:contact).permit(:name, :email, :content)
   end
end
