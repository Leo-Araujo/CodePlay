class LessonsController < ApplicationController
  before_action :set_course, only: %i[new create show edit update destroy]
  before_action :set_lesson, only: %i[show edit update destroy]

  def new
    @lesson = Lesson.new
  end

  def create
    @lesson = @course.lessons.new(lesson_params)

    if @lesson.save
      redirect_to @course
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @lesson.update(lesson_params)
      redirect_to course_lesson_path(@lesson)
    else
      render :edit
    end
  end

  def destroy
    @lesson.destroy
    redirect_to course_path(@course)
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end

  def set_lesson
    @lesson = Lesson.find(params[:id])
  end

  def lesson_params
    params.require(:lesson).permit(:name, :duration, :content)
  end
end