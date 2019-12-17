class Profile < ApplicationRecord
    validates :name, presence: {message: 'Nome não pode ficar vazio'}, case_sensitive: false
    validates :document, presence: {message: 'CPF não pode ficar vazio'}, uniqueness: {message: 'CPF já cadastrado'}
    validates :nick_name, presence: {message: 'Apelido não pode ficar vazio'}
    validates :day_of_birth, presence: {message: 'Data de nascimento não pode ficar vazio'}
    validates :education_level, presence: {message: 'Escolaridade não pode ficar vazio'}
    validates :description, presence: {message: 'Descrição não pode ficar vazio'}
    validates :experience, presence: {message: 'Experiencia não pode ficar vazio'}

end
