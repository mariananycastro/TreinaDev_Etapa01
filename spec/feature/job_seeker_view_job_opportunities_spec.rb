require 'rails_helper'

feature 'job seeker can view job opportunities' do
    scenario 'successfully' do
        headhunter = Headhunter.create!(email: 'hh@test.com', password: '123456') 
        job_seeker = JobSeeker.create!(email: 'js@test.com', password: '123456')        
        job_opportunity = JobOpportunity.create!(headhunter: headhunter, name: 'Programador Ruby', 
                                                 description: 'Vaga para programador Ruby',
                                                 habilities: 'Saber programar', salary_range: 5000, 
                                                 opportunity_level: 'Pleno', end_date_opportunity: '02/02/2021',
                                                 region: 'São Paulo')

        login_as(job_seeker, scope: :job_seeker)
        visit root_path
        click_on 'Vagas'
        click_on "#{job_opportunity.name} #{job_opportunity.opportunity_level}"\
                " #{job_opportunity.end_date_opportunity} #{job_opportunity.region}"
               
        expect(page).to have_content 'Programador Ruby'
        expect(page).to have_content 'Vaga para programador Ruby'
        expect(page).to have_content 'Saber programar'
        expect(page).to have_content '5000'
        expect(page).to have_content 'Pleno'
        expect(page).to have_content '2021-02-02'
        expect(page).to have_content 'São Paulo'

    end
end