require 'rails_helper'

RSpec.describe "Contacts", type: :request do
  let!(:contact1) { create(:contact, name: 'Ram Bahadur', email: 'ram.bdr@example.com', phone: '1234567890') }
  let!(:contact2) { create(:contact, name: 'Hari Bahadur', email: 'hari.bdr@example.com', phone: '9876543210') }

  describe 'GET /contacts' do
    context 'when no search query is provided' do
      it 'returns all contacts with a successful response' do
        get contacts_path
        
        expect(response).to have_http_status(:ok)
        expect(response.body).to include(contact1.name, contact2.name)
      end
    end

    context 'when a search query is provided' do
      it 'returns the contacts that match the query' do
        get contacts_path, params: { query: 'Ram' }

        expect(response).to have_http_status(:ok)
        expect(response.body).to include(contact1.name)
        expect(response.body).not_to include(contact2.name)
      end
    end
  end

  describe 'GET /contacts/:id' do
    subject { contact1 }

    it 'returns the contact details with a successful response' do
      get contact_path(subject)

      expect(response).to have_http_status(:ok)
      expect(response.body).to include(subject.name, subject.email, subject.phone)
    end
  end

  describe 'GET /contacts/new' do
    it 'renders the new contact form' do
      get new_contact_path

      expect(response).to have_http_status(:ok)
      expect(response.body).to include('New Contact')
    end
  end

  describe 'POST /contacts' do
    context 'with valid attributes' do
      it 'creates a new contact and redirects to the index' do
        expect {
          post contacts_path, params: { contact: attributes_for(:contact) }
        }.to change(Contact, :count).by(1)

        expect(response).to redirect_to(contacts_path)
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new contact and re-renders the form with error messages' do
        expect {
          post contacts_path, params: { contact: { name: nil, phone: '1234567890', email: 'invalid@example.com' } }
        }.not_to change(Contact, :count)
  
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET /contacts/:id/edit' do
    subject { contact1 }

    it 'renders the edit form for the contact' do
      get edit_contact_path(subject)

      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Edit Contact')
    end
  end

  describe 'PATCH/PUT /contacts/:id' do
    subject { contact1 }

    context 'with valid attributes' do
      it 'updates the contact and redirects to the index' do
        patch contact_path(subject), params: { contact: { name: 'Updated Name' } }
        subject.reload

        expect(subject.name).to eq('Updated Name')
        expect(response).to redirect_to(contacts_path)
      end
    end

    context 'with invalid attributes' do
      it 'does not update the contact and re-renders the form with error messages' do
        patch contact_path(subject), params: { contact: { name: nil } }
  
        expect(subject.reload.name).to eq('Ram Bahadur')
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /contacts/:id' do
    subject { contact1 }

    it 'deletes the contact and redirects to the index' do
      expect {
        delete contact_path(subject)
      }.to change(Contact, :count).by(-1)

      expect(response).to redirect_to(contacts_path)
    end
  end
end
