# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'Timly API',
        version: 'v1'
      },
      components: {
        securitySchemes: {
          Bearer: {
            type: :apiKey,
            name: 'Authorization',
            in: :header
          }
        },
        schemas: {
          item: {
            type: 'object',
            properties: {
              item_id: { type: 'integer' },
              name: { type: 'string' },
              status: { type: 'string' },
              remarks: { type: 'string' },
              root_category: { 
                type: 'object',
                properties: {
                  id: { type: 'integer' },
                  name: { type: 'string' }
                }
              },
              category: { 
                type: 'object',
                properties: {
                  id: { type: 'integer' },
                  name: { type: 'string' }
                }
              },
              responsible: {
                type: 'object',
                properties: {
                  id: { type: 'integer' },
                  name: { type: 'string' }
                }
              },
              location: {
                type: 'object',
                properties: {
                  id: { type: 'integer' },
                  name: { type: 'string' }
                }
              },
              custom_attributes: {
                type: 'object',
                properties: {
                  attribute_key1: { type: 'string' },
                  attribute_key2: { type: 'string' },
                  attribute_key3: { type: 'string' } 
                }
              },
              barcode: { type: 'string' }
            },
            example: {
              item_id: '12345',
              name: 'Eves MacBook',
              status: 'active',
              remarks: 'some remarks',
              root_category: {
                id: '1234',
                name: 'root_category name'
              },
              category: {
                id: '5678',
                name: 'category name'
              },
              responsible: {
                id: '0815',
                name: 'Eves service provider'
              },
              location: {
                id: '123',
                name: 'location xyz'
              },
              custom_attributes: {
                custom_attribut_key1: 'value1', 
                custom_attribut_key2: 'value2',
                custom_attribut_key3: 'value3' 
              },
              barcode: '123456'
            }
          }
        }
      },
      paths: {},
      servers: [
        {
          url: 'http://{defaultHost}',
          variables: {
            defaultHost: {
              default: 'localhost:3000'
            }
          }
        }
      ],
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The swagger_docs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.swagger_format = :yaml
end
