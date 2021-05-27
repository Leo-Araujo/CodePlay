require 'rails_helper'

describe 'Admin update lessons' do
  it 'successfuly' do
    instructor = Instructor.create!(name:'John Doe', email: 'john@codeplay.com',
                                    bio:'Apaixonado por jogos, professor de design nas horas vagas')

    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            instructor: instructor,
                            enrollment_deadline: '22/12/2033')

    Lesson.create!(name: 'Introdução ao MVC',
                  content: 'Aprenderemos nesta aula sobre arquitetura mvc', course: course)

    visit course_path(course)
    click_on 'Introdução ao MVC'
    click_on 'Atualizar aula'

    fill_in 'Nome', with: 'Ruby 2.6'
    fill_in 'Duração', with: 20
    click_on 'Atualizar'

    expect(page).to have_content('Ruby 2.6')
    expect(page).to have_content('20 minutos')
  end

  it 'and name cannot be blank' do
    instructor = Instructor.create!(name:'John Doe', email: 'john@codeplay.com',
                                    bio:'Apaixonado por jogos, professor de design nas horas vagas')

    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            instructor: instructor,
                            enrollment_deadline: '22/12/2033')

    Lesson.create!(name: 'Introdução ao MVC',
                  content: 'Aprenderemos nesta aula sobre arquitetura mvc', course: course)

    visit course_path(course)
    click_on 'Introdução ao MVC'
    click_on 'Atualizar aula'
    
    fill_in 'Nome', with: ''
    click_on 'Atualizar'

    expect(page).to have_content('não pode ficar em branco')
  end
end