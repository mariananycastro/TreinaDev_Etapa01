require 'rails_helper'

RSpec.describe JobOpportunity, type: :model do
  context '.destroy' do
    it 'must destroy one job opportunity' do
      headhunter = Headhunter.create!(email: 'test@test.com', password: '123456') 
      job_opportunity = JobOpportunity.create!(headhunter: headhunter, name: 'Programador Ruby', description: 'Vaga para programador Ruby',
                                                habilities: 'Saber programar', salary_range: 5000, 
                                                opportunity_level: 'Pleno', end_date_opportunity: '02/02/2021',
                                                region: 'Sâo Paulo')
      job_opportunity.destroy
      expect(JobOpportunity.count).to eq 0
    end
    it 'must destroy only one job opportunity' do
      headhunter = Headhunter.create!(email: 'test@test.com', password: '123456') 
      job_opportunity = JobOpportunity.create!(headhunter: headhunter, name: 'Programador Ruby', description: 'Vaga para programador Ruby',
                                                habilities: 'Saber programar', salary_range: 5000, 
                                                opportunity_level: 'Pleno', end_date_opportunity: '02/02/2021',
                                                region: 'Sâo Paulo')
      job_opportunity2 = JobOpportunity.create!(headhunter: headhunter, name: 'Programador Ruby 2', 
                                                description: 'Vaga para programador Ruby MUITO',
                                                habilities: 'Saber programar', salary_range: 10000, 
                                                opportunity_level: 'Pleno', end_date_opportunity: '02/02/2021',
                                                region: 'Sâo Paulo')
      job_opportunity.destroy
      expect(JobOpportunity.count).to eq 1
    end
  end
  
  context '.subscribe' do
    it 'successfully' do
      job_seeker = JobSeeker.create!(email: 'js@test.com', password: '123456')
      headhunter = Headhunter.create!(email: 'hh@test.com', password: '123456')        
      job_opportunity = JobOpportunity.create!(headhunter: headhunter, name: 'Programador Ruby', description: 'Vaga para programador Ruby',
                                                 habilities: 'Saber programar', salary_range: 5000, 
                                                 opportunity_level: 'Pleno', end_date_opportunity: '02/02/2021',
                                                 region: 'Sâo Paulo')
      
      subscription = Subscription.create!(job_seeker: job_seeker, job_opportunity: job_opportunity)
      
      expect(subscription.job_seeker).to eq job_seeker
      expect(subscription.job_opportunity).to eq job_opportunity
    
    end

  end

  context '.index' do
    it 'sucessfully' do
      headhunter = Headhunter.create!(email: 'hh@test.com', password: '123456')        
      job_opportunity = JobOpportunity.create!(headhunter: headhunter, name: 'Programador Ruby', description: 'Vaga para programador Ruby',
                                                 habilities: 'Saber programar', salary_range: 5000, 
                                                 opportunity_level: 'Pleno', end_date_opportunity: '02/02/2021',
                                                 region: 'Sâo Paulo')
      job_opportunity = JobOpportunity.create!(headhunter: headhunter, name: 'Programador Ruby', description: 'Vaga para programador Ruby',
                                                 habilities: 'Saber programar', salary_range: 5000, 
                                                 opportunity_level: 'Pleno', end_date_opportunity: '02/02/2021',
                                                 region: 'Sâo Paulo')

      job_opportunities = headhunter.job_opportunities.where(headhunter:headhunter)
      job_opportunities_of_headhunter = headhunter.job_opportunities

      expect(job_opportunities.count).to eq 2

    end
  end

    context 'test end date opportunity' do
      it '= today'do
        headhunter = Headhunter.create!(email: 'hh@test.com', password: '123456')        
        job_opportunity = JobOpportunity.new(headhunter: headhunter, name: 'Programador Ruby', description: 'Vaga para programador Ruby',
                                                   habilities: 'Saber programar', salary_range: 5000, 
                                                   opportunity_level: 'Pleno', end_date_opportunity: Date.current,
                                                   region: 'Sâo Paulo')

        expect(job_opportunity.valid?).to eq false
        expect(job_opportunity.errors.full_messages).to include('Data limite de inscrição deve ser maior que data de hoje')
      end

      it '>  today' do
        headhunter = Headhunter.create!(email: 'hh@test.com', password: '123456')        
        job_opportunity = JobOpportunity.new(headhunter: headhunter, name: 'Programador Ruby', description: 'Vaga para programador Ruby',
                                                   habilities: 'Saber programar', salary_range: 5000, 
                                                   opportunity_level: 'Pleno', end_date_opportunity: 2.days.from_now,
                                                   region: 'Sâo Paulo')

        job_opportunity.valid?

        expect(job_opportunity.errors).to be_empty
      end

      it '<  today' do
        headhunter = Headhunter.create!(email: 'hh@test.com', password: '123456')        
        job_opportunity = JobOpportunity.new(headhunter: headhunter, name: 'Programador Ruby', description: 'Vaga para programador Ruby',
                                                   habilities: 'Saber programar', salary_range: 5000, 
                                                   opportunity_level: 'Pleno', end_date_opportunity: 2.days.ago,
                                                   region: 'Sâo Paulo')

        expect(job_opportunity.valid?).to eq false
        expect(job_opportunity.errors.full_messages).to include('Data limite de inscrição deve ser maior que data de hoje')
      end
    end

end
