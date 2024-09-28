class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]
  
  helper_method :sort_column, :sort_direction

  # GET /contacts
  # Handles fetching and displaying contacts with optional search and sorting functionality.
  # Paginates contacts, limiting to 10 per page.
  def index
    @page = params.fetch(:page, 1).to_i  # Get current page number, default to 1
    @per_page = 10  # Set the number of contacts per page
    offset = (@page - 1) * @per_page  # Calculate the offset for the query
  
    # Fetch contacts based on search query or fetch all contacts with sorting applied
    @contacts = if params[:query].present?
                  Contact.search(params[:query]).order("#{sort_column} #{sort_direction}").limit(@per_page).offset(offset)
                else
                  Contact.all.order("#{sort_column} #{sort_direction}").limit(@per_page).offset(offset)
                end
  
    # Calculate total number of pages for pagination
    total_contacts = params[:query].present? ? Contact.search(params[:query]).count : Contact.count
    @total_pages = (total_contacts / @per_page.to_f).ceil
  end

  # GET /contacts/:id
  # Displays a single contact's details based on the provided ID
  def show
  end

  # GET /contacts/new
  # Renders the form to create a new contact
  def new
    @contact = Contact.new
  end

  # POST /contacts
  # Handles the creation of a new contact and redirects to the index or re-renders the form with errors.
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
  # Renders the form to edit an existing contact based on the provided ID
  def edit
  end

  # PATCH/PUT /contacts/:id
  # Handles updating an existing contact and redirects to the index or re-renders the form with errors.
  def update
    if @contact.update(contact_params)
      flash[:notice] = 'Contact was successfully updated.'
      redirect_to contacts_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /contacts/:id
  # Deletes the contact from the database and redirects to the index with a success message.
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

  # Determines the column to sort the contacts by (defaults to 'name' if no valid column is provided)
  def sort_column
    %w[name phone email].include?(params[:sort]) ? params[:sort] : "name"
  end
  
  # Determines the direction of sorting (defaults to 'asc' if no valid direction is provided)
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
