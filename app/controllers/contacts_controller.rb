class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  # GET /contacts
  def index
    @page = params.fetch(:page, 1).to_i  # Get current page number, default to 1
    @per_page = 10  # Set the number of contacts per page
    offset = (@page - 1) * @per_page  # Calculate the offset for the query
  
    # If there's a search query, paginate the search results, otherwise paginate all contacts
    @contacts = if params[:query].present?
                  Contact.search(params[:query]).limit(@per_page).offset(offset).order(created_at: :desc)
                else
                  Contact.all.limit(@per_page).offset(offset).order(created_at: :desc)
                end
  
    # Calculate total number of pages for pagination
    total_contacts = params[:query].present? ? Contact.search(params[:query]).count : Contact.count
    @total_pages = (total_contacts / @per_page.to_f).ceil
  end

  # GET /contacts/:id
  def show
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
  end

  # POST /contacts
  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      flash[:notice] = 'Contact was successfully created.'
      redirect_to contacts_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /contacts/:id/edit
  def edit
  end

  # PATCH/PUT /contacts/:id
  def update
    if @contact.update(contact_params)
      flash[:notice] = 'Contact was successfully updated.'
      redirect_to contacts_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /contacts/:id
  def destroy
    @contact.destroy
    flash[:notice] = 'Contact was successfully deleted.'
    redirect_to contacts_path
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_contact
    @contact = Contact.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def contact_params
    params.require(:contact).permit(:name, :phone, :email)
  end
end
