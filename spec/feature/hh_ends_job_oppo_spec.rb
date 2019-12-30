require 'rails_helper'
feature 'headhunter ends job opportunity' do
    scenario 'successfully' do
        headhunter = Headhunter.create!(email: 'hh@test.com', password: '123456')        
        job_opportunity = JobOpportunity.create!(headhunter: headhunter, name: 'Programador Ruby', description: 'Vaga para programador Ruby',
                                                   habilities: 'Saber programar', salary_range: 5000, 
                                                   opportunity_level: 'Pleno', end_date_opportunity: '02/02/2020',
                                                   region: 'Sâo Paulo')   


        login_as(headhunter, scope: :headhunter)
        visit root_path
        click_on 'Vagas Cadastradas'
        click_on "#{job_opportunity.name} #{job_opportunity.opportunity_level}"\
                " #{job_opportunity.end_date_opportunity} #{job_opportunity.region}"
        click_on 'Encerrar Vaga'
        job_opportunity.reload

        expect(page).to have_content 'Vaga encerrada com sucesso'
        expect(job_opportunity.status).to eq false
    end

    scenario 'with subscription' do
        job_seeker = JobSeeker.create!(email: 'js@test.com', password: '123456')
        profile = Profile.create!(name: 'Pedro', nick_name: 'Pedrinho', day_of_birth: '1986-02-02', 
                                    education_level: 'Graduado',
                                    description: 'UEM', experience: 'Ja trabalhei com TI', document: '521.730.870-29',
                                    job_seeker: job_seeker, avatar: fixture_file_upload('avatar.JPG'))
        headhunter = Headhunter.create!(email: 'hh@test.com', password: '123456')        
        job_opportunity = JobOpportunity.create!(headhunter: headhunter, name: 'Programador Ruby', description: 'Vaga para programador Ruby',
                                                   habilities: 'Saber programar', salary_range: 5000, 
                                                   opportunity_level: 'Pleno', end_date_opportunity: '02/02/2020',
                                                   region: 'Sâo Paulo')   
        subscription = Subscription.create!(job_seeker:job_seeker, job_opportunity:job_opportunity) 

        login_as(headhunter, scope: :headhunter)
        visit root_path
        click_on 'Vagas Cadastradas'
        click_on "#{job_opportunity.name} #{job_opportunity.opportunity_level}"\
                " #{job_opportunity.end_date_opportunity} #{job_opportunity.region}"
        click_on 'Encerrar Vaga'
        subscription.reload
        job_opportunity.reload
        
        expect(page).to have_content 'Vaga encerrada com sucesso'
        expect(subscription.hh_answer).to be_a(Feedback)
        expect(job_opportunity.status).to eq false
                
    end

    scenario 'with 2 subscriptions' do
        job_seeker = JobSeeker.create!(email: 'js@test.com', password: '123456')
        profile = Profile.create!(name: 'Pedro', nick_name: 'Pedrinho', day_of_birth: '1986-02-02', 
                                    education_level: 'Graduado',
                                    description: 'UEM', experience: 'Ja trabalhei com TI', document: '521.730.870-29',
                                    job_seeker: job_seeker, avatar: fixture_file_upload('avatar.JPG'))

        job_seeker2 = JobSeeker.create!(email: 'js2@test.com', password: '123456')
        profile2 = Profile.create!(name: 'Paulo', nick_name: 'Paulinho', day_of_birth: '1986-02-02', 
                                    education_level: 'Graduado',
                                    description: 'UEM', experience: 'Ja trabalhei com TI', document: '609.722.320-01',
                                    job_seeker: job_seeker2, avatar: fixture_file_upload('avatar.JPG'))
        headhunter = Headhunter.create!(email: 'hh@test.com', password: '123456')        
        job_opportunity = JobOpportunity.create!(headhunter: headhunter, name: 'Programador Ruby', description: 'Vaga para programador Ruby',
                                                   habilities: 'Saber programar', salary_range: 5000, 
                                                   opportunity_level: 'Pleno', end_date_opportunity: '02/02/2020',
                                                   region: 'Sâo Paulo')   
        subscription = Subscription.create!(job_seeker:job_seeker, job_opportunity:job_opportunity) 
        subscription2 = Subscription.create!(job_seeker:job_seeker2, job_opportunity:job_opportunity)        
        invitation = Invitation.create!(title:'Passou', message:'Vamos agendar uma entrevista.', initial_date: '02/03/2020', salary: 5000, position: 'Especialista',
            expectations: 'Trabalhar bem', bonus: 'PLR', benefits:'VR, VT')
        subscription.update(hh_answer:invitation, status:true)
            
        login_as(headhunter, scope: :headhunter)
        visit root_path
        click_on 'Vagas Cadastradas'
        click_on "#{job_opportunity.name} #{job_opportunity.opportunity_level}"\
                " #{job_opportunity.end_date_opportunity} #{job_opportunity.region}"
        click_on 'Encerrar Vaga'
        subscription.reload
        subscription2.reload
        job_opportunity.reload

        expect(page).to have_content 'Vaga encerrada com sucesso'
        expect(subscription2.hh_answer).to be_a(Feedback)
        expect(subscription.hh_answer).to be_a(Invitation)
        expect(job_opportunity.status).to eq false
                
    end

    scenario 'when headhunter searchs for job opportunities' do
        job_seeker = JobSeeker.create!(email: 'js@test.com', password: '123456')
        profile = Profile.create!(name: 'Pedro', nick_name: 'Pedrinho', day_of_birth: '1986-02-02', 
                                    education_level: 'Graduado',
                                    description: 'UEM', experience: 'Ja trabalhei com TI', document: '521.730.870-29',
                                    job_seeker: job_seeker, avatar: fixture_file_upload('avatar.JPG'))

        job_seeker2 = JobSeeker.create!(email: 'js2@test.com', password: '123456')
        profile = Profile.create!(name: 'Paulo', nick_name: 'Paulinho', day_of_birth: '1986-02-02', 
                                    education_level: 'Graduado',
                                    description: 'UEM', experience: 'Ja trabalhei com TI', document: '609.722.320-01',
                                    job_seeker: job_seeker2, avatar: fixture_file_upload('avatar.JPG'))
        headhunter = Headhunter.create!(email: 'hh@test.com', password: '123456')        
        job_opportunity = JobOpportunity.create!(headhunter: headhunter, name: 'Programador Ruby', description: 'Vaga para programador Ruby',
                                                   habilities: 'Saber programar', salary_range: 5000, 
                                                   opportunity_level: 'Pleno', end_date_opportunity: '02/02/2020',
                                                   region: 'Sâo Paulo')  
        job_opportunity2 = JobOpportunity.create!(headhunter: headhunter, name: 'Programador Ruby 2', description: 'Vaga para programador Ruby 2',
                                                   habilities: 'Saber programar muito', salary_range: 6000, 
                                                   opportunity_level: 'Especialista', end_date_opportunity: '02/02/2020',
                                                   region: 'Paraná', status:false)   

        login_as(headhunter, scope: :headhunter)
        visit root_path
        click_on 'Vagas'
        fill_in 'Buscar vaga:', with: 'Ruby'
        click_on 'Pesquisar'


        expect(page).to have_content "#{job_opportunity.name} #{job_opportunity.opportunity_level} #{job_opportunity.end_date_opportunity} #{job_opportunity.region}"
        expect(page).to have_content "Encerrada - #{job_opportunity2.name} #{job_opportunity2.opportunity_level} #{job_opportunity2.end_date_opportunity}"\
                                                " #{job_opportunity2.region}"\
                                    
        expect(job_opportunity.status).to eq true
        expect(job_opportunity2.status).to eq false
                
    end

    scenario 'home page job seeker' do
        headhunter = Headhunter.create!(email: 'hh@test.com', password: '123456') 
        job_seeker = JobSeeker.create!(email: 'js@test.com', password: '123456')
        profile = Profile.create!(name: 'Paulo', nick_name: 'Paulinho', day_of_birth: '1986-02-02', 
                                    education_level: 'Graduado',
                                    description: 'UEM', experience: 'Ja trabalhei com TI', document: '609.722.320-01',
                                    job_seeker: job_seeker, avatar: fixture_file_upload('avatar.JPG'))
        job_opportunity = JobOpportunity.create!(headhunter: headhunter, name: 'Programador Ruby', 
                                                 description: 'Vaga para programador Ruby',
                                                 habilities: 'Saber programar', salary_range: 5000, 
                                                 opportunity_level: 'Pleno', end_date_opportunity: '02/02/2020',
                                                 region: 'São Paulo')
        subscription = Subscription.create!(job_seeker:job_seeker, job_opportunity:job_opportunity) 
        subscription.reload    

        login_as(headhunter, scope: :headhunter)
        visit root_path
        click_on 'Vagas Cadastradas'
        click_on "#{job_opportunity.name} #{job_opportunity.opportunity_level}"\
                " #{job_opportunity.end_date_opportunity} #{job_opportunity.region}"
        click_on 'Encerrar Vaga'
        click_on 'Log out'

        login_as(job_seeker, scope: :job_seeker)
        visit root_path

        expect(page).to have_content 'Você tem um feedback para a vaga: Programador Ruby Pleno 2020-02-02 São Paulo'

    end


end