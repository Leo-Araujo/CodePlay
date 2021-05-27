require 'rails_helper'

describe Lesson do
  context 'validation' do
    it 'name cannot be blank' do
      lesson = Lesson.new

      lesson.valid?

      expect(lesson.errors[:name]).to include('não pode ficar em branco')
    end
  end
end
