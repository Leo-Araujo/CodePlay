require 'rails_helper'

describe 'Account management' do
  context 'registration' do
    it 'with email and password' do
      visit root_path
      click_on 'Registrar-se'

      fill_in 'Email', with: 'jane@codeplay.com'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirmação de Senha', with: '123456'
      click_on 'Registrar'

      expect(page).to have_text('Login efetuado com sucesso')
      expect(page).to have_text('jane@codeplay.com')
      expect(page).to have_link('Cursos')
      expect(page).to_not have_link('Registrar-se')
      expect(page).to have_link('Sair')
    end

    it 'without valid fields' do
      visit root_path
      click_on 'Registrar-se'

      fill_in 'Email', with: 'jane@codeplay.com'
      fill_in 'Senha', with: '1234'
      fill_in 'Confirmação de Senha', with: '1234'
      click_on 'Registrar'

      expect(page).to have_text('Não foi possível salvar usuário(a)')
    end

    it 'unmatch password confirmation' do
      visit root_path
      click_on 'Registrar-se'

      fill_in 'Email', with: 'jane@codeplay.com'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirmação de Senha', with: '12345'
      click_on 'Registrar'

      expect(page).to have_text('Confirmação de Senha não é igual a Senha')
    end

    it 'with email not unique' do
      User.create!(email: 'jane@codeplay.com', password: 123456, password_confirmation: 123456)
      
      visit root_path
      click_on 'Registrar-se'

      fill_in 'Email', with: 'jane@codeplay.com'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirmação de Senha', with: '123456'
      click_on 'Registrar'

      expect(page).to have_text('Email já está em uso')
    end
  end

  context  'sign in' do
    it 'successfuly' do
      user = User.create!(email: 'jane@codeplay.com', password: 123456, password_confirmation: 123456)

      visit root_path
      click_on 'Entrar'

      fill_in 'Email', with: 'jane@codeplay.com'
      fill_in 'Senha', with: '123456'
      within 'form' do
        click_on 'Entrar'
      end

      expect(page).to have_text('Login efetuado com sucesso')
      expect(page).to have_text('jane@codeplay.com')
      expect(page).to_not have_link('Registrar-se')
      expect(page).to have_link('Sair')
    end
  end

  context 'logout' do
    it 'successfuly' do
      user = User.create!(email: 'jane@codeplay.com', password: 123456, password_confirmation: 123456)

      login_as user, scope: :user
      visit root_path
      click_on 'Sair'

      expect(page).to have_text('Saiu com sucesso')
      expect(page).to_not have_text('jane@codeplay.com')
      expect(page).to have_link('Registrar-se')
      expect(page).to_not have_link('Sair')
    end
  end
end