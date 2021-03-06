require 'rails_helper'

feature 'Job Seeker create profile' do
    scenario 'successfully' do
        job_seeker = JobSeeker.create!(email: 'test@test.com', password: '123456')
        
        login_as(job_seeker, scope: :job_seeker)

        visit root_path
        click_on 'Criar Perfil'
        attach_file 'Foto:', Rails.root.join('spec', 'support', 'avatar.JPG')
        fill_in 'Nome:', with: 'Joao da Silva'
        fill_in 'CPF:', with: '595.487.167-12'
        fill_in 'Apelido:', with: 'João'
        fill_in 'Data de nascimento:', with: '1986-12-01'
        fill_in 'Escolaridade:', with: 'Graduado'
        fill_in 'Descrição:', with: 'Ciencia da computacao'
        fill_in 'Experiência:', with: 'Trabalhei com computacao'
        click_on 'Enviar'

        expect(page).to have_content 'Joao da Silva'
        expect(page).to have_content '595.487.167-12'
        expect(page).to have_content 'João'
        expect(page).to have_content '1986-12-01'
        expect(page).to have_content 'Graduado'
        expect(page).to have_content 'Ciencia da computacao'
        expect(page).to have_content 'Trabalhei com computacao'

        expect(page).to have_content 'Perfil criado com sucesso!'

    end

    scenario 'must complete all fields' do
        job_seeker = JobSeeker.create!(email: 'test@test.com', password: '123456')

        login_as(job_seeker, scope: :job_seeker)

        visit root_path
        click_on 'Criar Perfil'
        click_on 'Enviar'

        expect(page).to have_content 'Você deve corrigir todos os erros para prosseguir'
        expect(page).to have_content "Name não pode ficar em branco"
        expect(page).to have_content "Document não pode ficar em branco"
        expect(page).to have_content "Nick name não pode ficar em branco"
        expect(page).to have_content "Day of birth não pode ficar em branco"
        expect(page).to have_content "Education level não pode ficar em branco"
        expect(page).to have_content "Description não pode ficar em branco"
        expect(page).to have_content "Experience não pode ficar em branco"

    end
    scenario 'CPF must be unique' do
        job_seeker = JobSeeker.create!(email: 'test@test.com', password: '123456')
        job_seeker2 = JobSeeker.create!(email: 'test2@test.com', password: '234567')
        Profile.create!(job_seeker: job_seeker, name: 'Joao da Silva', document: '595.487.167-12', nick_name: 'João',
                        day_of_birth: '12/01/1986', education_level: 'Graduado', 
                        description: 'Ciencia da computacao', experience: 'Trabalhei com computacao',
                        avatar: fixture_file_upload('avatar.JPG'))

        login_as(job_seeker2, scope: :job_seeker)
        
        visit root_path
        click_on 'Criar Perfil'
        fill_in 'Nome:', with: 'Maria Santos'
        fill_in 'CPF:', with: '595.487.167-12'
        fill_in 'Apelido:', with: 'Maria'
        fill_in 'Data de nascimento:', with: '1987-13-02'
        fill_in 'Escolaridade:', with: 'Pós-Graduado'
        fill_in 'Descrição:', with: 'Ciencia da computacao'
        fill_in 'Experiência:', with: 'Trabalhei muito com computacao'
        click_on 'Enviar'

        expect(page).to have_content 'Document já está em uso '


    end
end

