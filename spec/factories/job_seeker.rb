FactoryBot.define do
    sequence :email do |n|
        "person#{n}@example.com"
      end

    factory :job_seeker do
        email 
        password { '12345678' }
    end
end