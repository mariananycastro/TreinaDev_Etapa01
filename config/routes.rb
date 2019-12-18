Rails.application.routes.draw do
  devise_for :headhunters
  devise_for :job_seekers
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "home#index"
  resources :profiles 
  resources :job_opportunities do
    post 'subscribe', on: :member
    delete 'subscribe', on: :member
    get 'subscriptions_by_job_seeker', on: :collection
  end
  resources :subscriptions
end
