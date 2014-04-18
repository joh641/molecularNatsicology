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
    flash[:notice] = plan.save ? "Plan #{plan.name} successfully created" : "Plan name invalid"
    redirect_to :back
  end

  def add_course
    plan = Plan.find_by_id params[:id]
    if params[:course]
      course = Course.find_by_id params[:course]
    else
      course = Course.find_by_name params[:course_name].upcase
    end
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

  private

  def plans_params
    params.require(:plan).permit(:name)
  end

end
