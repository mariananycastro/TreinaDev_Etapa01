class ProfilesController < ApplicationController
    before_action :authenticate_job_seeker!, except: [:show]
    before_action :authenticate_job_seeker_and_headhunter, only: [:show]

    def index
    end

    def new
        @profile = Profile.new
    end

    def create
        if @profile.nil?
            @profile = Profile.new(profile_params)
            @profile.job_seeker = current_job_seeker
            if @profile.save
                flash[:alert] = 'Perfil criado com sucesso!'
                redirect_to @profile
            else
                flash.now[:alert] = 'Você deve corrigir todos os erros para prosseguir'
                render :new
            end
        else
            flash[:alert] = 'Perfil já cadastrado!'
            redirect_to @profile
        end
    end

    def show
        find_profile
        @job_seeker = JobSeeker.find_by(profile:@profile)
        @job_opportunities = JobOpportunity.where(headhunter:current_headhunter) 
        @subscriptions = Subscription.where(job_seeker:@job_seeker, job_opportunity:@job_opportunities)  
    end

    def edit
        find_profile
    end

    def update
        find_profile
        @profile.job_seeker = current_job_seeker
        if @profile.update(profile_params)
            flash[:alert] = 'Perfil criado com sucesso!'
            redirect_to @profile
        else
            flash.now[:alert] = 'Você deve corrigir todos os erros para prosseguir'
            render :edit
        end
    end

    private

    def authenticate_job_seeker_and_headhunter
        :authenticate_job_seeker! || :authenticate_headhunter!
    end

    def profile_params
        params.require(:profile).permit(:name, :document, :nick_name, :day_of_birth, 
                                        :education_level, :description, :experience)
    end

    def find_profile
        @profile = Profile.find(params[:id])
    end

end
