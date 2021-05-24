require 'rails_helper'

describe Instructor do
  context 'validation' do
    it 'attributes cannot be blank' do
      instructor = Instructor.new

      instructor.valid?

      expect(instructor.errors[:name]).to include('não pode ficar em branco')
      expect(instructor.errors[:email]).to include('não pode ficar em branco')
    end
    it 'email must be unique' do
      Instructor.create(name: 'João Silva', email: 'joao@codeplay.com')

      instructor = Instructor.new(name: 'João Souza', email: 'joao@codeplay.com')

      instructor.valid?

      expect(instructor.errors[:email]).to include('já está em uso')
    end
  end
end