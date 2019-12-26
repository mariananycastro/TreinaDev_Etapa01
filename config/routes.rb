Rails.application.routes.draw do
  root to: "home#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :headhunters
  resources :headhunters, except: [:index, :create, :new, :edit, :show, :update, :destroy] do
    resources :job_opportunities do
      get 'search', on: :collection
    end
  end
  resources :job_opportunities, only: [:index, :show] do
    post 'job_seeker_subscribe', on: :member
    delete 'cancel_subscription', on: :member
    get 'search', on: :collection 
  
    resources :subscriptions, except: [:index, :create, :new, :edit, :show, :update, :destroy] do
      resources :feedbacks, except: [:index, :edit, :update, :destroy] 
      resources :invitations, except: [:index, :edit, :update, :destroy]
    end
  end

  devise_for :job_seekers 
  resources :job_seekers, except: [:index, :create, :new, :edit, :show, :update, :destroy] do  
    resources :profiles, only: [:new, :create, :edit, :update ]
    resources :subscriptions, only: [:index]
  end 
  resources :profiles, only: [:show] do
    get 'search', on: :collection
    get 'add_star', on: :member   
    get 'remove_star', on: :member  
    resources :job_opportunities, except: [:index, :create, :new, :edit, :show, :update, :destroy] do
      get 'create_subscription_and_send_to_invitation', on: :member
    end
    resources :profile_comments, except: [:index] 
  end
end
