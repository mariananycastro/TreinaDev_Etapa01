FactoryBot.define do

    factory :subscription do
        job_seeker
        job_opportunity
        status {false}
        hh_answer_type {}
        hh_answer {}

    end
  end