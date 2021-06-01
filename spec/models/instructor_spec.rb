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
    
    it 'deleting Instructor' do
     instructor = Instructor.create(name: 'João Silva', email: 'joao@codeplay.com')

      Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                    code: 'RUBYBASIC', price: 10,
                    enrollment_deadline: '22/12/2033',
                    instructor: instructor)

    expect{ instructor.destroy }.to raise_error(ActiveRecord::DeleteRestrictionError)
    end
  end
end