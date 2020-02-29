FactoryBot.define do
  factory :profile do
      name { 'Paulo' }
      nick_name { 'Paulinho' }
      day_of_birth { '1987-02-02' }
      education_level { 'Pos Graduado' }
      description { 'USP' }
      experience { 'Ja trabalhei muito com TI' }
      document { '697.611.110-75' }
      job_seeker_id {:job_seeker}
      avatar_path = Rails.root.join('spec/support/avatar.JPG')
      avatar { fixture_file_upload(avatar_path, 'image/JPG') }

      trait :profile2 do
        name { 'Pedro' }
        nick_name { 'Pedrinho' }
        day_of_birth { '1986-02-02' }
        education_level { 'Graduado' }
        description { 'UEM' }
        experience { 'Ja trabalhei com TI' }
        document { '521.730.870-29' }
      end

      trait :profile3 do
        name { 'Maria' }
        nick_name { 'Mariazinha' }
        day_of_birth { '1990-02-02' }
        education_level { 'Mestrado' }
        description { 'FMU' }
        experience { 'Ja trabalhei com TI' }
        document { '322.305.000-07' }
      end
  end
end

