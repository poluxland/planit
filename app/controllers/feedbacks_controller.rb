class FeedbacksController < ApplicationController
  def new
    @feedback = Feedback.new
    authorize @feedback
  end

  def create
    @feedback = Feedback.new(feedback_params)
    @feedback.user = current_user if user_signed_in?

    authorize @feedback
    if @feedback.save
      redirect_to root_path
      flash[:notice] = "Thank you for your feedback!"
    else
      render :new
    end
  end

  def feedback_params
    params.require(:feedback).permit(:message)
  end
end
