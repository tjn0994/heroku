class LessonsController < ApplicationController
  before_action :logged_in_user, only: [:index, :show]

  def index
    @lessons = Lesson.filter_course params[:id]
  end

  def show
    @lesson = Lesson.find_by_id params[:id]
  end
end
