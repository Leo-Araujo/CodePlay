require 'rails_helper'

describe 'Admin view courses' do
  it 'successfully' do
    instructor = Instructor.create!(name:'Jane Doe', email: 'jane@codeplay.com',
                                    bio:'Formada em ads, tenho 3 gatos e 2 cachorros')

    Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   enrollment_deadline: '22/12/2033',
                   instructor: instructor)
    Course.create!(name: 'Ruby on Rails',
                   description: 'Um curso de Ruby on Rails',
                   code: 'RUBYONRAILS', price: 20,
                   enrollment_deadline: '20/12/2033',
                   instructor: instructor)

    visit root_path
    click_on 'Cursos'

    expect(page).to have_content('Ruby')
    expect(page).to have_content('Um curso de Ruby')
    expect(page).to have_content('R$ 10,00')
    expect(page).to have_content('Ruby on Rails')
    expect(page).to have_content('Um curso de Ruby on Rails')
    expect(page).to have_content('R$ 20,00')
  end

  it 'and view details' do
    instructor = Instructor.create!(name:'John Doe', email: 'john@codeplay.com',
                                    bio:'Apaixonado por jogos, professor de design nas horas vagas')

    Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   instructor: instructor,
                   enrollment_deadline: '22/12/2033')
    Course.create!(name: 'Ruby on Rails',
                   description: 'Um curso de Ruby on Rails',
                   code: 'RUBYONRAILS', price: 20,
                   instructor: instructor,
                   enrollment_deadline: '20/12/2033',
                   banner: fixture_file_upload(Rails.root.join('spec/fixtures/course.jpg')))

    visit root_path
    click_on 'Cursos'
    click_on 'Ruby on Rails'

    expect(page).to have_content('Ruby on Rails')
    expect(page).to have_content('Um curso de Ruby on Rails')
    expect(page).to have_content('RUBYONRAILS')
    expect(page).to have_content('R$ 20,00')
    expect(page).to have_content('20/12/2033')
    expect(page).to have_content('John Doe')
    expect(page).to have_css('img[src*="course.jpg"]')
  end

  it 'and no course is available' do
    visit root_path
    click_on 'Cursos'

    expect(page).to have_content('Nenhum curso disponível')
  end

  it 'and return to home page' do
    instructor = Instructor.create!(name:'John Doe', email: 'john@codeplay.com', 
                                    bio:'Apaixonado por jogos, professor de design nas horas vagas')

    Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   enrollment_deadline: '22/12/2033',
                   instructor: instructor)

    visit root_path
    click_on 'Cursos'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  it 'and return to promotions page' do
    instructor = Instructor.create!(name:'John Doe', email: 'john@codeplay.com', 
                                    bio:'Apaixonado por jogos, professor de design nas horas vagas')

    Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   enrollment_deadline: '22/12/2033',
                   instructor: instructor)

    visit root_path
    click_on 'Cursos'
    click_on 'Ruby'
    click_on 'Voltar'

    expect(current_path).to eq courses_path
  end
end