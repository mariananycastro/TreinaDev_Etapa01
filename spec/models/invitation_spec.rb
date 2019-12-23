require 'rails_helper'
  feature 'headhunter create invitation' do
    it 'successfully' do
      job_seeker = JobSeeker.create!(email: 'js@test.com', password: '123456')
      profile = Profile.create!(name: 'Pedro', nick_name: 'Pedrinho', day_of_birth: '1986-02-02', 
                                  education_level: 'Graduado',
                                  description: 'UEM', experience: 'Ja trabalhei com TI', document: '521.730.870-29',
                                  job_seeker: job_seeker)
      headhunter = Headhunter.create!(email: 'hh@test.com', password: '123456')        
      job_opportunity = JobOpportunity.create!(headhunter: headhunter, name: 'Programador Ruby', description: 'Vaga para programador Ruby',
                                                 habilities: 'Saber programar', salary_range: 5000, 
                                                 opportunity_level: 'Pleno', end_date_opportunity: '02/02/2020',
                                                 region: 'Sâo Paulo')
      subscription = Subscription.create!(job_seeker:job_seeker, job_opportunity:job_opportunity) 
      invitation = Invitation.create!(title:'Passou', message:'Vamos marcar uma entrevista.')
        
      subscription.update_attribute(:hh_answer, invitation)

      expect(subscription.hh_answer).to eq invitation

    end
  end