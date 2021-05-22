class CoursesController < ApplicationController
  def index
    @courses = Course.all
  end

  def show
    @course = Course.find(params[:id])
  end

  def new
    @course = Course.new
    @instructors = Instructor.all
  end

  def create
    @course = Course.new(course_params)

    if @course.save
      redirect_to @course
    else
      @instructors = Instructor.all
      render :new
    end
  end

  private

  def course_params
    params.require(:course).permit(:name, :description, :code, :price,
                                   :enrollment_deadline, :banner, :instructor_id)
  end
end