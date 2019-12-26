
class ProfileCommentsController < ApplicationController
    before_action :authenticate_headhunter!

    def new
        @profile = Profile.find(params[:profile_id])
        @profile_comment = ProfileComment.new
    end

    def create
        @profile = Profile.find(params[:profile_id])
        @profile_comment = @profile.build_profile_comment(params.require(:profile_comment).permit(:comment))
        @profile_comment.headhunter = current_headhunter
        if @profile_comment.save!
            redirect_to profile_path(@profile)
        end
    end 

    def show
        @profile_comment = ProfileComment.find(params[:id])
        @profile = @profile_comment.profile
        @profile_description = @profile.job_seeker_profile
        @job_opportunity_description = @profile_comment.job_opportunity.description_job_opportunity
    end

    def edit
        @profile_comment = ProfileComment.find(params[:id])
        @profile = @profile_comment.profile
    end 

    def update
        @profile_comment = ProfileComment.find(params[:id])
        @profile = @profile_comment.profile
        @profile_comment.update(params.require(:profile_comment).permit(:comment))
        redirect_to profile_path(@profile)
    end 

    def destroy
        @profile_comment = ProfileComment.find(params[:id])
        @profile = @profile_comment.profile
        @profile_comment.delete    
        redirect_to  profile_path(@profile)
    end




end
