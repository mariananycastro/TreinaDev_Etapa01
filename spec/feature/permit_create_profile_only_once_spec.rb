require 'rails_helper'

feature 'create js profile only once' do
    scenario 'successfully' do
        job_seeker = JobSeeker.create!(email: 'test@test.com', password: '123456')

        login_as(job_seeker, scope: :job_seeker)
        visit root_path
        
        expect(page).to have_content 'Criar Perfil'
        expect(page).not_to have_content 'Editar Perfil'
    end

    scenario 'successfully' do
        job_seeker = JobSeeker.create!(email: 'test@test.com', password: '123456')
        Profile.create!(job_seeker: job_seeker, name: 'Joao da Silva', document: '595.487.167-12', nick_name: 'João',
                        day_of_birth: '12/01/1986', education_level: 'Graduado', 
                        description: 'Ciencia da computacao', experience: 'Trabalhei com computacao')

        login_as(job_seeker, scope: :job_seeker)

        visit root_path
        expect(page).to have_content 'Editar Perfil'
        expect(page).not_to have_content 'Criar Perfil'
    
    end
end