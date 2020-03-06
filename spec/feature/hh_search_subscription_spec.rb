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
    fill_in 'Escolaridade', with: 'Graduado'
    fill_in 'Descrição', with: ''
    fill_in 'Experiência', with: ''
    click_on 'Pesquisar'

    expect(page).to have_content(profile.name)
    expect(page).not_to have_content(profile2.name)
    expect(page).to have_content(profile3.name)
  end

  scenario 'successfully with factorybot' do
    headhunter = create(:headhunter)
    job_opportunity = create(:job_opportunity, headhunter:headhunter)

    job_seeker = create(:job_seeker)
    profile = create(:profile, job_seeker_id:job_seeker.id, education_level: 'Graduado')
    subscription = create(:subscription, job_seeker_id: job_seeker.id, job_opportunity_id: job_opportunity.id) 

    job_seeker2 = create(:job_seeker)
    profile2 = create(:profile, :profile2, job_seeker_id:job_seeker2.id, education_level: 'Mestrado')
    subscription = create(:subscription, job_seeker_id: job_seeker2.id, job_opportunity_id: job_opportunity.id) 

    job_seeker3 = create(:job_seeker)
    profile3 = create(:profile, :profile3, job_seeker_id:job_seeker3.id, education_level: 'Pos-Graduado')
    subscription = create(:subscription, job_seeker_id: job_seeker3.id, job_opportunity_id: job_opportunity.id) 

    login_as(headhunter, scope: :headhunter)
    visit root_path
    click_on 'Vagas Cadastradas'
    click_on "#{job_opportunity.name} #{job_opportunity.opportunity_level}"\
    " #{job_opportunity.end_date_opportunity} #{job_opportunity.region}"
    click_on 'Busca Avançada'
    fill_in 'Escolaridade', with: 'Graduado'
    fill_in 'Descrição', with: ''
    fill_in 'Experiência', with: ''
    click_on 'Pesquisar'

    expect(page).to have_content(profile.name)
    expect(page).not_to have_content(profile2.name)
    expect(page).to have_content(profile3.name)

  end
end