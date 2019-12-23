require 'rails_helper'
    feature 'js search for job opportunity' do
        xscenario 'successfully' do
        headhunter = Headhunter.create!(email: 'hh@test.com', password: '123456') 
        job_seeker = JobSeeker.create!(email: 'js@test.com', password: '123456')        
        job_opportunity = JobOpportunity.create!(headhunter: headhunter, name: 'Programador Ruby', 
                                                 description: 'Vaga para programador Ruby',
                                                 habilities: 'Saber programar', salary_range: 5000, 
                                                 opportunity_level: 'Pleno', end_date_opportunity: '02/02/2020',
                                                 region: 'São Paulo')
        job_opportunity2 = JobOpportunity.create!(headhunter: headhunter, name: 'Desenvolvedor Java', 
                                                 description: 'Vaga para programador',
                                                 habilities: 'Saber programar', salary_range: 5000, 
                                                 opportunity_level: 'Pleno', end_date_opportunity: '02/02/2020',
                                                 region: 'São Paulo')

        login_as(job_seeker, scope: :job_seeker)
        visit root_path
        click_on 'Vagas'
        click_on 'Pesquisar Vaga'
        fill_in 'Pesquisar por Nome de Vaga:', with: 'Ruby'
        click_on 'Buscar'

        expect(page).to have_content 'Programador Ruby'
        expect(page).not_to have_content 'Desevolvedor Java'
            
        end
    end