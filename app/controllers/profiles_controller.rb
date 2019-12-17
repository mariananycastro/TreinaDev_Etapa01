class ProfilesController < ApplicationController
    before_action :authenticate_job_seeker!

    def index
    end

    def new
        @profile = Profile.new
    end

    def create
        @profile = Profile.new(profile_params)
        if @profile.save
            flash[:alert] = 'Perfil criado com sucesso!'
            redirect_to @profile
        else
            flash.now[:alert] = 'Você deve corrigir todos os erros para prosseguir'
            render :new
        end
    end

    def show
        find_profile
    end

    def edit
        find_profile
    end

    def update
        find_profile
        if @profile.update(profile_params)
            flash[:alert] = 'Perfil criado com sucesso!'
            redirect_to @profile
        else
            flash.now[:alert] = 'Você deve corrigir todos os erros para prosseguir'
            render :edit
        end
    end

    private

    def profile_params
        params.require(:profile).permit(:job_seeker,:name, :document, :nick_name, :day_of_birth, 
                                        :education_level, :description, :experience)
    end

    def find_profile
        @profile = Profile.find(params[:id])
    end

end
