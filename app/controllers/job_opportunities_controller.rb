class JobOpportunitiesController < ApplicationController
    before_action :authenticate_headhunter!, except: [:index, :show, :job_seeker_subscribe, :cancel_subscription]
    before_action :authenticate_headhunter_and_job_seeker, only: [:index, :show, :cancel_subscription]
    before_action :authenticate_job_seeker!, only: [:job_seeker_subscribe]
    before_action :get_headhunter, except: [:job_seeker_subscribe]
    before_action :set_job_opportunity, only: [:edit, :update, :destroy]
    
    def index
        if headhunter_signed_in?
            set_job_opportunities
            @job_opportunities_of_headhunter = @headhunter.job_opportunities
        else
            @all_job_opportunities = JobOpportunity.all
        end
    end

    def new
        @job_opportunity = @headhunter.job_opportunities.build
    end

    def create
        @job_opportunity = @headhunter.job_opportunities.build(job_opportunity_params)
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

        @subscriptions = Subscription.where(job_opportunity:@job_opportunity)

        find_profile
        @job_seeker = current_job_seeker
        @subscription = Subscription.find_by(job_seeker: @job_seeker, job_opportunity: @job_opportunity)
    end

    def edit
    end

    def update
        if @job_opportunity.update(job_opportunity_params)
            flash[:alert] = 'Vaga atualizada com sucesso!'
            redirect_to @job_opportunity
        else
            flash.now[:alert] = 'Você deve corrigir todos os erros para prosseguir'
            render :edit
        end
    end

    def destroy
        @job_opportunity.destroy
        redirect_to headhunter_job_opportunities_path
    end


    

    def job_seeker_subscribe
        find_profile
        if @profile.nil?
            flash[:alert] = 'Você deve preencher seu perfil antes de continuar'
            redirect_to  new_job_seeker_profile_path(current_job_seeker)
        else
            @job_seeker = current_job_seeker
            find_job_opportunity
            if @subscription.nil?
                @subscription = Subscription.new(job_seeker: @job_seeker, job_opportunity: @job_opportunity)
                if @subscription.save
                    flash[:alert] = 'Inscrição realizada com sucesso!'
                    redirect_to job_opportunity_path(@job_opportunity)
                end
            else
                flash[:alert] = 'Inscrição já realizada!'
                redirect_to job_opportunity_path(@job_opportunity)
            end
        end
    end

    def cancel_subscription
        find_profile
        find_job_opportunity
        @job_seeker = current_job_seeker
         @subscription = Subscription.find_by(job_opportunity:@job_opportunity, job_seeker:@job_seeker)
        if @subscription.destroy
            flash[:alert] = 'Inscrição cancelada'
            redirect_to job_opportunity_path(@job_opportunity)
        end
    end
    
    private

    def authenticate_headhunter_and_job_seeker
        :authenticate_headhunter! || :authenticate_job_seeker!
    end

    def get_headhunter
        @headhunter = current_headhunter
    end

    def set_job_opportunities
        @job_opportunities = @headhunter.job_opportunities.where(headhunter:@headhunter)
    end

    def set_job_opportunity
        @job_opportunity = @headhunter.job_opportunities.find_by(headhunter:@headhunter)
    end
   
    def job_opportunity_params
        params.require(:job_opportunity).permit(:name, :description, :habilities, :salary_range, :opportunity_level,
                        :end_date_opportunity, :region)
    end

    def find_job_opportunity
        @job_opportunity = JobOpportunity.find(params[:id])
    end
    
    def find_profile
        @profile = Profile.find_by(job_seeker:current_job_seeker)
    end

 end

