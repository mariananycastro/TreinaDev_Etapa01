require 'rails_helper'

feature 'Job seeker edit profile' do
    scenario 'successfully' do
        job_seeker = JobSeeker.create!(email: 'test@test.com', password: '123456')
        Profile.create!(job_seeker: job_seeker, name: 'Joao da Silva', document: '595.487.167-12', nick_name: 'João', day_of_birth: '12/01/1986', 
                        education_level: 'Graduado', description: 'Ciencia da computacao',
                        experience: 'Trabalhei com computacao')

        login_as(job_seeker, scope: :job_seeker)
        visit root_path
        click_on 'Editar Perfil'
        fill_in 'Nome:', with: 'Joao da Silva Santos'
        fill_in 'CPF:', with: '595.487.167-12'
        fill_in 'Apelido:', with: 'Joãzinho'
        fill_in 'Data de nascimento:', with: '12/01/1986'
        fill_in 'Escolaridade:', with: 'Pós-graduação'
        fill_in 'Descrição:', with: 'Ciencia da computacao'
        fill_in 'Experiência:', with: 'Trabalhei com computacao'
        click_on 'Enviar'

        expect(page).to have_content 'Joao da Silva Santos'
        expect(page).to have_content '595.487.167-12'
        expect(page).to have_content 'Joãzinho'
        expect(page).to have_content '12/01/1986'
        expect(page).to have_content 'Pós-graduação'
        expect(page).to have_content 'Ciencia da computacao'
        expect(page).to have_content 'Trabalhei com computacao'

        expect(page).to have_content 'Perfil criado com sucesso!'

    end

    scenario 'must complete all fields' do
        job_seeker = JobSeeker.create!(email: 'test@test.com', password: '123456')
        Profile.create!(job_seeker: job_seeker, name: 'Joao da Silva', document: '595.487.167-12', nick_name: 'João', day_of_birth: '12/01/1986', 
                        education_level: 'Graduado', description: 'Ciencia da computacao',
                        experience: 'Trabalhei com computacao')

        login_as(job_seeker, scope: :job_seeker)
        visit root_path
        click_on 'Editar Perfil'
        fill_in 'Nome:', with: ''
        fill_in 'CPF:', with: ''
        fill_in 'Apelido:', with: ''
        fill_in 'Data de nascimento:', with: ''
        fill_in 'Escolaridade:', with: ''
        fill_in 'Descrição:', with: ''
        fill_in 'Experiência:', with: ''
        click_on 'Enviar'
        click_on 'Enviar'

        expect(page).to have_content 'Você deve corrigir todos os erros para prosseguir'
        expect(page).to have_content "Name can't be blank"
        expect(page).to have_content "Document can't be blank"
        expect(page).to have_content "Nick name can't be blank"
        expect(page).to have_content "Day of birth can't be blank"
        expect(page).to have_content "Education level can't be blank"
        expect(page).to have_content "Description can't be blank"
        expect(page).to have_content "Experience can't be blank"

    end

end