require 'swagger_helper'

describe 'Items API' do
  path '/api/v1/items/{id}' do
    get 'retrieves an item' do
      tags 'Items'
      security [Bearer: {}]
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer

      response '200', 'item found' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 created_at: { type: :datetime },
                 updated_at: { type: :datetime },
                 name: { type: :string },
                 brand: { type: :string },
                 user_id: { type: :integer }
               },
               required: %w[id name brand]

        user = User.first_or_create(email: 'hans@mustermann.de', password: '123456', password_confirmation: '123456')
        user.create_profile(api_key: '123456xyz')

        let(:Authorization) { "Bearer #{user.profile.api_key}" }
        let(:id) { Item.create(name: 'MacBook Pro', brand: 'Apple', user_id: user.id).id }

        run_test! do |response|
          # futher tests possbile here
        end
      end

      response '404', 'item not found' do
        user = User.first_or_create(email: 'hans@mustermann.de', password: '123456', password_confirmation: '123456')
        user.create_profile(api_key: '123456xyz')

        let(:Authorization) { "Bearer #{user.profile.api_key}" }
        let(:id) { 'invalid' }

        run_test!
      end

      response '406', 'unsupported accept header' do
        user = User.first_or_create(email: 'hans@mustermann.de', password: '123456', password_confirmation: '123456')
        user.create_profile(api_key: '123456xyz')

        let(:Authorization) { "Bearer #{user.profile.api_key}" }
        let(:id) { user.id }
        let(:Accept) { 'application/foo' }

        run_test!
      end
    end
  end
end
