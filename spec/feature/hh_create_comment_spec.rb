require 'rails_helper'

    feature 'headhunter creates comment of job seeker' do
        scenario 'successfully' do

            job_seeker = JobSeeker.create!(email: 'js@test.com', password: '123456')
            profile = Profile.create!(name: 'Pedro', nick_name: 'Pedrinho', day_of_birth: '1986-02-02', 
                                        education_level: 'Graduado',
                                        description: 'UEM', experience: 'Ja trabalhei com TI', document: '521.730.870-29',
                                        job_seeker: job_seeker, avatar: fixture_file_upload('avatar.JPG'))
            headhunter = Headhunter.create!(email: 'hh@test.com', password: '123456')        
            job_opportunity = JobOpportunity.create!(headhunter: headhunter, name: 'Programador Ruby', description: 'Vaga para programador Ruby',
                                                       habilities: 'Saber programar', salary_range: 5000, 
                                                       opportunity_level: 'Pleno', end_date_opportunity: '02/02/2021',
                                                       region: 'São Paulo')
            subscription = Subscription.create!(job_seeker:job_seeker, job_opportunity:job_opportunity)
            
    
            login_as(headhunter, scope: :headhunter)
            visit root_path
            click_on 'Vagas Cadastradas'
            click_on "#{job_opportunity.name} #{job_opportunity.opportunity_level}"\
                    " #{job_opportunity.end_date_opportunity} #{job_opportunity.region}"
            click_on "#{profile.name} #{profile.document} #{profile.education_level}"
            click_on 'Adicionar Comentário'
            fill_in 'Comentário', with: 'Gostei desse candidato'
            click_on 'Salvar Comentário'
            
            expect(page).to have_content ('Gostei desse candidato')
            expect(page).to have_link 'Editar Comentário'
            expect(page).not_to have_link 'Salvar Comentário'
        end

        scenario 'edit comment' do

            job_seeker = JobSeeker.create!(email: 'js@test.com', password: '123456')
            profile = Profile.create!(name: 'Pedro', nick_name: 'Pedrinho', day_of_birth: '1986-02-02', 
                                        education_level: 'Graduado',
                                        description: 'UEM', experience: 'Ja trabalhei com TI', document: '521.730.870-29',
                                        job_seeker: job_seeker, avatar: fixture_file_upload('avatar.JPG'))
            headhunter = Headhunter.create!(email: 'hh@test.com', password: '123456')        
            job_opportunity = JobOpportunity.create!(headhunter: headhunter, name: 'Programador Ruby', description: 'Vaga para programador Ruby',
                                                       habilities: 'Saber programar', salary_range: 5000, 
                                                       opportunity_level: 'Pleno', end_date_opportunity: '02/02/2021',
                                                       region: 'São Paulo')
    
            @subscription = Subscription.create!(job_seeker:job_seeker, job_opportunity:job_opportunity)
            
    
            login_as(headhunter, scope: :headhunter)
            visit root_path
            click_on 'Vagas Cadastradas'
            click_on "#{job_opportunity.name} #{job_opportunity.opportunity_level}"\
                    " #{job_opportunity.end_date_opportunity} #{job_opportunity.region}"
            click_on "#{profile.name} #{profile.document} #{profile.education_level}"
            click_on 'Adicionar Comentário'
            fill_in 'Comentário', with: 'Gostei desse candidato'
            click_on 'Salvar Comentário'
            click_on 'Editar Comentário'
            fill_in 'Comentário' , with: 'Não gosto mais'
            click_on 'Salvar Comentário'

            expect(page).to have_content ('Não gosto mais')
            expect(page).to have_link 'Editar Comentário'
            expect(page).not_to have_link 'Salvar Comentário'

        end

       scenario 'delete comment' do

            job_seeker = JobSeeker.create!(email: 'js@test.com', password: '123456')
            profile = Profile.create!(name: 'Pedro', nick_name: 'Pedrinho', day_of_birth: '1986-02-02', 
                                        education_level: 'Graduado',
                                        description: 'UEM', experience: 'Ja trabalhei com TI', document: '521.730.870-29',
                                        job_seeker: job_seeker, avatar: fixture_file_upload('avatar.JPG'))
            headhunter = Headhunter.create!(email: 'hh@test.com', password: '123456')        
            job_opportunity = JobOpportunity.create!(headhunter: headhunter, name: 'Programador Ruby', description: 'Vaga para programador Ruby',
                                                       habilities: 'Saber programar', salary_range: 5000, 
                                                       opportunity_level: 'Pleno', end_date_opportunity: '02/02/2021',
                                                       region: 'São Paulo')
    
            subscription = Subscription.create!(job_seeker:job_seeker, job_opportunity:job_opportunity)
            profile_comment = ProfileComment.create!(comment:'Gostei de  vc', profile:profile, headhunter:headhunter)          
    
            login_as(headhunter, scope: :headhunter)
            visit root_path
            click_on 'Vagas Cadastradas'
            click_on "#{job_opportunity.name} #{job_opportunity.opportunity_level}"\
                    " #{job_opportunity.end_date_opportunity} #{job_opportunity.region}"
            click_on "#{profile.name} #{profile.document} #{profile.education_level}"
            click_on 'Deletar Comentário'
 
            expect(page).to have_link 'Adicionar Comentário'
        end

        scenario 'job seeker subscribes for more than one job opportunity' do

            job_seeker = JobSeeker.create!(email: 'js@test.com', password: '123456')
            profile = Profile.create!(name: 'Pedro', nick_name: 'Pedrinho', day_of_birth: '1986-02-02', 
                                        education_level: 'Graduado',
                                        description: 'UEM', experience: 'Ja trabalhei com TI', document: '521.730.870-29',
                                        job_seeker: job_seeker, avatar: fixture_file_upload('avatar.JPG'))
            headhunter = Headhunter.create!(email: 'hh@test.com', password: '123456')        
            job_opportunity = JobOpportunity.create!(headhunter: headhunter, name: 'Programador Ruby', description: 'Vaga para programador Ruby',
                                                       habilities: 'Saber programar', salary_range: 5000, 
                                                       opportunity_level: 'Pleno', end_date_opportunity: '02/02/2021',
                                                       region: 'São Paulo')
            subscription = Subscription.create!(job_seeker:job_seeker, job_opportunity:job_opportunity)
            job_opportunity2 = JobOpportunity.create!(headhunter: headhunter, name: 'Programador Ruby2', description: 'Vaga para programador Ruby',
                                                        habilities: 'Saber programar', salary_range: 5000, 
                                                        opportunity_level: 'Pleno', end_date_opportunity: '02/02/2021',
                                                        region: 'São Paulo')
            subscription2 = Subscription.create!(job_seeker:job_seeker, job_opportunity:job_opportunity2)
            
    
            login_as(headhunter, scope: :headhunter)
            visit root_path
            click_on 'Vagas Cadastradas'
            click_on "#{job_opportunity.name} #{job_opportunity.opportunity_level}"\
                    " #{job_opportunity.end_date_opportunity} #{job_opportunity.region}"
            click_on "#{profile.name} #{profile.document} #{profile.education_level}"
            
            expect(page).to have_content ('Programador Ruby Pleno 2021-02-02 São Paulo')
            expect(page).to have_content ('Programador Ruby2 Pleno 2021-02-02 São Paulo')

        end

        scenario 'job seeker subscribes two job opportunities from different headhunter' do

            job_seeker = JobSeeker.create!(email: 'js@test.com', password: '123456')
            profile = Profile.create!(name: 'Pedro', nick_name: 'Pedrinho', day_of_birth: '1986-02-02', 
                                        education_level: 'Graduado',
                                        description: 'UEM', experience: 'Ja trabalhei com TI', document: '521.730.870-29',
                                        job_seeker: job_seeker, avatar: fixture_file_upload('avatar.JPG'))
            headhunter = Headhunter.create!(email: 'hh@test.com', password: '123456')
            headhunter2 = Headhunter.create!(email: 'hh2@test.com', password: '123456')        
            job_opportunity = JobOpportunity.create!(headhunter: headhunter, name: 'Programador Ruby', description: 'Vaga para programador Ruby',
                                                       habilities: 'Saber programar', salary_range: 5000, 
                                                       opportunity_level: 'Pleno', end_date_opportunity: '02/02/2021',
                                                       region: 'São Paulo')
            subscription = Subscription.create!(job_seeker:job_seeker, job_opportunity:job_opportunity)
            job_opportunity2 = JobOpportunity.create!(headhunter: headhunter2, name: 'Programador Ruby2', description: 'Vaga para programador Ruby',
                                                        habilities: 'Saber programar', salary_range: 5000, 
                                                        opportunity_level: 'Pleno', end_date_opportunity: '02/02/2021',
                                                        region: 'São Paulo')
            subscription = Subscription.create!(job_seeker:job_seeker, job_opportunity:job_opportunity2)
            
    
            login_as(headhunter, scope: :headhunter)
            visit root_path
            click_on 'Vagas Cadastradas'
            click_on "#{job_opportunity.name} #{job_opportunity.opportunity_level}"\
                    " #{job_opportunity.end_date_opportunity} #{job_opportunity.region}"
            click_on "#{profile.name} #{profile.document} #{profile.education_level}"
            
            expect(page).to have_content ('Programador Ruby Pleno 2021-02-02 São Paulo')
            expect(page).not_to have_content ('Programador Ruby2 Pleno 2021-02-02 São Paulo')

        end
    end