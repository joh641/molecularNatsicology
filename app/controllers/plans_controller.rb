class PlansController < ApplicationController
  respond_to :html, :json
  before_filter :signed_in
  before_filter :is_owner, :only => [:show, :add_course, :remove_course]
  
  def index
    @plans = current_user.plans
  end

  def show
    @plan = Plan.find_by_id params[:id]
  end

  def create
    plan = Plan.new
    plan.name = params[:plan_name]
    plan.user = current_user
    plan.save
    redirect_to :back, notice: "Plan #{plan.name} successfully created"
  end

  def add_course
    plan = Plan.find_by_id params[:id]
    course = Course.find_by_name params[:course_name].upcase
    if course
      plan.add course 
      flash[:notice] = "Course #{course.name} successfully added"
    else
      flash[:warning] = "Could not find course"
    end
    redirect_to :back
  end

  def remove_course
    plan = Plan.find_by_id params[:id]
    course = Course.find_by_name params[:course_name]
    plan.remove course if course
    redirect_to :back, notice: "Course #{course.name} successfully removed"
  end

  protected

  def is_owner
    plan = Plan.find_by_id params[:id]
    if current_user != plan.user
      flash[:error] = "Error: You do not have permission to access"
      redirect_to root_path
      return
    end
    return true
  end

end
