require 'rails_helper'

RSpec.describe 'Contact Management', type: :system do
  let!(:contact1) { create(:contact, name: 'John Doe', email: 'john.doe@example.com', phone: '1234567890') }
  let!(:contact2) { create(:contact, name: 'Jane Smith', email: 'jane.smith@example.com', phone: '9876543210') }

  after do
    sleep(3)
  end

  # Displaying all contacts (Index action)
  scenario 'User views the list of all contacts' do
    visit contacts_path
    expect(page).to have_content('Contacts Manager')
    expect(page).to have_content('John Doe')
    expect(page).to have_content('Jane Smith')
    expect(page).to have_content('1234567890')
    expect(page).to have_content('9876543210')
  end

  # Creating a new contact (Create action)
  scenario 'User creates a new contact' do
    visit new_contact_path
    fill_in 'Name', with: 'Alice Wonderland'
    fill_in 'Phone', with: '5551234567'
    fill_in 'Email', with: 'alice@example.com'
    attach_file 'Image', Rails.root.join('spec/fixtures/sample_image.png')
    sleep(2)
    click_button 'Create Contact'

    expect(page).to have_content('Contact was successfully created.')

    visit contacts_path
    expect(page).to have_content('Alice Wonderland')
    expect(page).to have_content('5551234567')
    expect(page).to have_content('alice@example.com')
  end

  # Editing an existing contact (Edit action)
  scenario 'User edits a contact' do
    visit edit_contact_path(contact1)
    fill_in 'Name', with: 'Updated John Doe'
    fill_in 'Phone', with: '5559876543'
    fill_in 'Email', with: 'updated.john.doe@example.com'
    sleep(2)
    click_button 'Update Contact'

    expect(page).to have_content('Contact was successfully updated.')

    visit contacts_path
    expect(page).to have_content('Updated John Doe')
    expect(page).to have_content('5559876543')
    expect(page).to have_content('updated.john.doe@example.com')
  end

  # Deleting a contact (Destroy action)
  scenario 'User deletes a contact' do
    visit contacts_path
    expect(page).to have_content(contact1.name)
    sleep(2)
    accept_confirm do
      find("a[href='/contacts/#{contact1.id}'][data-method='delete']").click
    end
    
    expect(page).to have_content('Contact was successfully deleted.')
    expect(page).not_to have_content(contact1.name)
  end

  # Searching for a contact by name, phone number, or email
  scenario 'User searches for a contact by name' do
    visit contacts_path

    fill_in 'Search Contacts...', with: 'John'
    sleep(2)
    click_button 'Search'
    expect(page).to have_content('John Doe')
    expect(page).not_to have_content('Jane Smith')
    expect(page).not_to have_content('Alice Wonderland')
  end

  scenario 'User searches for a contact by phone number' do
    visit contacts_path

    fill_in 'Search Contacts...', with: '9876543210'
    sleep(2)
    click_button 'Search'
    expect(page).to have_content('Jane Smith')
    expect(page).not_to have_content('John Doe')
    expect(page).not_to have_content('Alice Wonderland')
  end

  scenario 'User searches for a contact by email' do
    visit contacts_path

    fill_in 'Search Contacts...', with: 'jane.smith@example.com'
    sleep(2)
    click_button 'Search'
    expect(page).to have_content('Jane Smith')
    expect(page).not_to have_content('John Doe')
  end

  scenario 'User searches with no matching result' do
    visit contacts_path

    fill_in 'Search Contacts...', with: 'Nonexistent'
    sleep(2)
    click_button 'Search'
    expect(page).to have_content('No contacts found.')
    expect(page).not_to have_content('John Doe')
    expect(page).not_to have_content('Jane Smith')
    expect(page).not_to have_content('Alice Wonderland')
  end
end
