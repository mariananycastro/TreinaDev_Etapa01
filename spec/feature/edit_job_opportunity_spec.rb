require 'rails_helper'

feature 'headhunter edit job opportunity' do
    scenario 'successfully' do
        headhunter = Headhunter.create!(email: 'test@test.com', password: '123456')        
        job_opportunity = JobOpportunity.create!(headhunter: headhunter, name: 'Programador Ruby', description: 'Vaga para programador Ruby',
                                                 habilities: 'Saber programar', salary_range: 5000, 
                                                 opportunity_level: 'Pleno', end_date_opportunity: '02/02/2020',
                                                 region: 'Sâo Paulo')

        login_as(headhunter, scope: :headhunter)
        visit root_path
        click_on 'Vagas Cadastradas'
        click_on "#{job_opportunity.name} #{job_opportunity.opportunity_level} #{job_opportunity.end_date_opportunity} #{job_opportunity.region}"
        click_on 'Editar Vaga'
        fill_in 'Título da Vaga:', with: 'Programador Ruby Avançado'
        fill_in 'Descrição Detalhada:', with: 'Trabalhar em empresa multinacional como programador'
        fill_in 'Habilidades Desejadas', with: 'Formação em Computação'
        fill_in 'Faixa Salarial', with: '6000'
        choose 'Especialista'
        fill_in 'Data Limite para inscrição', with: '2020-03-02'
        fill_in 'Região', with: 'Paraná'
        click_on 'Enviar'
        
        expect(page).to have_content 'Programador Ruby Avançado'
        expect(page).to have_content 'Trabalhar em empresa multinacional como programador'
        expect(page).to have_content 'Formação em Computação'
        expect(page).to have_content '6000'
        expect(page).to have_content 'Especialista'
        expect(page).to have_content '2020-03-02'
        expect(page).to have_content 'Paraná'

        expect(page).to have_content 'Vaga atualizada com sucesso!'
    end

    scenario 'must complete all fields' do
        headhunter = Headhunter.create!(email: 'test@test.com', password: '123456') 
        job_opportunity = JobOpportunity.create!(headhunter: headhunter, name: 'Programador Ruby', description: 'Vaga para programador Ruby',
                                                 habilities: 'Saber programar', salary_range: 5000, 
                                                 opportunity_level: 'Pleno', end_date_opportunity: '02/02/2020',
                                                 region: 'Sâo Paulo')

        login_as(headhunter, scope: :headhunter)
        visit root_path
        click_on 'Vagas Cadastradas'
        click_on "#{job_opportunity.name} #{job_opportunity.opportunity_level} #{job_opportunity.end_date_opportunity} #{job_opportunity.region}"
        click_on 'Editar Vaga'
        fill_in 'Título da Vaga:', with: ''
        fill_in 'Descrição Detalhada:', with: ''
        fill_in 'Habilidades Desejadas', with: ''
        fill_in 'Faixa Salarial', with: ''
        fill_in 'Data Limite para inscrição', with: ''
        fill_in 'Região', with: ''
        click_on 'Enviar'

        expect(page).to have_content 'Você deve corrigir todos os erros para prosseguir'
        expect(page).to have_content "Name can't be blank"
        expect(page).to have_content "Description can't be blank"
        expect(page).to have_content "Habilities can't be blank"
        expect(page).to have_content "Salary range can't be blank"
        expect(page).to have_content "End date opportunity can't be blank"
        expect(page).to have_content "Region can't be blank"

    end

end