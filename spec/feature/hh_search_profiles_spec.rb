require 'rails_helper'
    feature 'hh search profiles' do
        scenario 'successfully' do
        headhunter = Headhunter.create!(email: 'hh@test.com', password: '123456') 
        job_seeker = JobSeeker.create!(email: 'js@test.com', password: '123456')
        profile = Profile.create!(name: 'Pedro', nick_name: 'Pedrinho', day_of_birth: '1986-02-02', 
                                    education_level: 'Graduado',
                                    description: 'UEM', experience: 'Ja trabalhei com TI', document: '521.730.870-29',
                                    job_seeker: job_seeker, avatar: fixture_file_upload('avatar.JPG'))

        login_as(headhunter, scope: :headhunter)
        visit root_path
        click_on 'Pesquisar Candidatos'
        fill_in 'Buscar Candidatos:', with: 'Graduado'
        click_on 'Pesquisar'

        expect(page).to have_content 'Pedro 521.730.870-29 Graduado'

        end

        scenario 'search by education level' do
            headhunter = Headhunter.create!(email: 'hh@test.com', password: '123456') 
            job_seeker = JobSeeker.create!(email: 'js@test.com', password: '123456')
            profile = Profile.create!(name: 'Pedro', nick_name: 'Pedrinho', day_of_birth: '1986-02-02', 
                                        education_level: 'Graduado',
                                        description: 'UEM', experience: 'Ja trabalhei com TI', document: '521.730.870-29',
                                        job_seeker: job_seeker, avatar: fixture_file_upload('avatar.JPG'))
            job_seeker2 = JobSeeker.create!(email: 'js2@test.com', password: '123456')
            profile2 = Profile.create!(name: 'José', nick_name: 'Zé', day_of_birth: '1986-02-02', 
                                        education_level: 'Pos-graduado',
                                        description: 'Unesp', experience: 'Ja trabalhei com TI', document: '595.487.167-12',
                                        job_seeker: job_seeker, avatar: fixture_file_upload('avatar.JPG'))
    
            login_as(headhunter, scope: :headhunter)
            visit root_path
            click_on 'Pesquisar Candidatos'
            fill_in 'Buscar Candidatos:', with: 'Graduado'
            click_on 'Pesquisar'
    
            expect(page).to have_content 'Pedro 521.730.870-29 Graduado'
    
        end

        scenario 'search by description' do
            headhunter = Headhunter.create!(email: 'hh@test.com', password: '123456') 
            job_seeker = JobSeeker.create!(email: 'js@test.com', password: '123456')
            profile = Profile.create!(name: 'Pedro', nick_name: 'Pedrinho', day_of_birth: '1986-02-02', 
                                        education_level: 'Graduado',
                                        description: 'UEM', experience: 'Ja trabalhei com TI', document: '521.730.870-29',
                                        job_seeker: job_seeker, avatar: fixture_file_upload('avatar.JPG'))
            job_seeker2 = JobSeeker.create!(email: 'js2@test.com', password: '123456')
            profile2 = Profile.create!(name: 'José', nick_name: 'Zé', day_of_birth: '1986-02-02', 
                                        education_level: 'Pos-graduado',
                                        description: 'Unesp', experience: 'Ja trabalhei com TI', document: '595.487.167-12',
                                        job_seeker: job_seeker2, avatar: fixture_file_upload('avatar.JPG'))
    
            login_as(headhunter, scope: :headhunter)
            visit root_path
            click_on 'Pesquisar Candidatos'
            fill_in 'Buscar Candidatos:', with: 'Unesp'
            click_on 'Pesquisar'
    
            expect(page).to have_content 'José 595.487.167-12 Pos-graduado'
    
        end
    end