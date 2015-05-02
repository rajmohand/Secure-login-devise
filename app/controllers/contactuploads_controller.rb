require 'csv'

class ContactuploadsController < ApplicationController

  def new
    @contact = Contact.new
  end

  def index
    respond_to do |format|
      format.html
      format.csv { send_data Contact.bulk_insert(current_user.id) }
    end
  end

  def create
    uploadedfile = contact_params[:datafile]
    filename = uploadedfile.original_filename
    content=uploadedfile.read
    File.open("#{Rails.root}"+"/public/"+"#{filename}","wb") {|f| f.write(content) }
    contact = Contact.delay.contactupload(filename,current_user.id)
    #contatarray = Contact.bulk_insert()
    redirect_to '/contacts',notice: contact
  end

  private
  def contact_params
    params.require(:contact).permit(:datafile)
  end
end
