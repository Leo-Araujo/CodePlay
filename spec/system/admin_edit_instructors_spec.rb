require 'rails_helper'

describe 'Admin update instructors' do
  it 'successfuly' do
   Instructor.create!(name:'Jane Doe', email: 'jane@codeplay.com', 
                      bio:'Formada em ads, tenho 3 gatos e 2 cachorros')

    visit root_path
    click_on 'Professores'
    click_on 'Jane Doe'
    click_on 'Atualizar'

    fill_in 'Nome', with: 'Sra. Jane Doe'
    click_on 'Atualizar'

    expect(page).to have_content('Sra. Jane Doe')
  end
  it 'email must be unique' do
    Instructor.create!(name:'Jane Doe', email: 'jane@codeplay.com', 
    bio:'Formada em ads, tenho 3 gatos e 2 cachorros')

    Instructor.create!(name:'Jane Foster', email: 'jane1@codeplay.com', 
    bio:'expert em física quântica')

    visit root_path
    click_on 'Professores'
    click_on 'Jane Doe'
    click_on 'Atualizar'

    fill_in 'Email', with: 'jane1@codeplay.com'
    click_on 'Atualizar'

    expect(page).to have_content('já está em uso')
  end
end