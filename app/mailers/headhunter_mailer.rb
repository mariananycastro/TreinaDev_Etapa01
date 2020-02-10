class HeadhunterMailer < ApplicationMailer
    default from: 'teste@teste.com'

    def welcome_email(headhunter, job_opportunity, job_seeker)
        @headhunter = headhunter
        mail(to: @headhunter.email, subject: 'teste')
        @job_opportunity = job_opportunity
        @job_seeker = job_seeker
    end
end
