require 'rails_helper'

feature 'headhunter only his job opportunities' do
    scenario 'successfully' do
        
        headhunter = Headhunter.create!(email: 'hh@test.com', password: '123456')     
        headhunter2 = Headhunter.create!(email: 'hh2@test.com', password: '123456')        
        job_opportunity = JobOpportunity.create!(headhunter: headhunter, name: 'Programador Ruby', description: 'Vaga para programador Ruby',
                                                   habilities: 'Saber programar', salary_range: 5000, 
                                                   opportunity_level: 'Pleno', end_date_opportunity: '02/02/2021',
                                                   region: 'São Paulo')

        job_opportunity2 = JobOpportunity.create!(headhunter: headhunter2, name: 'Programador Ruby 2', 
                                                    description: 'Vaga para programador Ruby 2',
                                                    habilities: 'Saber programar 2x', salary_range: 10000, 
                                                    opportunity_level: 'Sênior', end_date_opportunity: '01/02/2021',
                                                    region: 'Rio')
 

        login_as(headhunter, scope: :headhunter)
        
        visit root_path
        click_on 'Vagas Cadastradas'

        expect(page).to have_content "#{job_opportunity.name} #{job_opportunity.opportunity_level}"\
                                    " #{job_opportunity.end_date_opportunity} #{job_opportunity.region}"
        expect(page).not_to have_content "#{job_opportunity2.name} #{job_opportunity2.opportunity_level}"\
                                    " #{job_opportunity2.end_date_opportunity} #{job_opportunity2.region}"

    end
end