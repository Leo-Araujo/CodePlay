require 'rails_helper'

describe 'Admin deletes instructors' do
  it 'successfuly' do
    instructor = Instructor.create(name: 'João Silva', email: 'joao@codeplay.com')

    visit instructor_path(instructor)
    click_on 'Apagar'

    expect(page).to_not have_content('João Silva')
    expect(current_path).to eq(instructors_path)
  end

  it 'without delete courses dependents' do
    instructor = Instructor.create(name: 'João Silva', email: 'joao@codeplay.com')

    Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                code: 'RUBYBASIC', price: 10,
                enrollment_deadline: '22/12/2033',
                instructor: instructor)

    visit instructor_path(instructor)
    click_on 'Apagar'

    expect(page).to have_content('Este professor possui cursos')
  end
end