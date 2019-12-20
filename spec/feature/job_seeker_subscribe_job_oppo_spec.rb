require 'rails_helper'
    feature 'Job Seeker subscribe' do
        it 'successfully' do
            job_seeker = JobSeeker.create!(email: 'js@test.com', password: '123456')
            headhunter = Headhunter.create!(email: 'hh@test.com', password: '123456')        
            job_opportunity = JobOpportunity.create!(headhunter: headhunter, name: 'Programador Ruby', description: 'Vaga para programador Ruby',
                                                       habilities: 'Saber programar', salary_range: 5000, 
                                                       opportunity_level: 'Pleno', end_date_opportunity: '02/02/2020',
                                                       region: 'São Paulo')
            profile = Profile.create!(name: 'Pedro', nick_name: 'Pedrinho', day_of_birth: '1986-02-02', education_level: 'Graduado',
                                        description: 'na faculdade', experience: 'programei', document: '521.730.870-29',
                                        job_seeker: job_seeker)

            login_as(job_seeker, scope: :job_seeker)
            visit root_path
            click_on 'Vagas'
            click_on "#{job_opportunity.name} #{job_opportunity.opportunity_level} #{job_opportunity.end_date_opportunity} #{job_opportunity.region}"
            click_on 'Candidatar para Vaga'

            expect(page).to have_content 'Inscrição realizada com sucesso!'
            expect(current_path).to eq(job_opportunity_path(job_opportunity))
            
        end

        it 'view all' do
            job_seeker = JobSeeker.create!(email: 'js@test.com', password: '123456')
            headhunter = Headhunter.create!(email: 'hh@test.com', password: '123456')        
            job_opportunity = JobOpportunity.create!(headhunter: headhunter, name: 'Programador Ruby', description: 'Vaga para programador Ruby',
                                                       habilities: 'Saber programar', salary_range: 5000, 
                                                       opportunity_level: 'Pleno', end_date_opportunity: '02/02/2020',
                                                       region: 'São Paulo')
            profile = Profile.create!(name: 'Pedro', nick_name: 'Pedrinho', day_of_birth: '1986-02-02', education_level: 'Graduado',
                                        description: 'na faculdade', experience: 'programei', document: '521.730.870-29',
                                        job_seeker: job_seeker)
                                        
            login_as(job_seeker, scope: :job_seeker)
            visit root_path
            click_on 'Vagas'
            click_on "#{job_opportunity.name} #{job_opportunity.opportunity_level} #{job_opportunity.end_date_opportunity}"\
                    " #{job_opportunity.region}"
            click_on 'Candidatar para Vaga'
            visit root_path
            click_on 'Inscrições'
                
            expect(current_path).to eq(subscriptions_by_job_seeker_job_opportunities_path)
            expect(page).to have_content("#{job_opportunity.name} #{job_opportunity.opportunity_level} "\
                                        "#{job_opportunity.end_date_opportunity} #{job_opportunity.region}")
            
        end

        it 'view none' do
            job_seeker = JobSeeker.create!(email: 'js@test.com', password: '123456')
            headhunter = Headhunter.create!(email: 'hh@test.com', password: '123456')        
            job_opportunity = JobOpportunity.create!(headhunter: headhunter, name: 'Programador Ruby', description: 'Vaga para programador Ruby',
                                                       habilities: 'Saber programar', salary_range: 5000, 
                                                       opportunity_level: 'Pleno', end_date_opportunity: '02/02/2020',
                                                       region: 'São Paulo')

            login_as(job_seeker, scope: :job_seeker)
            visit root_path
            click_on 'Inscrições'
                
            expect(current_path).to eq(subscriptions_by_job_seeker_job_opportunities_path)
            expect(page).to have_content('Nenhuma inscrição')           
        end

        it 'and delete' do
            job_seeker = JobSeeker.create!(email: 'js@test.com', password: '123456')
            headhunter = Headhunter.create!(email: 'hh@test.com', password: '123456')        
            job_opportunity = JobOpportunity.create!(headhunter: headhunter, name: 'Programador Ruby', description: 'Vaga para programador Ruby',
                                                       habilities: 'Saber programar', salary_range: 5000, 
                                                       opportunity_level: 'Pleno', end_date_opportunity: '02/02/2020',
                                                       region: 'São Paulo')
            profile = Profile.create!(name: 'Pedro', nick_name: 'Pedrinho', day_of_birth: '1986-02-02', education_level: 'Graduado',
                                        description: 'na faculdade', experience: 'programei', document: '521.730.870-29',
                                        job_seeker: job_seeker)
                                        
            login_as(job_seeker, scope: :job_seeker)
            visit root_path
            click_on 'Vagas'
            click_on "#{job_opportunity.name} #{job_opportunity.opportunity_level} #{job_opportunity.end_date_opportunity} "\
                        "#{job_opportunity.region}"
            click_on 'Candidatar para Vaga'
            click_on 'Cancelar Inscrição'

            expect(page).to have_content 'Inscrição cancelada'
            
            expect(current_path).to eq(job_opportunity_path(job_opportunity))
            
        end

    end