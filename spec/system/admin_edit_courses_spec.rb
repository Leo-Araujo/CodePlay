require 'rails_helper'

describe 'Admin update courses' do
  it 'successfuly' do    
    instructor = Instructor.create!(name:'Jane Doe', email: 'jane@codeplay.com',
                                    bio:'Formada em ads, tenho 3 gatos e 2 cachorros')

  course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                          code: 'RUBYBASIC', price: 10,
                          enrollment_deadline: '22/12/2033',
                          instructor: instructor)

  visit course_path(course)
  click_on 'Editar'

  fill_in 'Nome', with: 'Ruby 3.0'
  fill_in 'Preço', with: 20
  click_on 'Editar'

  expect(page).to have_content('Ruby 3.0')
  expect(page).to have_content('R$ 20,00')
  end

  it 'and attributes cannot be blank' do
    instructor = Instructor.create!(name:'Jane Doe', email: 'jane@codeplay.com',
                                    bio:'Formada em ads, tenho 3 gatos e 2 cachorros')

    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: '22/12/2033',
                            instructor: instructor)
                            
    visit course_path(course)
    click_on 'Editar'

    fill_in 'Nome', with: ''
    fill_in 'Código', with: ''
    fill_in 'Preço', with: ''
    click_on 'Editar'

    expect(page).to have_content('não pode ficar em branco', count: 3)
  end

  it 'code must be unique' do
    instructor = Instructor.create!(name:'Jane Doe', email: 'jane@codeplay.com',
                                    bio:'Formada em ads, tenho 3 gatos e 2 cachorros')

    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: '22/12/2033',
                            instructor: instructor)
    Course.create!(name: 'Ruby 3.0', description: 'Um curso de Ruby',
                  code: 'RUBYBASIC3', price: 10,
                  enrollment_deadline: '22/12/2033',
                  instructor: instructor)

    visit course_path(course)
    click_on 'Editar'

    fill_in 'Código', with:'RUBYBASIC3'
    click_on 'Editar'
    
    expect(page).to have_content('já está em uso')
  end
end