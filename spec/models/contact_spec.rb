require 'rails_helper'

RSpec.describe Contact, type: :model do
  subject { build(:contact) }

  describe 'validations' do
    it { is_expected.to be_valid }

    context 'when name is nil' do
      before { subject.name = nil }
      it { is_expected.to_not be_valid }
    end

    context 'when email is nil' do
      before { subject.email = nil }
      it { is_expected.to_not be_valid }
    end

    context 'when email is invalid' do
      before { subject.email = 'invalid-email' }
      it { is_expected.to_not be_valid }
    end

    context 'when phone is nil' do
      before { subject.phone = nil }
      it { is_expected.to_not be_valid }
    end

    context 'when phone is too short' do
      before { subject.phone = '123' }
      it { is_expected.to_not be_valid }
    end
  end

  describe 'scopes' do
    describe '.search' do
      let!(:contact1) { create(:contact, name: 'John Doe', email: 'john.doe@example.com', phone: '1234567890') }
      let!(:contact2) { create(:contact, name: 'Jane Smith', email: 'jane.smith@example.com', phone: '9876543210') }
      let!(:contact3) { create(:contact, name: 'Alice Wonderland', email: 'alice@example.com', phone: '5551234567') }

      context 'when searching by name' do
        it 'returns contacts that match the query' do
          expect(Contact.search('John')).to include(contact1)
          expect(Contact.search('John')).not_to include(contact2, contact3)
        end
      end

      context 'when searching by email' do
        it 'returns contacts that match the query' do
          expect(Contact.search('alice@example.com')).to include(contact3)
          expect(Contact.search('alice@example.com')).not_to include(contact1, contact2)
        end
      end

      context 'when searching by phone' do
        it 'returns contacts that match the query' do
          expect(Contact.search('9876543210')).to include(contact2)
          expect(Contact.search('9876543210')).not_to include(contact1, contact3)
        end
      end

      context 'when there are no matches' do
        it 'returns no contacts' do
          expect(Contact.search('Nonexistent')).to be_empty
        end
      end
    end
  end
end
