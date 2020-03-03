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
    @task.status = "open"
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
    authorize @task
    if @task.update(task_params)
      redirect_to trip_path(@task.trip)
    else
      render :edit
    end
  end

  def destroy
   @task = Task.find(params[:id])
   authorize @task
   @task.destroy
   redirect_to trip_path(@task.trip)
  end

  private

    params.require(:task).permit(:name, :description, :task_id, :status)

  end

end
