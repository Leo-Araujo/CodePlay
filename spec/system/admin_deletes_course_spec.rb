require 'rails_helper'

describe 'Admin deletes courses' do
  it 'successfuly' do
    instructor = Instructor.create!(name:'John Doe', email: 'john@codeplay.com', 
                                    bio:'Apaixonado por jogos, professor de design nas horas vagas')
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: '22/12/2033',
                            instructor: instructor)
    
    visit course_path(course)
    click_on 'Apagar'

    expect(Course.count).to be(0)
  end
end