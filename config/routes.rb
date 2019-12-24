Rails.application.routes.draw do
  root to: "home#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :headhunters
  resources :headhunters, except: [:index, :create, :new, :edit, :show, :update, :destroy] do
    resources :job_opportunities
  end
  resources :job_opportunities, only: [:index, :show] do
    post 'job_seeker_subscribe', on: :member
    delete 'cancel_subscription', on: :member
    get 'search', on: :collection
    resources :subscriptions, except: [:index, :create, :new, :edit, :show, :update, :destroy] do
      resources :subscription_comments
      resources :feedbacks, except: [:index, :edit, :update, :destroy] 
      resources :invitations, except: [:index, :edit, :update, :destroy]
    end
  end

  devise_for :job_seekers 
  resources :job_seekers, except: [:index, :create, :new, :edit, :show, :update, :destroy] do  
    resources :profiles, only: [:new, :create, :edit, :update ]
    resources :subscriptions, only: [:index]
  end 
  resources :profiles, only: [:show]  

end
