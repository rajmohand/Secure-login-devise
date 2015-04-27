class ContactsController < ApplicationController

 def new
    @contact = Contact.new
  end

  def index
    @user  = User.find(current_user.id)
    if @user.present?
      @contact = @user.contact
    else
      redirect_to '/login'
    end
  end

  def create
    contact = Contact.new(contact_params)
    contact.User_id = current_user.id
    if contact.save
      redirect_to '/contacts'
    else
      redirect_to '/contacts/new',notice: contact.errors.full_messages
    end
  end

  def edit
    @contact = Contact.find(params[:id])
  end

  def update
    contact = Contact.find(params[:id])
    if contact.update(contact_params)
      redirect_to '/contacts'
    else
      render 'edit'
    end
  end

  def destroy
    contact = Contact.find(params[:id])
    contact.destroy
    redirect_to contacts_path
  end

  private
  def contact_params
    params.require(:contact).permit(:name,:email,:phoneno,:Address)
  end

end
