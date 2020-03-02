class TasksController < ApplicationController
    def new           # GET /restaurants/new
      @task = Task.new
      authorize @task
    end

    def create        # POST /restaurants
      @task = Task.new(task_params)
      @task = Trip.find(params[:trip_id])
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
      @task = Task.find(params[:task_id])
      authorize @task
    end

    def update        # PATCH /restaurants/:id
      @task = Task.find(task_params)
      @task.update(params[:task])
      authorize @task
    end

    def destroy       # DELETE /restaurants/:id
     @task = Task.find(params[:id])
     @task.destroy
     authorize @task
   end

   private

   def task_params
    params.require(:task).permit(:name, :description)
  end

end
