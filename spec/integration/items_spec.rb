require 'swagger_helper'

describe 'Items API' do
  path '/api/v1/items' do
    post 'creates an item' do
      tags 'items'
      security [ Bearer: {} ]
      description 'Creates a new item with given key/value data attributes.'
      consumes 'application/json'
      parameter name: :item, in: :body, schema: { '$ref' => '#/components/schemas/new_item' }, description: "Test"
      produces 'application/json'

      let(:Authorization) { "Bearer #{@user.profile.api_key}" }
      let(:item) { {name: "iMac", brand: "Apple"} }

      before(:each) do
        @user = FactoryBot.create(:user)
      end

      response '200', 'Item created.' do
        schema type: :object,
          properties: {
            message: { type: :string, enum: ['Item created successfully.'] },
            id: { type: :integer }
          }
      
        run_test! do
           puts response.body
        end
      end
    end
  end

  path '/api/v1/items/{id}' do
    get 'retrieves an item' do
      tags 'items'
      security [Bearer: {}]
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer

      let(:Authorization) { "Bearer #{@user.profile.api_key}" }
      let(:id) { Item.create(name: 'MacBook Pro', brand: 'Apple', user_id: @user.id).id }
      let(:item) { {name: "iMac", brand: "Apple"} }

      before(:each) do
        @user = FactoryBot.create(:user)
      end

      response '200', 'item found' do
        # reference to item definition in swagger_helpber.rb
        schema '$ref' => '#/components/schemas/item'

        let(:id) { Item.create(name: 'MacBook Pro', brand: 'Apple', user_id: @user.id).id }

        run_test! do
          puts response.body
        end
      end

      response '401', 'invalid authorization' do
        let(:Authorization) { "Bearer !WRONG TOKEN!" }
        
        run_test! do
          puts response.body
        end
      end

      response '404', 'item not found' do
        #let(:Authorization) { "Bearer #{@user.profile.api_key}" }
        let(:id) { '-1' }

        run_test! do
          puts response.body
        end
      end

      response '406', 'unsupported accept header' do
        let(:Accept) { 'application/foo' }

        run_test! do
          puts response.body
        end
      end
    end
  end
end
