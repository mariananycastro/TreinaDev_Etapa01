require 'rails_helper'
feature 'headhunter can invite jos seeker without his subscriptions to job opportunity' do
    scenario 'successfully' do
        headhunter = Headhunter.create!(email: 'hh@test.com', password: '123456') 
        job_seeker = JobSeeker.create!(email: 'js@test.com', password: '123456')
        profile = Profile.create!(name: 'Pedro', nick_name: 'Pedrinho', day_of_birth: '1986-02-02', 
                                    education_level: 'Graduado',
                                    description: 'UEM', experience: 'Ja trabalhei com TI', document: '521.730.870-29',
                                    job_seeker: job_seeker, avatar: fixture_file_upload('avatar.JPG'))
        job_opportunity = JobOpportunity.create!(headhunter: headhunter, name: 'Programador Ruby', 
                            description: 'Vaga para programador Ruby',
                            habilities: 'Saber programar', salary_range: 5000, 
                            opportunity_level: 'Pleno', end_date_opportunity: '02/02/2020',
                            region: 'São Paulo')
                                    


        login_as(headhunter, scope: :headhunter)
        visit root_path
        click_on 'Pesquisar Candidatos'
        fill_in 'Buscar Candidatos:', with: 'Graduado'
        click_on 'Pesquisar'
        click_on "#{profile.name} #{profile.document} #{profile.education_level}"
        click_on 'Enviar Proposta'
        fill_in 'Título:', with: 'Candidato aceito'
        fill_in 'Mensagem:', with: 'Candidato aceito para entrevista'
        click_on 'Enviar Proposta'
        
        expect(page).to have_content (profile.nick_name)
        expect(page).to have_content (job_opportunity.description_job_opportunity)
        expect(page).to have_content ('Candidato aceito')
        expect(page).to have_content ('Candidato aceito para entrevista')

        end

        xscenario 'with and without subscription' do
            headhunter = Headhunter.create!(email: 'hh@test.com', password: '123456') 
            job_opportunity = JobOpportunity.create!(headhunter: headhunter, name: 'Programador Ruby', 
                                                        description: 'Vaga para programador Ruby',
                                                        habilities: 'Saber programar', salary_range: 5000, 
                                                        opportunity_level: 'Pleno', end_date_opportunity: '02/02/2020',
                                                        region: 'São Paulo')
            job_seeker = JobSeeker.create!(email: 'js@test.com', password: '123456')
            profile = Profile.create!(name: 'Pedro', nick_name: 'Pedrinho', day_of_birth: '1986-02-02', 
                                        education_level: 'Graduado',
                                        description: 'UEM', experience: 'Ja trabalhei com TI', document: '521.730.870-29',
                                        job_seeker: job_seeker, avatar: fixture_file_upload('avatar.JPG'))
            job_seeker2 = JobSeeker.create!(email: 'js2@test.com', password: '123456')
            profile2 = Profile.create!(name: 'Paulo', nick_name: 'Paulinho', day_of_birth: '1986-03-02', 
                                        education_level: 'Expecialista',
                                        description: 'UEM', experience: 'Ja trabalhei com TI', document: '054.804.490-28',
                                        job_seeker: job_seeker2, avatar: fixture_file_upload('avatar.JPG'))
            subscription = Subscription.create!(job_seeker:job_seeker2, job_opportunity:job_opportunity)
    
            login_as(headhunter, scope: :headhunter)
            visit root_path
            click_on 'Pesquisar Candidatos'
            fill_in 'Buscar Candidatos:', with: 'Graduado'
            click_on 'Pesquisar'
            click_on "#{profile.name} #{profile.document} #{profile.education_level}"
            click_on 'Enviar Proposta'
            
            
            expect(page).to have_content ('Gostei desse candidato')
            expect(page).to have_css('#without subscription', text: 'Programador Ruby Pleno 2020-02-02 São Paulo')
            expect(page).to have_link 'Editar Comentário'
            expect(page).not_to have_link 'Salvar Comentário'
    
            expect(page).to have_content 'Pedro 521.730.870-29 Graduado'
            end
end