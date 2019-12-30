require 'rails_helper'
    feature ' headhunter sends answer to job seeker' do
        scenario 'invitation' do
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
            click_on "#{profile.name} #{profile.document} #{profile.education_level}"
            find('#with_subscription').click_on 'Enviar Proposta'
            fill_in 'Título:', with: 'Candidato aceito'
            fill_in 'Mensagem:', with: 'Candidato aceito para entrevista'
            fill_in 'Data de início:', with:  '02/03/2020'
            fill_in 'Salário:', with: 5000
            fill_in 'Cargo:', with: 'Especialista'
            fill_in 'Expectativas:', with: 'Tranbalhar bem'
            fill_in 'Bonus:', with: 'PLR'
            fill_in 'Benefícios:', with: 'VT e VR'
            
            click_on 'Enviar Proposta'
            subscription.reload

            expect(page).to have_content 'Proposta enviada com sucesso'
            expect(subscription.hh_answer).to be_a(Invitation)
            
        end

        scenario 'reject subscription' do
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
            click_on "#{profile.name} #{profile.document} #{profile.education_level}"
            find('#with_subscription').click_on 'Recusar Inscrição'
            fill_in 'Título:', with: 'Candidato Não passou'
            fill_in 'Mensagem:', with: 'Candidato não passou para entrevista'
            click_on 'Enviar Feedback'
            subscription.reload
            
                
            expect(page).to have_content 'Inscrição rejeitada. Feedback enviado com sucesso.'
            expect(subscription.hh_answer).to be_a(Feedback)

        end

        scenario 'headhunter home page when job seeker accepts ' do
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
            invitation = Invitation.create!(title:'Passou', message:'Vamos agendar uma entrevista.', initial_date:  '02/03/2020', salary: 5000, position: 'Especialista',
                expectations: 'Trabalhar bem', bonus: 'PLR', benefits:'VR, VT')
            subscription.update(hh_answer:invitation, status:true)
            subscription.reload

            login_as(headhunter, scope: :headhunter)
            visit root_path

            expect(page).to have_content "#{profile.name} #{profile.document} #{profile.education_level} aceitou convite para vaga #{job_opportunity.name}"\
            " #{job_opportunity.opportunity_level} #{job_opportunity.end_date_opportunity} #{job_opportunity.region}"
            
        end

        scenario 'headhunter home page when job seeker reejects ' do
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
            invitation = Invitation.create!(title:'Passou', message:'Vamos agendar uma entrevista.', initial_date:  '02/03/2020', salary: 5000, position: 'Especialista',
                expectations: 'Trabalhar bem', bonus: 'PLR', benefits:'VR, VT')
            subscription.update(hh_answer:invitation, status:false)
            subscription.reload

            login_as(headhunter, scope: :headhunter)
            visit root_path

            expect(page).to have_content "#{profile.name} #{profile.document} #{profile.education_level} recusou convite para vaga #{job_opportunity.name}"\
            " #{job_opportunity.opportunity_level} #{job_opportunity.end_date_opportunity} #{job_opportunity.region}"
            
        end

        scenario 'headhunter home page when job seeker didnt respond' do
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
            invitation = Invitation.create!(title:'Passou', message:'Vamos agendar uma entrevista.', initial_date:  '02/03/2020', salary: 5000, position: 'Especialista',
                expectations: 'Trabalhar bem', bonus: 'PLR', benefits:'VR, VT')
            subscription.update(hh_answer:invitation)
            subscription.reload

            login_as(headhunter, scope: :headhunter)
            visit root_path

            expect(page).to have_content 'Aguardando resposta:'
            expect(page).to have_content "#{profile.name} #{profile.document} #{profile.education_level} para a vaga #{job_opportunity.name}"\
            " #{job_opportunity.opportunity_level} #{job_opportunity.end_date_opportunity} #{job_opportunity.region}"
            
        end

        scenario 'headhunter job opportunity view when job seeker didnt respond' do
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
            invitation = Invitation.create!(title:'Passou', message:'Vamos agendar uma entrevista.', initial_date:  '02/03/2020', salary: 5000, position: 'Especialista',
                expectations: 'Trabalhar bem', bonus: 'PLR', benefits:'VR, VT')
            subscription.update(hh_answer:invitation)
            subscription.reload

            login_as(headhunter, scope: :headhunter)
            visit root_path
            click_on 'Vagas Cadastradas'
            click_on "#{job_opportunity.name} #{job_opportunity.opportunity_level} #{job_opportunity.end_date_opportunity} #{job_opportunity.region}"

            expect(page).to have_content 'Aguardando resposta do candidato:'
            expect(page).to have_content "#{profile.name} #{profile.document} #{profile.education_level}"
            
        end
    end