require 'rails_helper'

  feature 'end date opportunity must be greater than yesterday to job seeker subscribe' do
    it '= today'do
      headhunter = Headhunter.create!(email: 'hh@test.com', password: '123456')        
      job_opportunity = JobOpportunity.new(headhunter: headhunter, name: 'Programador Ruby', description: 'Vaga para programador Ruby',
                                                 habilities: 'Saber programar', salary_range: 5000, 
                                                 opportunity_level: 'Pleno', end_date_opportunity: Date.current,
                                                 region: 'Sâo Paulo')
      job_seeker = JobSeeker.create!(email: 'js@test.com', password: '123456')
      profile = Profile.create!(name: 'Pedro', nick_name: 'Pedrinho', day_of_birth: '1986-02-02', 
                                    education_level: 'Graduado',
                                    description: 'UEM', experience: 'Ja trabalhei com TI', document: '521.730.870-29',
                                    job_seeker: job_seeker, avatar: fixture_file_upload('avatar.JPG'))
      subscription = Subscription.new(job_seeker:job_seeker, job_opportunity:job_opportunity)  
      
      expect(subscription.valid?).to eq false
      expect(subscription.errors.full_messages).to include('End date subscription já encerrada')
    end
  
    it '>  today' do
      headhunter = Headhunter.create!(email: 'hh@test.com', password: '123456')        
      job_opportunity = JobOpportunity.new(headhunter: headhunter, name: 'Programador Ruby', description: 'Vaga para programador Ruby',
                                                 habilities: 'Saber programar', salary_range: 5000, 
                                                 opportunity_level: 'Pleno', end_date_opportunity: 2.days.from_now,
                                                 region: 'Sâo Paulo')
      job_seeker = JobSeeker.create!(email: 'js@test.com', password: '123456')
      profile = Profile.create!(name: 'Pedro', nick_name: 'Pedrinho', day_of_birth: '1986-02-02', 
                                    education_level: 'Graduado',
                                    description: 'UEM', experience: 'Ja trabalhei com TI', document: '521.730.870-29',
                                    job_seeker: job_seeker, avatar: fixture_file_upload('avatar.JPG'))
      subscription = Subscription.new(job_seeker:job_seeker, job_opportunity:job_opportunity)  
      
      subscription.valid?
      
      expect(subscription.errors).to be_empty
    end
  
    it '<  today' do
      headhunter = Headhunter.create!(email: 'hh@test.com', password: '123456')        
      job_opportunity = JobOpportunity.new(headhunter: headhunter, name: 'Programador Ruby', description: 'Vaga para programador Ruby',
                                                 habilities: 'Saber programar', salary_range: 5000, 
                                                 opportunity_level: 'Pleno', end_date_opportunity: 2.days.ago,
                                                 region: 'Sâo Paulo')
      job_seeker = JobSeeker.create!(email: 'js@test.com', password: '123456')
      profile = Profile.create!(name: 'Pedro', nick_name: 'Pedrinho', day_of_birth: '1986-02-02', 
                                    education_level: 'Graduado',
                                    description: 'UEM', experience: 'Ja trabalhei com TI', document: '521.730.870-29',
                                    job_seeker: job_seeker, avatar: fixture_file_upload('avatar.JPG'))
      subscription = Subscription.new(job_seeker:job_seeker, job_opportunity:job_opportunity)  
      
      
      expect(subscription.valid?).to eq false
      expect(subscription.errors.full_messages).to include('End date subscription já encerrada')
    end
  end