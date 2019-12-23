require 'rails_helper'
    feature 'job seeker receives proposal from headhunter' do
        scenario 'successfully' do
            headhunter = Headhunter.create!(email: 'hh@test.com', password: '123456') 
            job_seeker = JobSeeker.create!(email: 'js@test.com', password: '123456')   
            profile = Profile.create!(job_seeker: job_seeker, name: 'Joao da Silva', document: '595.487.167-12', nick_name: 'João', day_of_birth: '12/01/1986', 
                                        education_level: 'Graduado', description: 'Ciencia da computacao',
                                        experience: 'Trabalhei com computacao')
            job_opportunity = JobOpportunity.create!(headhunter: headhunter, name: 'Programador Ruby', 
                                                     description: 'Vaga para programador Ruby',
                                                     habilities: 'Saber programar', salary_range: 5000, 
                                                     opportunity_level: 'Pleno', end_date_opportunity: '02/02/2020',
                                                     region: 'São Paulo')
            subscription = Subscription.create!(job_seeker:job_seeker, job_opportunity:job_opportunity) 
            invitation = Invitation.create!(title:'Passou', message:'Vamos agendar uma entrevista.')
            subscription.update_attribute(:hh_answer, invitation)

    
            login_as(job_seeker, scope: :job_seeker)
            visit root_path

            expect(page).to have_content 'Você tem uma proposta para a vaga: Programador Ruby Pleno 2020-02-02 São Paulo'

        end

        scenario 'successfully when job seeker subscribe' do
            headhunter = Headhunter.create!(email: 'hh@test.com', password: '123456') 
            job_seeker = JobSeeker.create!(email: 'js@test.com', password: '123456')   
            profile = Profile.create!(job_seeker: job_seeker, name: 'Joao da Silva', document: '595.487.167-12', nick_name: 'João', day_of_birth: '12/01/1986', 
                                        education_level: 'Graduado', description: 'Ciencia da computacao',
                                        experience: 'Trabalhei com computacao')
            job_opportunity = JobOpportunity.create!(headhunter: headhunter, name: 'Programador Ruby', 
                                                     description: 'Vaga para programador Ruby',
                                                     habilities: 'Saber programar', salary_range: 5000, 
                                                     opportunity_level: 'Pleno', end_date_opportunity: '02/02/2020',
                                                     region: 'São Paulo')
            subscription = Subscription.create!(job_seeker:job_seeker, job_opportunity:job_opportunity) 
            invitation = Invitation.create!(title:'Passou', message:'Vamos agendar uma entrevista.')
            subscription.update_attribute(:hh_answer, invitation)

    
            login_as(job_seeker, scope: :job_seeker)
            visit root_path
            click_on 'Programador Ruby Pleno 2020-02-02 São Paulo'

            expect(page).to have_content profile.nick_name
            expect(page).to have_content job_opportunity.description_job_opportunity        
            expect(page).to have_content 'Passou'
            expect(page).to have_content 'Vamos agendar uma entrevista'

        end
    end