require 'rails_helper'
feature 'job seeker rejects headhunter invitation' do
    scenario 'successfully' do
        headhunter = Headhunter.create!(email: 'hh@test.com', password: '123456') 
        job_seeker = JobSeeker.create!(email: 'js@test.com', password: '123456')   
        profile = Profile.create!(job_seeker: job_seeker, name: 'Joao da Silva', document: '595.487.167-12', nick_name: 'João', day_of_birth: '12/01/1986', 
                                    education_level: 'Graduado', description: 'Ciencia da computacao',
                                    experience: 'Trabalhei com computacao')
        job_opportunity = JobOpportunity.create!(headhunter: headhunter, name: 'Programador Ruby', 
                                                 description: 'Vaga para programador Ruby',
                                                 habilities: 'Saber programar', salary_range: 5000, 
                                                 opportunity_level: 'Pleno', end_date_opportunity: '02/02/2021',
                                                 region: 'São Paulo')
        subscription = Subscription.create!(job_seeker:job_seeker, job_opportunity:job_opportunity) 
        invitation = Invitation.create!(title:'Passou', message:'Vamos agendar uma entrevista.', initial_date:  '02/03/2021', salary: 5000, position: 'Especialista',
                                        expectations: 'Trabalhar bem', bonus: 'PLR', benefits:'VR, VT')
        subscription.update(hh_answer:invitation)
        subscription.reload

        login_as(job_seeker, scope: :job_seeker)

        visit root_path
        click_on 'Programador Ruby Pleno 2021-02-02 São Paulo'
        click_on 'Recusar Convite'
        
        expect(page).to have_content "Convite recusado com sucesso"
        expect(page).not_to have_content 'Aceitar Convite'
        expect(page).not_to have_content 'Recusar Convite'
    end

    scenario 'successfully when search for job opportunity page' do
        headhunter = Headhunter.create!(email: 'hh@test.com', password: '123456') 
        job_seeker = JobSeeker.create!(email: 'js@test.com', password: '123456')   
        profile = Profile.create!(job_seeker: job_seeker, name: 'Joao da Silva', document: '595.487.167-12', nick_name: 'João', day_of_birth: '12/01/1986', 
                                    education_level: 'Graduado', description: 'Ciencia da computacao',
                                    experience: 'Trabalhei com computacao')
        job_opportunity = JobOpportunity.create!(headhunter: headhunter, name: 'Programador Ruby', 
                                                 description: 'Vaga para programador Ruby',
                                                 habilities: 'Saber programar', salary_range: 5000, 
                                                 opportunity_level: 'Pleno', end_date_opportunity: '02/02/2021',
                                                 region: 'São Paulo')
        subscription = Subscription.create!(job_seeker:job_seeker, job_opportunity:job_opportunity) 
        invitation = Invitation.create!(title:'Passou', message:'Vamos agendar uma entrevista.', initial_date:  '02/03/2021', salary: 5000, position: 'Especialista',
            expectations: 'Trabalhar bem', bonus: 'PLR', benefits:'VR, VT')
        subscription.update(hh_answer:invitation)
        subscription.reload

        login_as(job_seeker, scope: :job_seeker)
        visit root_path
        click_on 'Vagas'
        click_on 'Programador Ruby Pleno 2021-02-02 São Paulo'
        click_on 'Visualizar Convite'
        click_on 'Recusar Convite'
        
        expect(page).to have_content 'Convite recusado com sucesso'
        expect(page).not_to have_content 'Aceitar Convite'
        expect(page).not_to have_content 'Recusar Convite'
    end

    scenario 'Job seeker Home page after refusing' do
        headhunter = Headhunter.create!(email: 'hh@test.com', password: '123456') 
        job_seeker = JobSeeker.create!(email: 'js@test.com', password: '123456')   
        profile = Profile.create!(job_seeker: job_seeker, name: 'Joao da Silva', document: '595.487.167-12', nick_name: 'João', day_of_birth: '12/01/1986', 
                                    education_level: 'Graduado', description: 'Ciencia da computacao',
                                    experience: 'Trabalhei com computacao')
        job_opportunity = JobOpportunity.create!(headhunter: headhunter, name: 'Programador Ruby', 
                                                 description: 'Vaga para programador Ruby',
                                                 habilities: 'Saber programar', salary_range: 5000, 
                                                 opportunity_level: 'Pleno', end_date_opportunity: '02/02/2021',
                                                 region: 'São Paulo')
        subscription = Subscription.create!(job_seeker:job_seeker, job_opportunity:job_opportunity) 
        invitation = Invitation.create!(title:'Passou', message:'Vamos agendar uma entrevista.', initial_date:  '02/03/2021', salary: 5000, position: 'Especialista',
            expectations: 'Trabalhar bem', bonus: 'PLR', benefits:'VR, VT')
        subscription.update(hh_answer:invitation, status:false)
        subscription.reload

        login_as(job_seeker, scope: :job_seeker)
        visit root_path
        
        expect(page).to have_content 'Vagas recusadas:'
        expect(page).to have_content "#{job_opportunity.name} #{job_opportunity.opportunity_level} #{job_opportunity.end_date_opportunity} #{job_opportunity.region}"

    end

    
    scenario 'headhunter receives job seeker answer on home page'do

        job_seeker = JobSeeker.create!(email: 'js@test.com', password: '123456')
        profile = Profile.create!(name: 'Pedro', nick_name: 'Pedrinho', day_of_birth: '1986-02-02', 
                                    education_level: 'Graduado',
                                    description: 'UEM', experience: 'Ja trabalhei com TI', document: '521.730.870-29',
                                    job_seeker: job_seeker, avatar: fixture_file_upload('avatar.JPG'))
        headhunter = Headhunter.create!(email: 'hh@test.com', password: '123456')        
        job_opportunity = JobOpportunity.create!(headhunter: headhunter, name: 'Programador Ruby', description: 'Vaga para programador Ruby',
                                                   habilities: 'Saber programar', salary_range: 5000, 
                                                   opportunity_level: 'Pleno', end_date_opportunity: '02/02/2021',
                                                   region: 'Sâo Paulo')
        subscription = Subscription.create!(job_seeker:job_seeker, job_opportunity:job_opportunity)
        invitation = Invitation.create!(title:'Passou', message:'Vamos agendar uma entrevista.', initial_date:  '02/03/2021', salary: 5000, position: 'Especialista',
            expectations: 'Trabalhar bem', bonus: 'PLR', benefits:'VR, VT')
        subscription.update(hh_answer:invitation, status:false)
        subscription.reload

        login_as(headhunter, scope: :headhunter)
        visit root_path        
        
        expect(page).to have_content "#{profile.name} #{profile.document} #{profile.education_level} recusou convite para vaga #{job_opportunity.name}"\
        " #{job_opportunity.opportunity_level} #{job_opportunity.end_date_opportunity} #{job_opportunity.region}"
 
    end

    scenario 'headhunter receives job seeker answer on job opportunity view'do

        job_seeker = JobSeeker.create!(email: 'js@test.com', password: '123456')
        profile = Profile.create!(name: 'Pedro', nick_name: 'Pedrinho', day_of_birth: '1986-02-02', 
                                    education_level: 'Graduado',
                                    description: 'UEM', experience: 'Ja trabalhei com TI', document: '521.730.870-29',
                                    job_seeker: job_seeker, avatar: fixture_file_upload('avatar.JPG'))
        headhunter = Headhunter.create!(email: 'hh@test.com', password: '123456')        
        job_opportunity = JobOpportunity.create!(headhunter: headhunter, name: 'Programador Ruby', description: 'Vaga para programador Ruby',
                                                   habilities: 'Saber programar', salary_range: 5000, 
                                                   opportunity_level: 'Pleno', end_date_opportunity: '02/02/2021',
                                                   region: 'Sâo Paulo')
        subscription = Subscription.create!(job_seeker:job_seeker, job_opportunity:job_opportunity)
        invitation = Invitation.create!(title:'Passou', message:'Vamos agendar uma entrevista.', initial_date:  '02/03/2021', salary: 5000, position: 'Especialista',
            expectations: 'Trabalhar bem', bonus: 'PLR', benefits:'VR, VT')
        subscription.update(hh_answer:invitation, status:false)
        subscription.reload

        login_as(headhunter, scope: :headhunter)
        visit root_path
        click_on 'Vagas Cadastradas'
        click_on "#{job_opportunity.name} #{job_opportunity.opportunity_level}"\
                " #{job_opportunity.end_date_opportunity} #{job_opportunity.region}"

        
        expect(page).to have_content "#{profile.name} #{profile.document} #{profile.education_level} recusou convite para a vaga"
        expect(page).not_to have_content 'Enviar Proposta'
        expect(page).not_to have_content 'Rejeitar Inscrição'
    end
    
end