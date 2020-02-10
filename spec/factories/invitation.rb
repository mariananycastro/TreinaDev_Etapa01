FactoryBot.define do

    factory :invitation do

        title {'Passou'}
        message {'Vamos agendar uma entrevista.'}
        initial_date {'02/03/2021'}
        salary {5000}
        position {'Especialista'}
        expectations {'Trabalhar bem'}
        bonus {'PLR'}
        benefits {'VR, VT'}
    end
end