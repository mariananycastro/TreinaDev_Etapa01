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
    get 'end_job_opportunity', on: :member
    resources :profiles, except: [:index, :create, :new, :edit, :show, :update, :destroy] do
      get 'invitation_without_subscription', on: :member
    end  
    resources :subscriptions, except: [:index, :create, :new, :edit, :show, :update, :destroy] do
      resources :feedbacks, except: [:index, :edit, :update, :destroy] 
      resources :invitations, except: [:index, :edit, :update, :destroy] do
        get 'accept_invitation', on: :member
        get 'reject_invitation', on: :member 
      end
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
    resources :profile_comments, except: [:index] 
  end
end
