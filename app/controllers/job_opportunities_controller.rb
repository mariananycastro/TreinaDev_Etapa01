class JobOpportunitiesController < ApplicationController
    before_action :authenticate_headhunter!, except: [:index, :show, :subscribe, :subscriptions_by_job_seeker]
    before_action :authenticate_job_seeker_and_headhunter, only: [:index, :show, :subscribe,
                                                                 :subscriptions_by_job_seeker]

    def index
        @job_opportunities = JobOpportunity.all
    end

    def new
        @job_opportunity = JobOpportunity.new
    end

    def create
        @job_opportunity = JobOpportunity.new(job_opportunity_params)
        @job_opportunity.headhunter = current_headhunter
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
        @job_opportunity.headhunter = current_headhunter
        if @job_opportunity.update(job_opportunity_params)
            flash[:alert] = 'Vaga atualizada com sucesso!'
            redirect_to @job_opportunity
        else
            flash.now[:alert] = 'Você deve corrigir todos os erros para prosseguir'
            render :edit
        end
    end

    def destroy
        find_job_opportunity
        @job_opportunity.destroy
        redirect_to job_opportunities_path
    end

    def subscribe
        @job_seeker = current_job_seeker
        @job_opportunity = JobOpportunity.find(params[:id])
        @subscription = Subscription.new(job_seeker: @job_seeker, job_opportunity: @job_opportunity) 
        if @subscription.save!
            flash[:alert] = 'Inscrição realizada com sucesso!'
            redirect_to job_opportunity_path(@job_opportunity)
        end
    end

    def subscriptions_by_job_seeker
        @job_seeker = current_job_seeker
        @subscriptions = Subscription.where(job_seeker:@job_seeker)
    end

    def cancel_subscription
        @job_seeker = current_job_seeker
        @job_opportunity = JobOpportunity.find(params[:id])
        @subscription = Subscription.find(params[@job_opportunity][@job_seeker])
        if @subscription.destroy
            flash[:alert] = 'Inscrição cancelada'
            redirect_to job_opportunity_path(@job_opportunity)
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
    
    def authenticate_job_seeker_and_headhunter
        :authenticate_job_seeker! || :authenticate_headhunter!
    end

end

