require 'rails_helper'

feature 'edit js profile' do
    xscenario 'successfully' do
        job_opportunity = JobOpportunity.create!()

        visit root_path
        click_on 'Editar'
        fill_in 'Título da Vaga:', with: 'Programador Ruby'
        fill_in 'Descrição Detalhada:', with: 'Trabalhar em empresa multinacional como programador'
        fill_in 'Habilidades Desejadas', with: 'Formação em Computação'
        fill_in 'Faixa Salarial', with: '5000'
        choose 'Pleno'
        fill_in 'Data Limite para inscrição', with: '2020-02-02'
        fill_in 'Região', with: 'São Paulo'
        click_on 'Enviar'

        
        expect(page).to have_content 'Programador Ruby'
        expect(page).to have_content 'Trabalhar em empresa multinacional como programador'
        expect(page).to have_content 'Formação em Computação'
        expect(page).to have_content '5000'
        expect(page).to have_content 'Pleno'
        expect(page).to have_content '2020-02-02'
        expect(page).to have_content 'São Paulo'

        expect(page).to have_content 'Vaga criada com sucesso!'
    end

    xscenario 'must complete all fields' do
        job_seeker = JobSeeker.create!(email: 'test@test.com', password: '123456')
        Profile.create!(job_seeker: job_seeker, name: 'Joao da Silva', document: '595.487.167-12', nick_name: 'João', day_of_birth: '12/01/1986', 
                        education_level: 'Graduado', description: 'Ciencia da computacao',
                        experience: 'Trabalhei com computacao')

        login_as job_seeker
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