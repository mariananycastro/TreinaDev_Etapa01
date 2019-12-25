require 'rails_helper'

feature 'job opportunity is no available on search for job seeker' do
    scenario 'when date less than today'do
    
    headhunter = Headhunter.create!(email: 'hh@test.com', password: '123456') 
    job_seeker = JobSeeker.create!(email: 'js@test.com', password: '123456')
    profile = Profile.create!(name: 'Pedro', nick_name: 'Pedrinho', day_of_birth: '1986-02-02', 
                             education_level: 'Graduado',
                             description: 'UEM', experience: 'Ja trabalhei com TI', document: '521.730.870-29',
                             job_seeker: job_seeker, avatar: fixture_file_upload('avatar.JPG'))
    

    job_opportunity = JobOpportunity.create!(headhunter: headhunter, name: 'Programador Ruby', 
                                             description: 'Vaga para programador Ruby',
                                             habilities: 'Saber programar', salary_range: 5000, 
                                             opportunity_level: 'Pleno', end_date_opportunity: 1.day.from_now,
                                             region: 'São Paulo')

    job_opportunity2 = JobOpportunity.create!(headhunter: headhunter, name: 'Desenvolvedor Ruby', 
                                             description: 'Vaga para programador',
                                             habilities: 'Saber programar', salary_range: 3000, 
                                             opportunity_level: 'Pleno', end_date_opportunity: 3.days.from_now,
                                             region: 'São Paulo')

    job_opportunity3 = JobOpportunity.create!(headhunter: headhunter, name: 'Desenvolvedor Ruby 3', 
                                             description: 'Vaga para programador',
                                             habilities: 'Saber programar', salary_range: 3000, 
                                             opportunity_level: 'Pleno', end_date_opportunity: 2.days.from_now,
                                             region: 'São Paulo')

    travel(2.days)                                             

    login_as(job_seeker, scope: :job_seeker)
    visit root_path
    click_on 'Vagas'
    fill_in 'Buscar vaga:', with: 'Ruby'
    click_on 'Pesquisar'
   

    expect(page).not_to have_css('#search', text: "Programador Ruby Pleno #{1.day.ago.strftime('%Y-%m-%d')} São Paulo")
    expect(page).to have_css('#search', text: "Desenvolvedor Ruby Pleno #{1.days.from_now.strftime('%Y-%m-%d')} São Paulo")
    expect(page).to have_css('#search', text: "Desenvolvedor Ruby 3 Pleno #{Date.current.strftime('%Y-%m-%d')} São Paulo")

    end
end
