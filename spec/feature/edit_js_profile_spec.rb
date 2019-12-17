require 'rails_helper'

feature 'edit js profile' do
    scenario 'successfully' do

        visit root_path
        click_on 'Criar Perfil'
        fill_in 'Nome:', with: 'Joao da Silva'
        fill_in 'CPF:', with: '595.487.167-12'
        fill_in 'Apelido:', with: 'João'
        fill_in 'Data de nascimento:', with: '12/01/1986'
        fill_in 'Escolaridade:', with: 'Graduado'
        fill_in 'Descrição:', with: 'Ciencia da computacao'
        fill_in 'Experiência:', with: 'Trabalhei com computacao'
        click_on 'Enviar'

        expect(page).to have_content 'Joao da Silva'
        expect(page).to have_content '595.487.167-12'
        expect(page).to have_content 'João'
        expect(page).to have_content '12/01/1986'
        expect(page).to have_content 'Graduado'
        expect(page).to have_content 'Ciencia da computacao'
        expect(page).to have_content 'Trabalhei com computacao'

        expect(page).to have_content 'Perfil criado com sucesso!'

    end

    scenario 'must complete all fields' do

        visit root_path
        click_on 'Criar Perfil'
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
    scenario 'CPF must be unique' do
        Profile.create!(name: 'Joao da Silva', document: '595.487.167-12', nick_name: 'João', day_of_birth: '12/01/1986', 
                        education_level: 'Graduado', description: 'Ciencia da computacao',
                        experience: 'Trabalhei com computacao')
        
        visit root_path
        click_on 'Criar Perfil'
        fill_in 'Nome:', with: 'Maria da Silva'
        fill_in 'CPF:', with: '595.487.167-12'
        fill_in 'Apelido:', with: 'Maria'
        fill_in 'Data de nascimento:', with: '10/02/1987'
        fill_in 'Escolaridade:', with: 'Graduado'
        fill_in 'Descrição:', with: 'Ciencia da computacao'
        fill_in 'Experiência:', with: 'Trabalhei com computacao'
        click_on 'Enviar'

        expect(page).to have_content 'CPF já cadastrado'


    end
end