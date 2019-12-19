require 'rails_helper'

feature 'headhunter views job opportunities' do
    xscenario 'successfully' do
        it '' do
        job_seeker = JobSeeker.create!(email: 'js@test.com', password: '123456')
        headhunter = Headhunter.create!(email: 'hh@test.com', password: '123456')        
        job_opportunity = JobOpportunity.create!(headhunter: headhunter, name: 'Programador Ruby', description: 'Vaga para programador Ruby',
                                                   habilities: 'Saber programar', salary_range: 5000, 
                                                   opportunity_level: 'Pleno', end_date_opportunity: '02/02/2020',
                                                   region: 'Sâo Paulo')
        profile = Profile.create!(name: 'Pedro', nick_name: 'Pedrinho', day_of_birth: '1986-02-02', education_level: 'Graduado',
                                    description: 'na faculdade', experience: 'programei', document: '521.730.870-29',
                                    job_seeker: job_seeker)

        login_as(headhunter, scope: :headhunter)
        
        visit root_path
        click_on 'Vagas Cadastradas'
        click_on "#{job_opportunity.name} #{job_opportunity.opportunity_level} #{job_opportunity.end_date_opportunity} "\
                    "#{job_opportunity.region}"

        expect(page).to have_content 'Programador Ruby'
        expect(page).to have_content 'Trabalhar em empresa multinacional como programador'
        expect(page).to have_content 'Formação em Computação'
        expect(page).to have_content '5000'
        expect(page).to have_content 'Pleno'
        expect(page).to have_content '2020-02-02'
        expect(page).to have_content 'São Paulo'

        expect(page).to have_content 'Vaga criada com sucesso!'
        end
    end
end