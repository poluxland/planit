class SubtasksController < ApplicationController
   def new           # GET /restaurants/new
      @subtask = Subtask.new
      @task = Task.find(params[:task_id])
      @trip = Trip.find(params[:trip_id])
      authorize(@subtask)
    end

    def create        # POST /restaurants
      @subtask = Subtask.new(subtask_params)
      @task = Task.find(params[:task_id])
      @trip = Trip.find(params[:trip_id])
      @subtask.task = @task
      @subtask.status = "open"
      authorize(@subtask)
      if @subtask.save
        redirect_to trip_path(@trip)
      else
        render :new
      end
    end

    def edit          # GET /restaurants/:id/edit
      @subtask = Subtask.find(params[:subtask_id])
      authorize(@subtask)
    end

    def update        # PATCH /restaurants/:id
      @subtask = Subtask.find(subtask_params)
      @subtask.update(params[:subtask])
      authorize(@subtask)
    end

    def destroy       # DELETE /restaurants/:id
     @subtask = Subtask.find(params[:id])
     @subtask.destroy
     authorize(@subtask)
   end

   private

   def subtask_params
    params.require(:subtask).permit(:name, :description)
  end
end
