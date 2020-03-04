class TasksController < ApplicationController
  def new           # GET /restaurants/new
    @task = Task.new
    @trip = Trip.find(params[:trip_id])
    authorize @task
  end

  def create        # POST /restaurants
    @task = Task.new(task_params)
    @trip = Trip.find(params[:trip_id])
    @task.trip = @trip
    @task.status = false
    authorize @task
    if @task.save
      redirect_to trip_path(@trip)
    else
      render :new
    end
  end

  def edit          # GET /restaurants/:id/edit
    @task = Task.find(params[:id])
    authorize @task
  end

  def update        # PATCH /restaurants/:id
    @task = Task.find(params[:id])
    unless @task.status
      @task.status = true
    else
      @task.status = false
    end
    authorize @task

    respond_to do |format|

      if params[:ajax].present?
        if @task.save
          format.js
        end
      else
        if @task.update(task_params)
          format.html { redirect_to trip_path(@task.trip) }
        else
          format.html { redirect_to :edit }
        end
      end
    end
  end

  def destroy
   @task = Task.find(params[:id])
   authorize @task
   @task.destroy
   redirect_to trip_path(@task.trip)
 end

 def toggle_status(task)
   if task.status
    task.status = false
  else
    task.status = true
  end
end

private

def task_params
  params.require(:task).permit(:name, :description, :status)
end

end
