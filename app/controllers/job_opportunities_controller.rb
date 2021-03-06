class JobOpportunitiesController < ApplicationController
    before_action :authenticate_headhunter!, except: [:index, :show, :job_seeker_subscribe, :cancel_subscription, :search, :accept_invitation, :reject_invitation]
    before_action :authenticate_headhunter_and_job_seeker, only: [:index, :show, :cancel_subscription, :search]
    before_action :authenticate_job_seeker!, only: [:job_seeker_subscribe, :accept_invitation, :reject_invitation]
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
        if job_seeker_signed_in?
            find_profile
            @subscription = Subscription.find_by(job_seeker: current_job_seeker, job_opportunity: @job_opportunity)
        end
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
                    
                    @headhunter = @job_opportunity.headhunter                
                    HeadhunterMailer.welcome_email(@headhunter, @subscription).deliver_later

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

    def search
        if headhunter_signed_in?
            @headhunter = current_headhunter
            
            @search_hh_job_opportunities = @headhunter.job_opportunities.where('name LIKE :q 
                OR description LIKE :q 
                OR habilities LIKE :q 
                OR salary_range LIKE :q 
                OR region LIKE :q
                OR end_date_opportunity LIKE :q', q: "%#{params[:q]}%")
                               
            @job_opportunities_of_headhunter = @headhunter.job_opportunities
        end

        if job_seeker_signed_in?
            levels = JobOpportunity.opportunity_levels
            levels = levels.select {|key, value| key.include? params[:q]}
            s = levels.values
            
            @search_job_opportunities = JobOpportunity.where('name LIKE :q 
                OR description LIKE :q 
                OR habilities LIKE :q 
                OR salary_range LIKE :q 
                OR region LIKE :q', q: "%#{params[:q]}%")
                .where('end_date_opportunity >= ?', Date.today)

            @all_job_opportunities = JobOpportunity.all
        end
        render :index
    end

    def end_job_opportunity
        @job_opportunity = JobOpportunity.find(params[:id])
        @subscriptions = Subscription.where(job_opportunity:@job_opportunity)
        @subscriptions.each do |subscription|
            if subscription.hh_answer.nil?
                create_feedback(subscription)
            end    
        end
        @job_opportunity.status = false
        @job_opportunity.save!
        flash[:alert] = 'Vaga encerrada com sucesso'
        
        redirect_to @job_opportunity
    end

    def advanced_search
        find_job_opportunity
        @search_result = @job_opportunity.subscriptions
                .includes(job_seeker: [:profile])
                .where('education_level LIKE :education_level 
                    AND description LIKE :description
                    AND experience LIKE :experience', 
                    education_level: "%#{params[:education_level]}%",
                    description: "%#{params[:description]}%",
                    experience: "%#{params[:experience]}%")
                .references(:job_seekers, :profiles)
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

    def create_feedback(subscription)
        feedback = Feedback.new(title:"Feedback para vaga #{subscription.job_opportunity.name} #{subscription.job_opportunity.opportunity_level}"\
            " #{subscription.job_opportunity.end_date_opportunity} #{subscription.job_opportunity.region}", message: 'Vaga encerrada. Obrigada pela participação')
        feedback.save
        subscription.update(hh_answer:feedback)
        subscription.save!
    end
 end

