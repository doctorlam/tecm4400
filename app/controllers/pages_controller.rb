class PagesController < ApplicationController

  def about
  end

  def policies
  end

  def usergrades 
    if user_signed_in? && current_user.admin?
        @usersgrades = User.order(last_name: :asc)
        @assignments = Assignment.all
         @search = User.search(params[:q])
        @search.sorts = 'last_name' if @search.sorts.empty?
         @usergrades = @search.result.paginate(:page => params[:page])


    else
      redirect_to lessons_url, alert: "You don't have permission to do that! Nice try though :)"
    end
  end

  def gradebook
    if user_signed_in?
  	   @submissions = current_user.submissions
        @assignments = Assignment.order(deadline: :asc)      
      @search = Submission.search(params[:q])
       @search.sorts = 'date' if @search.sorts.empty?
  	else 
  	redirect_to lessons_url, alert: "You don't have permission to do that! Nice try though :)"
  end

  end
end