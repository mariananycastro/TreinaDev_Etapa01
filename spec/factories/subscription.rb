FactoryBot.define do
    factory :subscription do
        job_seeker
        job_opportunity
        status {false}
        hh_answer_type {}
        hh_answer {}

          #association :job_seeker, :job_opportunity, name: 'John Doe'
    #association :job_seeker, :admin, factory: :user, name: 'John Doe'
    #association :author, factory: [:user, :admin], name: 'John Doe'
    #create(:post).user
        
    end
  end

