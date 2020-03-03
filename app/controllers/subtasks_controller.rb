class SubtasksController < ApplicationController
   def new           # GET /restaurants/new
      @subtask = Subtask.new
      authorize @subtask
      @task = Task.find(params[:task_id])
      @trip = @task.trip
    end

    def create        # POST /restaurants
      @subtask = Subtask.new(subtask_params)
      @task = Task.find(params[:task_id])
      @trip = @task.trip
      @subtask.task = @task
      @subtask.status = "open"
      authorize @subtask
      if @subtask.save
        redirect_to trip_path(@trip)
      else
        render :new
      end
    end

    def edit          # GET /restaurants/:id/edit
      @subtask = Subtask.find(params[:id])
      authorize @subtask
    end

    def update        # PATCH /restaurants/:id
      @subtask = Subtask.find(params[:id])
      authorize @subtask
      if @subtask.update(subtask_params)
        redirect_to trip_path(@subtask.task.trip)
      else
        render :edit
      end
    end

    def destroy       # DELETE /restaurants/:id
     @subtask = Subtask.find(params[:id])
     authorize @subtask
     @subtask.destroy
     redirect_to trip_path(@subtask.task.trip)
   end

   private

   def subtask_params
    params.require(:subtask).permit(:name, :description, :status)
  end
end
