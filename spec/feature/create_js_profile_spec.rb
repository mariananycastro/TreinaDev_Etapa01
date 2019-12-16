require 'rails_helper'

feature 'create js profile' do
    scenario 'successfully' do
        Profile.create!(name: 'Joao da Silva', nick_name: 'João', day_of_birth: '12/01/1986', 
                        education_level: 'Graduado', description: 'Ciencia da computacao',
                        experience: 'Trabalhei com computacao')
        visit root_path
        click_on 'Criar Perfil'
        fill_in 'Nome:', with: 'Joao da Silva'
        fill_in 'Apelido:', with: 'João'
        fill_in 'Data de nascimento:', with: '12/01/1986'
        fill_in 'Escolaridade:', with: 'Graduado'
        fill_in 'Descrição:', with: 'Ciencia da computacao'
        fill_in 'Experiência:', with: 'Trabalhei com computacao'
        click_on 'Enviar'

        expect(page).to have_content 'Joao da Silva'
        expect(page).to have_content 'João'
        expect(page).to have_content '12/01/1986'
        expect(page).to have_content 'Graduado'
        expect(page).to have_content 'Ciencia da computacao'
        expect(page).to have_content 'Trabalhei com computacao'
    end
end

