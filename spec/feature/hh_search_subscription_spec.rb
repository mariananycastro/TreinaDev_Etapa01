require 'rails_helper'
feature 'hh search for subscription' do
  scenario 'successfully' do
    headhunter = create(:headhunter)
    job_opportunity = create(:job_opportunity, headhunter:headhunter)

    job_seeker = create(:job_seeker)
    profile = create(:profile, job_seeker_id:job_seeker.id, education_level: 'Graduado')
    subscription = Subscription.create!(job_seeker:job_seeker, job_opportunity:job_opportunity) 

    job_seeker2 = create(:job_seeker)
    profile2 = create(:profile, :profile2, job_seeker_id:job_seeker2.id, education_level: 'Mestrado')
    subscription = Subscription.create!(job_seeker:job_seeker2, job_opportunity:job_opportunity) 

    job_seeker3 = create(:job_seeker)
    profile3 = create(:profile, :profile3, job_seeker_id:job_seeker3.id, education_level: 'Pos-Graduado')
    subscription = Subscription.create!(job_seeker:job_seeker3, job_opportunity:job_opportunity) 

    login_as(headhunter, scope: :headhunter)
    visit root_path
    click_on 'Vagas Cadastradas'
    click_on "#{job_opportunity.name} #{job_opportunity.opportunity_level}"\
    " #{job_opportunity.end_date_opportunity} #{job_opportunity.region}"
    click_on 'Busca Avançada'
    byebug
    fill_in 'Escolaridade', with: 'Graduado'
    fill_in 'Descrição', with: ''
    fill_in 'Experiência', with: ''
    click_on 'Pesquisar'

    expect(page).to have_content(job_seeker.name)
    expect(page).not_to have_content(job_seeker2.name)
    expect(page).to have_content(job_seeker3.name)


  end
  xscenario 'successfully with factorybot' do
    headhunter = create(:headhunter)

    job_seeker = generate(:job_seeker)
    profile = create(:profile, job_seeker_id:job_seeker)
    subscription = 

    job_seeker2 = generate(:job_seeker)
    profile2 = create(:profile2, job_seeker_id:job_seeker2)

    job_seeker3 = generate(:job_seeker)
    profile3 = create(:profile3, job_seeker_id:job_seeker3)

    job_opportunity = create(:job_opportunity, )
    
    login_as(headhunter, scope: :headhunter)
    visit root_path
    click_on 'Pesquisar Subscrição'
    fill_in '', with: ''
    click_on 'Pesquisar'

    expect(page).to have_content()

  end
end