class MessagesController < ApplicationController
def index
    @user  = User.find(current_user.id)
    if @user.present?
    @message = Message.where(:reciver_id => @user.id)
    @contact = @user.contact
    else
      redirect_to '/login'
    end
  end

  def new
    #@user  = User.find(current_user.id)
    @message = Message.new
    @message.senderemail = current_user.email
  end

  def create
    @user  = User.find_by_email(message_params[:reciveremail])
    if @user.present?
    @message = Message.new(message_params)
    @message.user_id = current_user.id
    @message.reciver_id=@user.id
      if @message.save
        redirect_to '/messages'
      else
          format.html { render :new }
      end
    else
      format.html { render :new }
    end
  end

  private
  def message_params
    params.require(:message).permit(:reciveremail,:senderemail,:message)
  end
end
