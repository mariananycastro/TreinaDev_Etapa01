class Api::V1::JobOpportunitiesController < Api::V1::ApiController
    
    def show
        @job_opportunity = JobOpportunity.find(params[:id])
        render json: @job_opportunity
        
        #status 200, como padrao se deu certo
    end

    def index
        @job_opportunities = JobOpportunity.all
        render json: @job_opportunities
    end

end


