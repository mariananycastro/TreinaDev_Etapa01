require 'rails_helper'

feature 'edit js profile' do
    xscenario 'successfully' do
        Profile.create!(name: 'Joao da Silva', document: '595.487.167-12', nick_name: 'João', day_of_birth: '12/01/1986', 
                        education_level: 'Graduado', description: 'Ciencia da computacao',
                        experience: 'Trabalhei com computacao')

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

    xscenario 'must complete all fields' do

        visit edit_profile_path
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
        expect(page).to have_content 'Nome não pode ficar vazio'
        expect(page).to have_content 'CPF não pode ficar vazio'
        expect(page).to have_content 'Apelido não pode ficar vazio'
        expect(page).to have_content 'Data de nascimento não pode ficar vazio'
        expect(page).to have_content 'Escolaridade não pode ficar vazio'
        expect(page).to have_content 'Descrição não pode ficar vazio'
        expect(page).to have_content 'Experiencia não pode ficar vazio'

    end
    xscenario 'CPF must be unique' do
        Profile.create!(name: 'Joao da Silva', document: '595.487.167-12', nick_name: 'João', day_of_birth: '12/01/1986', 
                        education_level: 'Graduado', description: 'Ciencia da computacao',
                        experience: 'Trabalhei com computacao')
        Profile.create!(name: 'Maria Santos', document: '663.134.739-49', nick_name: 'Maria', day_of_birth: '12/01/1986', 
                        education_level: 'Pós-graduação', description: 'Ciencia da computacao',
                        experience: 'Trabalhei com computacao')
        
        visit root_path
        click_on 'Editar Perfil'
        fill_in 'Nome:', with: 'João da Silva'
        fill_in 'CPF:', with: '663.134.739-49'
        fill_in 'Apelido:', with: 'João'
        fill_in 'Data de nascimento:', with: '12/01/1986'
        fill_in 'Escolaridade:', with: 'Graduado'
        fill_in 'Descrição:', with: 'Ciencia da computacao'
        fill_in 'Experiência:', with: 'Trabalhei com computacao'
        click_on 'Enviar'

        expect(page).to have_content 'CPF já cadastrado'


    end
end