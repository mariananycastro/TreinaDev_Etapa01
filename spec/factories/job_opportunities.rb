FactoryBot.define do

    factory :job_opportunity do
  
        headhunter
        name { 'Programador Ruby' }  
        description { 'Vaga para programador Ruby' }  
        habilities { 'Saber programar' }  
        salary_range { '5000' } 
        opportunity_level { 'Pleno' }  
        end_date_opportunity { '2020-02-02' }
        region { 'São Paulo' }
    end
end
