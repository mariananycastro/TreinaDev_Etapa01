require 'rails_helper'

feature "headhunter views subscriptions of job seeker and job seeker's profile" do
    scenario 'successfully' do
        
        job_seeker = JobSeeker.create!(email: 'js@test.com', password: '123456')
        profile = Profile.create!(name: 'Pedro', nick_name: 'Pedrinho', day_of_birth: '1986-02-02', 
                                    education_level: 'Graduado',
                                    description: 'UEM', experience: 'Ja trabalhei com TI', document: '521.730.870-29',
                                    job_seeker: job_seeker, avatar: fixture_file_upload('avatar.JPG'))
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

    scenario 'more than one subscription' do
        
        job_seeker = JobSeeker.create!(email: 'js@test.com', password: '123456')
        profile = Profile.create!(name: 'Pedro', nick_name: 'Pedrinho', day_of_birth: '1986-02-02', 
                                    education_level: 'Graduado',
                                    description: 'UEM', experience: 'Ja trabalhei com TI', document: '521.730.870-29',
                                    job_seeker: job_seeker, avatar: fixture_file_upload('avatar.JPG'))
        job_seeker2 = JobSeeker.create!(email: 'js2@test.com', password: '123456')
        profile2 = Profile.create!(name: 'Ana', nick_name: 'Aninha', day_of_birth: '1986-03-02', 
                                    education_level: 'Graduada',
                                    description: 'USP', experience: 'Ja trabalhei muito com TI', document: '911.386.250-27',
                                    job_seeker: job_seeker2, avatar: fixture_file_upload('avatar.JPG'))
        headhunter = Headhunter.create!(email: 'hh@test.com', password: '123456')        
        job_opportunity = JobOpportunity.create!(headhunter: headhunter, name: 'Programador Ruby', 
                                                   description: 'Vaga para programador Ruby',
                                                   habilities: 'Saber programar', salary_range: 5000, 
                                                   opportunity_level: 'Pleno', end_date_opportunity: '02/02/2020',
                                                   region: 'Sâo Paulo')
        subscription = Subscription.create!(job_seeker:job_seeker, job_opportunity:job_opportunity)        
        subscription2 = Subscription.create!(job_seeker:job_seeker2, job_opportunity:job_opportunity)        

        login_as(headhunter, scope: :headhunter)
        visit root_path
        click_on 'Vagas Cadastradas'
        click_on "#{job_opportunity.name} #{job_opportunity.opportunity_level}"\
                " #{job_opportunity.end_date_opportunity} #{job_opportunity.region}"
            
        expect(page).to have_content "#{profile.name} #{profile.document} #{profile.education_level}"
        expect(page).to have_content "#{profile2.name} #{profile2.document} #{profile2.education_level}"
        
    end

end
