require 'rails_helper'

describe 'Admin view lessons' do
  it 'of a course' do
    instructor = Instructor.create!(name:'John Doe', email: 'john@codeplay.com',
                                    bio:'Apaixonado por jogos, professor de design nas horas vagas')

    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            instructor: instructor,
                            enrollment_deadline: '22/12/2033')

    Lesson.create!(name: 'Introdução ao MVC', duration: 20,
                   content: 'Aprenderemos nesta aula sobre arquitetura mvc', course: course)
    Lesson.create!(name: 'Criando o primeiro model', duration: 20,
                   content: 'Aprenderemos nesta aula a criar um model', course: course)

   visit course_path(course)

   expect(page).to have_link('Introdução ao MVC')
   expect(page).to have_text('20 minutos')
  end
  
  it 'and does not have lessons' do
    instructor = Instructor.create!(name:'John Doe', email: 'john@codeplay.com',
                                    bio:'Apaixonado por jogos, professor de design nas horas vagas')

    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            instructor: instructor,
                            enrollment_deadline: '22/12/2033')

    visit course_path(course)

    expect(page).to have_text('Não há aulas cadastradas para este curso')
  end

  it 'and have content' do
    instructor = Instructor.create!(name:'John Doe', email: 'john@codeplay.com',
                                    bio:'Apaixonado por jogos, professor de design nas horas vagas')

    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            instructor: instructor,
                            enrollment_deadline: '22/12/2033')

    Lesson.create!(name: 'Introdução ao MVC', duration: 20,
                   content: 'Aprenderemos nesta aula sobre arquitetura mvc', course: course)

    visit course_path(course)
    click_on 'Introdução ao MVC'

    expect(page).to have_content('Introdução ao MVC')
    expect(page).to have_content('20 minutos')
    expect(page).to have_content('Aprenderemos nesta aula sobre arquitetura mvc')
  end
  
  it 'and do not have duration' do
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

    expect(page).to have_content('duração não definida')
  end

  it 'and delete one lesson' do
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
    click_on 'Remover aula'

    expect(page).to_not have_content('Introdução ao MVC')
  end
end