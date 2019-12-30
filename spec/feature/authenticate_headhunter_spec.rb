require 'rails_helper'

feature 'log in headhunter' do
    scenario 'successfully' do
        headhunter = Headhunter.create!(email: 'teste@test.com', password: '123456')
        
        visit root_path
        click_link('entrar_headhunter')
        fill_in 'Email', with: headhunter.email
        fill_in 'Senha', with: headhunter.password
        click_on 'Log in'

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Logado com sucesso.')
    expect(page).to have_link('Log out')
    expect(page).not_to have_link('Entrar')
    end
    
    scenario 'and log out' do

        headhunter = Headhunter.create!(email: 'teste@test.com', password: '123456')

        visit root_path
        click_link('entrar_headhunter')
        fill_in 'Email', with: headhunter.email
        fill_in 'Senha', with: headhunter.password
        click_on 'Log in'
        click_on 'Log out'

        expect(current_path).to eq(root_path)
        expect(page).to have_content('Saiu com sucesso')
        expect(page).to have_link('Entrar')
        expect(page).not_to have_link('Log out')
    end

end