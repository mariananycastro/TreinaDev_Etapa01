require 'rails_helper'
    feature 'js search for job opportunity' do
        scenario 'successfully' do
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
        fill_in 'Buscar vaga:', with: 'Ruby'
        click_on 'Pesquisar'

        expect(page).to have_css('#search', text: 'Programador Ruby Pleno 2020-02-02 São Paulo')
        expect(page).not_to have_css('#search', text: 'Desenvolvedor Java Pleno 2020-02-02 São Paulo')
            
        end

        scenario 'by description' do
            headhunter = Headhunter.create!(email: 'hh@test.com', password: '123456') 
            job_seeker = JobSeeker.create!(email: 'js@test.com', password: '123456')        
            job_opportunity = JobOpportunity.create!(headhunter: headhunter, name: 'Programador', 
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
            fill_in 'Buscar vaga:', with: 'Ruby'
            click_on 'Pesquisar'
    
            expect(page).to have_css('#search', text: 'Programador Pleno 2020-02-02 São Paulo')
            expect(page).not_to have_css('#search', text: 'Desenvolvedor Java Pleno 2020-02-02 São Paulo')
        end

        scenario 'by salary' do
            headhunter = Headhunter.create!(email: 'hh@test.com', password: '123456') 
            job_seeker = JobSeeker.create!(email: 'js@test.com', password: '123456')        
            job_opportunity = JobOpportunity.create!(headhunter: headhunter, name: 'Programador', 
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
            fill_in 'Buscar vaga:', with: '5000'
            click_on 'Pesquisar'
    
            expect(page).to have_css('#search', text: 'Programador Pleno 2020-02-02 São Paulo')
            expect(page).to have_css('#search', text: 'Desenvolvedor Java Pleno 2020-02-02 São Paulo')
        end

        
        scenario 'by level' do
            headhunter = Headhunter.create!(email: 'hh@test.com', password: '123456') 
            job_seeker = JobSeeker.create!(email: 'js@test.com', password: '123456')        
            job_opportunity = JobOpportunity.create!(headhunter: headhunter, name: 'Programador', 
                                                     description: 'Vaga para programador Ruby',
                                                     habilities: 'Saber programar', salary_range: 5000, 
                                                     opportunity_level: 'Estagiário', end_date_opportunity: '02/02/2020',
                                                     region: 'São Paulo')
            job_opportunity2 = JobOpportunity.create!(headhunter: headhunter, name: 'Desenvolvedor Java', 
                                                     description: 'Vaga para programador',
                                                     habilities: 'Saber programar', salary_range: 5000, 
                                                     opportunity_level: 'Pleno', end_date_opportunity: '02/02/2020',
                                                     region: 'São Paulo')
    
            login_as(job_seeker, scope: :job_seeker)
            visit root_path
            click_on 'Vagas'
            fill_in 'Buscar vaga:', with: 'Pleno'
            
            click_on 'Pesquisar'
    
            expect(page).not_to have_css('#search', text: 'Programador Estagiário 2020-02-02 São Paulo')
            expect(page).to have_css('#search', text: 'Desenvolvedor Java Pleno 2020-02-02 São Paulo')
        end
    end