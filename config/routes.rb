Rails.application.routes.draw do
  root to: "home#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :headhunters
  resources :headhunters do
    resources :job_opportunities
  end
  resources :job_opportunities do
    post 'subscribe', on: :member
    delete 'cancel_subscription', on: :member
    get 'subscriptions_by_job_seeker', on: :collection
  end

  devise_for :job_seekers 
  resources :job_seekers do  
    resources :profiles, only: [:new, :create, :edit, :update ]
  end 
  resources :profiles, only: [:show]
  resources :subscriptions
  resources :subscription_comments, only: [:new, :create] 

end
