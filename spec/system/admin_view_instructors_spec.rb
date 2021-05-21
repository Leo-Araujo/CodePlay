require 'rails_helper'

describe 'admin view instructors' do
  it 'successfully' do
    Instructor.create!(name:'Mr.Rails', email:'mister@rails.com',
                        bio: 'Sou um professor de Ruby On Rails')

    visit root_path
    click_on 'Professores'

    expect(page).to have_content('Mr.Rails')
    expect(page).to have_content('mister@rails.com')
    expect(page).to have_content('Sou um professor de Ruby On Rails')
  end
  it 'and view details' do
    Instructor.create!(name:'Sir.Ruby', email:'rubyteach@codeplay.com',
                       bio: 'Formado em engenharia da computação',
                       profile_picture: fixture_file_upload(Rails.root.join('spec/fixtures/profile.jpg')))
    
    visit root_path
    click_on 'Professores'
    click_on 'Sir.Ruby'

    expect(page).to have_content('Sir.Ruby')
    expect(page).to have_content('rubyteach@codeplay.com')
    expect(page).to have_content('Formado em engenharia da computação')
    expect(page).to have_css('img[src*="profile.jpg"]')
  end
end
