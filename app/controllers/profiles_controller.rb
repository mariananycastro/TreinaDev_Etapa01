class ProfilesController < ApplicationController
    before_action :authenticate_job_seeker!, except: [:show, :search]
    before_action :authenticate_job_seeker_and_headhunter, only: [:show] 
    before_action :authenticate_headhunter!, only: [:search]
    before_action :get_job_seeker, except: [:show, :search]
    before_action :set_profile, only: [:edit, :update]

    def index
    end

    def show 
        if job_seeker_signed_in?
            get_job_seeker
            set_profile
           
        elsif headhunter_signed_in?
            @profile = Profile.find(params[:id])
            @job_seeker = @profile.job_seeker
            @job_opportunities = JobOpportunity.where(headhunter:current_headhunter)
            @subscriptions = Subscription.where(job_seeker:@job_seeker, job_opportunity:@job_opportunities)
       end        
    end

    def new
        @profile = Profile.new
    end

    def create
        @profile = @job_seeker.build_profile(profile_params)
        if @profile.save
            flash[:alert] = 'Perfil criado com sucesso!'
            redirect_to @profile
        else
            flash.now[:alert] = 'Você deve corrigir todos os erros para prosseguir'
            render :new
        end
    end

    def edit
    end

    def update
        if @profile.update(profile_params)
            flash[:alert] = 'Perfil criado com sucesso!'
            redirect_to @profile
        else
            flash.now[:alert] = 'Você deve corrigir todos os erros para prosseguir'
            render :edit
        end
    end

    def search
        @search = Profile.where(
                'name LIKE :q OR nick_name LIKE :q OR day_of_birth LIKE :q OR education_level LIKE :q OR description LIKE :q OR experience LIKE :q
                 OR document LIKE :q',
                    q: "%#{params[:q]}%")
        render :index
    end
    


    private

    def authenticate_job_seeker_and_headhunter
        :authenticate_job_seeker! || :authenticate_headhunter!
    end
        
    def get_job_seeker
        @job_seeker = current_job_seeker
    end

    def set_profile
        @profile = Profile.find_by(job_seeker:@job_seeker)
    end

    def profile_params
        params.require(:profile).permit(:avatar, :name, :document, :nick_name, :day_of_birth, 
                                        :education_level, :description, :experience)
    end

end
