require 'rails_helper'

    feature 'headhunter creates comment of job seeker' do
        scenario 'successfully' do

            job_seeker = JobSeeker.create!(email: 'js@test.com', password: '123456')
            profile = Profile.create!(name: 'Pedro', nick_name: 'Pedrinho', day_of_birth: '1986-02-02', 
                                        education_level: 'Graduado',
                                        description: 'UEM', experience: 'Ja trabalhei com TI', document: '521.730.870-29',
                                        job_seeker: job_seeker)
            headhunter = Headhunter.create!(email: 'hh@test.com', password: '123456')        
            job_opportunity = JobOpportunity.create!(headhunter: headhunter, name: 'Programador Ruby', description: 'Vaga para programador Ruby',
                                                       habilities: 'Saber programar', salary_range: 5000, 
                                                       opportunity_level: 'Pleno', end_date_opportunity: '02/02/2020',
                                                       region: 'São Paulo')
            subscription = Subscription.create!(job_seeker:job_seeker, job_opportunity:job_opportunity)
            
    
            login_as(headhunter, scope: :headhunter)
            visit root_path
            click_on 'Vagas Cadastradas'
            click_on "#{job_opportunity.name} #{job_opportunity.opportunity_level}"\
                    " #{job_opportunity.end_date_opportunity} #{job_opportunity.region}"
            click_on "#{profile.name} #{profile.document} #{profile.education_level}"
            click_on 'Adicionar Comentário'
            fill_in 'Programador Ruby Pleno 2020-02-02 São Paulo', with: 'Gostei desse candidato'
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
                                        job_seeker: job_seeker)
            headhunter = Headhunter.create!(email: 'hh@test.com', password: '123456')        
            job_opportunity = JobOpportunity.create!(headhunter: headhunter, name: 'Programador Ruby', description: 'Vaga para programador Ruby',
                                                       habilities: 'Saber programar', salary_range: 5000, 
                                                       opportunity_level: 'Pleno', end_date_opportunity: '02/02/2020',
                                                       region: 'São Paulo')
    
            @subscription = Subscription.create!(job_seeker:job_seeker, job_opportunity:job_opportunity)
            
    
            login_as(headhunter, scope: :headhunter)
            visit root_path
            click_on 'Vagas Cadastradas'
            click_on "#{job_opportunity.name} #{job_opportunity.opportunity_level}"\
                    " #{job_opportunity.end_date_opportunity} #{job_opportunity.region}"
            click_on "#{profile.name} #{profile.document} #{profile.education_level}"
            click_on 'Adicionar Comentário'
            fill_in 'Programador Ruby Pleno 2020-02-02 São Paulo', with: 'Gostei desse candidato'
            click_on 'Salvar Comentário'
            click_on 'Editar Comentário'
            fill_in 'Programador Ruby Pleno 2020-02-02 São Paulo' , with: 'Não gosto mais'
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
                                        job_seeker: job_seeker)
            headhunter = Headhunter.create!(email: 'hh@test.com', password: '123456')        
            job_opportunity = JobOpportunity.create!(headhunter: headhunter, name: 'Programador Ruby', description: 'Vaga para programador Ruby',
                                                       habilities: 'Saber programar', salary_range: 5000, 
                                                       opportunity_level: 'Pleno', end_date_opportunity: '02/02/2020',
                                                       region: 'São Paulo')
    
            subscription = Subscription.create!(job_seeker:job_seeker, job_opportunity:job_opportunity)
            subscription_comment = SubscriptionComment.create!(comment:'Gostei de  vc', subscription:subscription)          
    
            login_as(headhunter, scope: :headhunter)
            visit root_path
            click_on 'Vagas Cadastradas'
            click_on "#{job_opportunity.name} #{job_opportunity.opportunity_level}"\
                    " #{job_opportunity.end_date_opportunity} #{job_opportunity.region}"
            click_on "#{profile.name} #{profile.document} #{profile.education_level}"
            click_on 'Deletar Comentário'
 
            expect(page).to have_link 'Adicionar Comentário'
        end
    end