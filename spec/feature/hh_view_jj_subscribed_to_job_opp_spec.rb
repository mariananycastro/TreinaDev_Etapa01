require 'rails_helper'

feature "headhunter views subscriptions of job seeker and job seeker's profile" do
    scenario 'successfully' do
        
        job_seeker = JobSeeker.create!(email: 'js@test.com', password: '123456')
        profile = Profile.create!(name: 'Pedro', nick_name: 'Pedrinho', day_of_birth: '1986-02-02', 
                                    education_level: 'Graduado',
                                    description: 'UEM', experience: 'Ja trabalhei com TI', document: '521.730.870-29',
                                    job_seeker: job_seeker)
        headhunter = Headhunter.create!(email: 'hh@test.com', password: '123456')        
        job_opportunity = JobOpportunity.create!(headhunter: headhunter, name: 'Programador Ruby', description: 'Vaga para programador Ruby',
                                                   habilities: 'Saber programar', salary_range: 5000, 
                                                   opportunity_level: 'Pleno', end_date_opportunity: '02/02/2020',
                                                   region: 'Sâo Paulo')
        subscription = Subscription.create!(job_seeker:job_seeker, job_opportunity:job_opportunity)        

        login_as(headhunter, scope: :headhunter)
        visit root_path
        click_on 'Vagas Cadastradas'
        click_on "#{job_opportunity.name} #{job_opportunity.opportunity_level}"\
                " #{job_opportunity.end_date_opportunity} #{job_opportunity.region}"
        click_on "#{profile.name} #{profile.document} #{profile.education_level}"
            
        expect(page).to have_content 'Pedro'
        expect(page).to have_content '521.730.870-29'
        expect(page).to have_content 'Pedrinho'
        expect(page).to have_content '1986-02-02'
        expect(page).to have_content 'Graduado'
        expect(page).to have_content 'UEM'
        expect(page).to have_content 'Ja trabalhei com TI'
        
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
            
        expect(page).to have_content 'Não há inscrições para esta vaga'
        
    end
end
