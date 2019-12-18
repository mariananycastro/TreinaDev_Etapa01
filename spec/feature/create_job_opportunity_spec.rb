require 'rails_helper'

feature 'headhunter create job opportunity' do
    scenario 'successfully' do
        headhunter = Headhunter.create!(email: 'test@test.com', password: '123456')

        login_as(headhunter, scope: :headhunter)
        
        visit root_path
        click_on 'Cadastrar Nova Vaga'
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

    scenario 'must complete all fields' do
        headhunter = Headhunter.create!(email: 'test@test.com', password: '123456')

        login_as(headhunter, scope: :headhunter)
        
        visit root_path
        click_on 'Cadastrar Nova Vaga'
        fill_in 'Título da Vaga:', with: ''
        fill_in 'Descrição Detalhada:', with: ''
        fill_in 'Habilidades Desejadas:', with: ''
        fill_in 'Faixa Salarial:', with: ''
        have_select '', from: 'Nível da Vaga'
        fill_in 'Data Limite para inscrição:', with: ''
        fill_in 'Região:', with: ''
        click_on 'Enviar'

        expect(page).to have_content 'Você deve corrigir todos os erros para prosseguir'
        expect(page).to have_content "Name can't be blank"
        expect(page).to have_content "Description can't be blank"
        expect(page).to have_content "Habilities can't be blank"
        expect(page).to have_content "Salary range can't be blank"
        expect(page).to have_content "Opportunity level can't be blank"
        expect(page).to have_content "End date opportunity can't be blank"
        expect(page).to have_content "Region can't be blank"

    end

end