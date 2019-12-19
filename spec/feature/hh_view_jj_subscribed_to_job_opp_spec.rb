require 'rails_helper'

feature 'headhunter views subscriptions of job seeker' do
    scenario 'successfully' do
        
        job_seeker = JobSeeker.create!(email: 'js@test.com', password: '123456')
        profile = Profile.create!(name: 'Pedro', nick_name: 'Pedrinho', day_of_birth: '1986-02-02', education_level: 'Graduado',
                                    description: 'na faculdade', experience: 'programei', document: '521.730.870-29',
                                    job_seeker: job_seeker)
        headhunter = Headhunter.create!(email: 'hh@test.com', password: '123456')        
        job_opportunity = JobOpportunity.create!(headhunter: headhunter, name: 'Programador Ruby', description: 'Vaga para programador Ruby',
                                                   habilities: 'Saber programar', salary_range: 5000, 
                                                   opportunity_level: 'Pleno', end_date_opportunity: '02/02/2020',
                                                   region: 'Sâo Paulo')

        login_as(job_seeker, scope: :job_seeker)
        visit root_path
        click_on 'Vagas'
        click_on "#{job_opportunity.name} #{job_opportunity.opportunity_level}"\
                    " #{job_opportunity.end_date_opportunity} #{job_opportunity.region}"
        click_on 'Candidatar para Vaga'
        logout(:job_seeker)
        

        login_as(headhunter, scope: :headhunter)
        visit root_path
        click_on 'Vagas Cadastradas'
        click_on "#{job_opportunity.name} #{job_opportunity.opportunity_level}"\
                " #{job_opportunity.end_date_opportunity} #{job_opportunity.region}"
            
        expect(page).to have_content job_seeker.email
        
    end
    scenario 'dont have subscription' do
        
        headhunter = Headhunter.create!(email: 'hh@test.com', password: '123456')        
        job_opportunity = JobOpportunity.create!(headhunter: headhunter, name: 'Programador Ruby', description: 'Vaga para programador Ruby',
                                                   habilities: 'Saber programar', salary_range: 5000, 
                                                   opportunity_level: 'Pleno', end_date_opportunity: '02/02/2020',
                                                   region: 'Sâo Paulo')

        login_as(headhunter, scope: :headhunter)
        visit root_path
        click_on 'Vagas Cadastradas'
        click_on "#{job_opportunity.name} #{job_opportunity.opportunity_level}"\
                " #{job_opportunity.end_date_opportunity} #{job_opportunity.region}"
            
        expect(page).to have_content 'Não há inscrições'
        
    end
end
