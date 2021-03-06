require 'rails_helper'
    feature 'job seeker cant subscribe' do
        scenario 'without profile' do
            job_seeker = JobSeeker.create!(email: 'js@test.com', password: '123456')
            headhunter = Headhunter.create!(email: 'hh@test.com', password: '123456')        
            job_opportunity = JobOpportunity.create!(headhunter: headhunter, name: 'Programador Ruby', description: 'Vaga para programador Ruby',
                                                       habilities: 'Saber programar', salary_range: 5000, 
                                                       opportunity_level: 'Pleno', end_date_opportunity: '02/02/2021',
                                                       region: 'Sâo Paulo')
    
            login_as(job_seeker, scope: :job_seeker)
    
            visit root_path
            click_on 'Vagas'
            click_on "#{job_opportunity.name} #{job_opportunity.opportunity_level} #{job_opportunity.end_date_opportunity} "\
                        "#{job_opportunity.region}"
            click_on 'Inscrição para Vaga'

            expect(page).to have_content 'Você deve preencher seu perfil antes de continuar'
            expect(current_path).to eq(new_job_seeker_profile_path(job_seeker))
            
        end
    end