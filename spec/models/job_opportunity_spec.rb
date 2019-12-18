require 'rails_helper'

RSpec.describe JobOpportunity, type: :model do
  context '.destroy' do
    it 'must destroy one job opportunity' do
      headhunter = Headhunter.create!(email: 'test@test.com', password: '123456') 
      job_opportunity = JobOpportunity.create!(headhunter: headhunter, name: 'Programador Ruby', description: 'Vaga para programador Ruby',
                                                habilities: 'Saber programar', salary_range: 5000, 
                                                opportunity_level: 'Pleno', end_date_opportunity: '02/02/2020',
                                                region: 'Sâo Paulo')
      job_opportunity.destroy
      expect(JobOpportunity.count).to eq 0
    end
    it 'must destroy only one job opportunity' do
      headhunter = Headhunter.create!(email: 'test@test.com', password: '123456') 
      job_opportunity = JobOpportunity.create!(headhunter: headhunter, name: 'Programador Ruby', description: 'Vaga para programador Ruby',
                                                habilities: 'Saber programar', salary_range: 5000, 
                                                opportunity_level: 'Pleno', end_date_opportunity: '02/02/2020',
                                                region: 'Sâo Paulo')
      job_opportunity2 = JobOpportunity.create!(headhunter: headhunter, name: 'Programador Ruby 2', 
                                                description: 'Vaga para programador Ruby MUITO',
                                                habilities: 'Saber programar', salary_range: 10000, 
                                                opportunity_level: 'Pleno', end_date_opportunity: '02/02/2020',
                                                region: 'Sâo Paulo')
      job_opportunity.destroy
      expect(JobOpportunity.count).to eq 1
    end
  end
end
