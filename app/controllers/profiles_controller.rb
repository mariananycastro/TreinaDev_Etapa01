class ProfilesController < ApplicationController
    before_action :authenticate_job_seeker!, except: [:show]
    before_action :authenticate_job_seeker_and_headhunter, only: [:show]
    before_action :get_job_seeker
    before_action :set_profile, only: [:show,:edit, :update]

    def show 
    end

    def new
        @profile = @job_seeker.build_profile
    end

    def create
        if @profile.nil?
            @profile = @job_seeker.build_profile(profile_params)
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
        params.require(:profile).permit(:name, :document, :nick_name, :day_of_birth, 
                                        :education_level, :description, :experience)
    end

    def find_profile
        @profile = Profile.find(params[:id])
    end

end
