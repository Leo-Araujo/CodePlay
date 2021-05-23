require 'rails_helper'

describe 'Admin registers instructors' do
  it 'Successfuly' do
    visit root_path
    click_on 'Professores'
    click_on 'Registrar um professor'

    fill_in 'Nome', with: 'João Silva'
    fill_in 'Email', with: 'joao@codeplay.com'
    fill_in 'Bio', with: 'Gosto de viajar, visitar as praias de fortaleza'
    attach_file 'Foto do perfil', Rails.root.join('spec/fixtures/profile.jpg')
    click_on 'Registrar professor'

    expect(current_path).to eq(instructor_path(Instructor.last))
    expect(page).to have_content('João Silva')
    expect(page).to have_content('joao@codeplay.com')
    expect(page).to have_content('Gosto de viajar, visitar as praias de fortaleza')
    expect(page).to have_css('img[src*="profile.jpg"]')
  end
end