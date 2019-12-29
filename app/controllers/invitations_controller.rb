class InvitationsController < ApplicationController
    before_action :authenticate_headhunter!, except: [:show, :accept_invitation, :reject_invitation]
    before_action :authenticate_job_seeker!, only: [:accept_invitation, :reject_invitation]
    before_action :authenticate_headhunter_and_job_seeker, only: [:show]

    def new
        @subscription = Subscription.find(params[:subscription_id])
        @invitation = Invitation.new
    end

    def create
        @subscription = Subscription.find(params[:subscription_id])
        @invitation = Invitation.new(params.permit(:title, :message))
        @invitation.save
        @subscription.update(hh_answer:@invitation)
        @subscription.save!
        flash[:alert] = 'Proposta enviada com sucesso'
        redirect_to job_opportunity_subscription_invitation_path(@subscription.job_opportunity, @subscription, @invitation)
    end

    def show
        @invitation = Invitation.find(params[:id])
        if job_seeker_signed_in?
            @subscription = Subscription.find(params[:subscription_id])
        end
    end

    def accept_invitation
        @invitation = Invitation.find(params[:id])
        @job_seeker = current_job_seeker
        @invitation.subscription.status = true 
        flash[:alert] = 'Aceite enviado para Headhunter'
        @invitation.subscription.save
        redirect_to job_opportunity_subscription_invitation_path(@invitation.subscription.job_opportunity, @invitation.subscription, @invitation.subscription.hh_answer)
    end

    def reject_invitation
        @invitation = Invitation.find(params[:id])
        @job_seeker = current_job_seeker
        @invitation.subscription.status = false
        flash[:alert] = 'Convite recusado com sucesso'
        @invitation.subscription.save
        redirect_to job_opportunity_subscription_invitation_path(@invitation.subscription.job_opportunity, @invitation.subscription, @invitation.subscription.hh_answer)
    end

    private
    
    def authenticate_headhunter_and_job_seeker
        :authenticate_headhunter! || :authenticate_job_seeker!
    end

end
