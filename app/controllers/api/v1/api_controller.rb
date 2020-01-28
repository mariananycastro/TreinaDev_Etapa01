class Api::V1::ApiController < ActionController::API
    namespace :api, defaults: { format: 'json' }
    #qdo nao declaro restricao ele volta html
end