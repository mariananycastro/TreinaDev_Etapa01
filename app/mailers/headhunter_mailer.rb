class HeadhunterMailer < ApplicationMailer
    default from: 'teste@teste.com'

    def welcome_email(headhunter, subscription)
        @headhunter = headhunter
        @subscription = subscription
        mail(to: @headhunter.email, subject: 'teste')
    end
end
