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
        @invitation = Invitation.new(params.permit(:title, :message, :initial_date, :salary, :position, :expectations, :bonus, :benefits))
        @invitation.save
        @subscription.update(hh_answer:@invitation)
        @subscription.save!
        flash[:alert] = 'Proposta enviada com sucesso'
        redirect_to job_opportunity_subscription_invitation_path(@subscription.job_opportunity, @subscription, @invitation)
    end

    def show
        @invitation = Invitation.find(params[:id])
        @subscription = Subscription.find(params[:subscription_id])
    end

    def accept_invitation
        @invitation = Invitation.find(params[:id])
        @subscription = Subscription.find(params[:subscription_id])
        @job_seeker = current_job_seeker
        @subscription.status = true 
        flash[:alert] = 'Aceite enviado para Headhunter'
        @subscription.save
        redirect_to job_opportunity_subscription_invitation_path(@subscription.job_opportunity, @subscription, @subscription.hh_answer)
    end

    def reject_invitation
        @invitation = Invitation.find(params[:id])
        @subscription = Subscription.find(params[:subscription_id])
        @job_seeker = current_job_seeker
        @subscription.status = false
        flash[:alert] = 'Convite recusado com sucesso'
        @subscription.save
        redirect_to job_opportunity_subscription_invitation_path(@subscription.job_opportunity, @subscription, @subscription.hh_answer)
    end

    private
    
    def authenticate_headhunter_and_job_seeker
        :authenticate_headhunter! || :authenticate_job_seeker!
    end

end
