
require 'rails_helper'

describe 'Job Opportunity Management' do
    context 'show' do
        it 'render job opportunity correctly' do
            #sem factory_bot
            #headhunter = Headhunter.create!(email: 'hh@test.com', password: '123456')  
            #job_opportunity = JobOpportunity.create!(headhunter: headhunter, name: 'Programador Ruby', 
            #                                         description: 'Vaga para programador Ruby',
            #                                         habilities: 'Saber programar', salary_range: 5000, 
            #                                         opportunity_level: 'Pleno', end_date_opportunity: '2020-02-02',
            #                                         region: 'Sâo Paulo')

            job_opportunity = create(:job_opportunity)

            get api_v1_job_opportunity_path(job_opportunity)
            json = JSON.parse(response.body, symbolize_names: true)

            expect(response).to have_http_status(:ok)
            expect(json[:headhunter_id]).to eq(job_opportunity.headhunter_id)
            expect(json[:name]).to eq(job_opportunity.name)
            expect(json[:description]).to eq(job_opportunity.description)
            expect(json[:habilities]).to eq(job_opportunity.habilities)
            expect(json[:salary_range]).to eq(job_opportunity.salary_range)
            expect(json[:opportunity_level]).to eq(job_opportunity.opportunity_level)
            expect(json[:end_date_opportunity]).to eq('2020-02-02')
            expect(json[:region]).to eq(job_opportunity.region)
        
        end
    
        it 'not found' do

            get api_v1_job_opportunity_path(id: 999)
            expect(response).to have_http_status(:not_found)
        end
    end
    
    context 'index' do

        it 'render job opportunities correctly' do

            headhunter = Headhunter.create!(email: 'hh@test.com', password: '123456')  
            job_opportunity1 = JobOpportunity.create!(headhunter: headhunter, name: 'Programador Ruby', 
                                                     description: 'Vaga para programador Ruby',
                                                     habilities: 'Saber programar', salary_range: 5000, 
                                                     opportunity_level: 'Pleno', end_date_opportunity: '2020-02-02',
                                                     region: 'Sâo Paulo')
            job_opportunity2 = JobOpportunity.create!(headhunter: headhunter, name: 'Programador Ruby2', 
                                                        description: 'Vaga para programador Ruby2',
                                                        habilities: 'Saber programar muito', salary_range: 5000, 
                                                        opportunity_level: 'Sênior', end_date_opportunity: '2020-02-03',
                                                        region: 'Sâo Paulo')
   

            get api_v1_job_opportunities_path
            json = JSON.parse(response.body, symbolize_names: true)

            expect(response).to have_http_status(:ok)
            expect(json[0][:headhunter_id]).to eq(job_opportunity1.headhunter.id)
            expect(json[0][:name]).to eq(job_opportunity1.name)
            expect(json[0][:description]).to eq(job_opportunity1.description)
            expect(json[0][:habilities]).to eq(job_opportunity1.habilities)
            expect(json[0][:salary_range]).to eq(job_opportunity1.salary_range)
            expect(json[0][:opportunity_level]).to eq(job_opportunity1.opportunity_level)
            expect(json[0][:end_date_opportunity]).to eq('2020-02-02')
            expect(json[0][:region]).to eq(job_opportunity2.region)
            expect(json[1][:headhunter_id]).to eq(job_opportunity2.headhunter.id)
            expect(json[1][:name]).to eq(job_opportunity2.name)
            expect(json[1][:description]).to eq(job_opportunity2.description)
            expect(json[1][:habilities]).to eq(job_opportunity2.habilities)
            expect(json[1][:salary_range]).to eq(job_opportunity2.salary_range)
            expect(json[1][:opportunity_level]).to eq(job_opportunity2.opportunity_level)
            expect(json[1][:end_date_opportunity]).to eq('2020-02-03')
            expect(json[1][:region]).to eq(job_opportunity2.region)
            
        end
    end

    context 'create' do
        
        it ' create job_opportunity correctly' do
            
            job_opportunity = create(:job_opportunity)

            post api_v1_job_opportunities_path, params: {headhunter_id: job_opportunity.headhunter_id, name: job_opportunity.name, description: job_opportunity.description,
                                                        habilities: job_opportunity.habilities, salary_range: job_opportunity.salary_range,
                                                        opportunity_level: job_opportunity.opportunity_level, end_date_opportunity: job_opportunity.end_date_opportunity,
                                                        region: job_opportunity.region}

            json = JSON.parse(response.body, symbolize_names: true)
            
            expect(response).to have_http_status(201)
            expect(json[:headhunter_id]).to eq(job_opportunity.headhunter_id)
            expect(json[:name]).to eq(job_opportunity.name) 
            expect(json[:description]).to eq(job_opportunity.description)
            expect(json[:habilities]).to eq(job_opportunity.habilities)
            expect(json[:salary_range]).to eq(job_opportunity.salary_range)
            expect(json[:opportunity_level]).to eq(job_opportunity.opportunity_level)
            expect(json[:end_date_opportunity]).to eq(job_opportunity.end_date_opportunity)
            expect(json[:region]).to eq(job_opportunity.region)

            last_job_opportunity = JobOpportunitu.last
            
            expect(last_job_opportunity).to eq(job_opportunity)

        end

        it 'job opportunity without all validations' do
          job_opportunity = create(:job_opportunity)
          post api_v1_job_opportunities_path, params: {}
          
          json = JSON.parse(response.body, symbolize_names: true)
          
          expect(response).to have_http_status(412)
          expect(response.body).to include('Precondition Falled')
          
        end
    end

    context 'Update' do
      it 'job opportunity update' do
        job_opportunity = create(:job_opportunity)
        put api_v1_job_opportunity_path(job_opportunity), params: {headhunter_id: job_opportunity.headhunter_id, name: 'Nova vaga', description: 'Nova descrição',
                                                                  habilities: 'Novas habilidades', salary_range: 4000,
                                                                  opportunity_level: 'Estagiário', end_date_opportunity: "2020-02-02",
                                                                  region: 'Rio'}
    
        json = JSON.parse(response.body, symbolize_names: true)
        
        expect(response).to have_http_status(200)
        expect(json[:headhunter_id]).to eq(job_opportunity.headhunter_id)
        expect(json[:name]).to eq('Nova vaga') 
        expect(json[:description]).to eq('Nova descrição')
        expect(json[:habilities]).to eq('Novas habilidades')
        expect(json[:salary_range]).to eq('4000')
        expect(json[:opportunity_level]).to eq('Estagiário')
        expect(json[:end_date_opportunity]).to eq("2020-02-02")
        expect(json[:region]).to eq("Rio")
    
        end
    end
    
    context 'delete' do
      it 'Should delete a job opportunity correctly' do
        headhunter = create(:headhunter)
        job_opportunity = create(:job_opportunity, headhunter_id: headhunter.id)

        delete api_v1_job_opportunity_path(job_opportunity)

        json = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(200)
        expect(json[:message]).to eq("Job Opportunity delete with Successfully.")
       
     end
      
      it 'Should delete one job opportuniry correctly' do
        headhunter = create(:headhunter)
        job_opportunity1 = create(:job_opportunity, headhunter_id: headhunter.id)
        job_opportunity2 = create(:job_opportunity, headhunter_id: headhunter.id)

        delete api_v1_job_opportunity_path(job_opportunity1)
        job_opportunities = JobOpportunity.all
        
        expect(job_opportunities).not_to include(job_opportunity1)
        expect(job_opportunities).to include(job_opportunity2)
      end
    end
end 