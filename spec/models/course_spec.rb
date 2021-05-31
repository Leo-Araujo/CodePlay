require 'rails_helper'

describe Course do
  context 'validation' do
    it 'attributes cannot be blank' do
      course = Course.new

      course.valid?

      expect(course.errors[:name]).to include('não pode ficar em branco')
      expect(course.errors[:code]).to include('não pode ficar em branco')
      expect(course.errors[:price]).to include('não pode ficar em branco')
    end

    it 'code must be uniq' do
      instructor = Instructor.create!(name:'John Doe', email: 'john@codeplay.com', 
                                      bio:'Apaixonado por jogos, professor de design nas horas vagas')

      Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                    code: 'RUBYBASIC', price: 10,
                    enrollment_deadline: '22/12/2033',
                    instructor: instructor)
      course = Course.new(code: 'RUBYBASIC')

      course.valid?

      expect(course.errors[:code]).to include('já está em uso')
    end
  end
  
  context 'When delete course' do
    it 'destroy course and associated lessons' do
      instructor = Instructor.create!(name:'John Doe', email: 'john@codeplay.com', 
                                      bio:'Apaixonado por jogos, professor de design nas horas vagas')
      course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                              code: 'RUBYBASIC', price: 10,
                              enrollment_deadline: '22/12/2033',
                              instructor: instructor)

      course.lessons.create!(name: 'Operadores lógicos', duration: 10,
                            content: 'Aula sobre operadores lógicos')
               
      course.destroy      

      expect(Lesson.count).to be(0)
      expect(Course.count).to be(0)
    end
  end
end
