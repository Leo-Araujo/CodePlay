require 'rails_helper'

describe 'Admin registers lessons' do
  it 'successfuly' do
    instructor = Instructor.create!(name:'John Doe', email: 'john@codeplay.com',
                                    bio:'Apaixonado por jogos, professor de design nas horas vagas')

    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            instructor: instructor,
                            enrollment_deadline: '22/12/2033')
    
    visit course_path(course)
    click_on 'Registrar uma aula'
    fill_in 'Nome', with: 'Iniciando com ruby'
    fill_in 'Duração', with: 20
    fill_in 'Conteúdo', with: 'Nesta aula falaremos sobre a história do Ruby'
    click_on 'Cadastrar aula'

    expect(page).to have_text('Iniciando com ruby')
    expect(page).to have_text('20 minutos')
  end
  it 'and name cannot be blank' do

    instructor = Instructor.create!(name:'John Doe', email: 'john@codeplay.com',
                                    bio:'Apaixonado por jogos, professor de design nas horas vagas')

    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            instructor: instructor,
                            enrollment_deadline: '22/12/2033')
    
    visit new_course_lesson_path(course)
    click_on 'Cadastrar aula'

    expect(page).to have_content('não pode ficar em branco')
  end
end