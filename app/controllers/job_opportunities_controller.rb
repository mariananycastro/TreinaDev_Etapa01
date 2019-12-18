class JobOpportunitiesController < ApplicationController
    before_action :authenticate_headhunter!

    def index
        @job_opportunities = JobOpportunity.all
    end

    def new
        @job_opportunity = JobOpportunity.new
    end

    def create
        @job_opportunity = JobOpportunity.new(job_opportunity_params)
        if @job_opportunity.save
            flash[:alert] = 'Vaga criada com sucesso!'
            redirect_to @job_opportunity 
        else
            flash.now[:alert] = 'Você deve corrigir todos os erros para prosseguir'
            render :new
        end
    end

    def show
        find_job_opportunity
    end

    def edit
        find_job_opportunity
    end

    def update
        find_job_opportunity
        if @job_opportunity.update(job_opportunity_params)
            flash[:alert] = 'Vaga atualizada com sucesso!'
            redirect_to @job_opportunity
        else
            flash.now[:alert] = 'Você deve corrigir todos os erros para prosseguir'
            render :edit
        end
    end
    
    private

    def job_opportunity_params
        params.require(:job_opportunity).permit(:name, :description, :habilities, :salary_range, :opportunity_level,
                        :end_date_opportunity, :region)
    end

    def find_job_opportunity
        @job_opportunity = JobOpportunity.find(params[:id])
    end
end
