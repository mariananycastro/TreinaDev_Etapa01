require 'rails_helper'
feature 'headhunter can invite jos seeker without his subscriptions to job opportunity' do
    scenario 'successfully' do
        headhunter = Headhunter.create!(email: 'hh@test.com', password: '123456') 
        job_seeker = JobSeeker.create!(email: 'js@test.com', password: '123456')
        profile = Profile.create!(name: 'Pedro', nick_name: 'Pedrinho', day_of_birth: '1986-02-02', 
                                    education_level: 'Graduado',
                                    description: 'UEM', experience: 'Ja trabalhei com TI', document: '521.730.870-29',
                                    job_seeker: job_seeker, avatar: fixture_file_upload('avatar.JPG'))

        login_as(headhunter, scope: :headhunter)
        visit root_path
        click_on 'Pesquisar Candidatos'
        fill_in 'Buscar Candidatos:', with: 'Graduado'
        click_on 'Pesquisar'
        click_on "#{profile.name} #{profile.document} #{profile.education_level}"
        click_on 'Enviar Proposta'
        

        
        expect(page).to have_content ('Gostei desse candidato')
        expect(page).to have_link 'Editar Comentário'
        expect(page).not_to have_link 'Salvar Comentário'

        expect(page).to have_content 'Pedro 521.730.870-29 Graduado'
        end
end