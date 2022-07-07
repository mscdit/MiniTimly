require 'swagger_helper'

describe 'Items API' do
  path '/api/v1/items' do
    put 'creates an item' do
      tags 'items'
      security [ Bearer: {} ]
      description 'Creates a new item with given key/value data attributes.'
      consumes 'application/json'
      parameter name: :item, in: :body, description: "test", schema: {
        type: :object,
        properties: {
          name: { type: :string },
          brand: { type: :string }
        },
        required: [ 'name', 'brand' ]
      }
      produces 'application/json'

      response '200', 'Item created.' do
        schema type: :object, properties: {
          message: { type: :string }
        }
        example 'application/json', :example_key_2, {
          id: 1,
          title: 'Hello world!',
          content: '...'
        }, "Summary of the example", "Longer description of the example"

        run_test!
      end
    end
  end

  path '/api/v1/items/{id}' do
    get 'retrieves an item' do
      tags 'items'
      security [Bearer: {}]
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer

      response '200', 'item found' do
        # reference to item definition in swagger_helpber.rb
        schema '$ref' => '#/schemas/item'

        user = User.first_or_create(email: 'hans@mustermann.de', password: '123456', password_confirmation: '123456')
        user.create_profile(api_key: '123456xyz')

        let(:Authorization) { "Bearer #{user.profile.api_key}" }
        let(:id) { Item.create(name: 'MacBook Pro', brand: 'Apple', user_id: user.id).id }

        run_test! do
          puts response.body
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
