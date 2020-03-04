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
     unless @subtask.status
      @subtask.status = true
    else
      @subtask.status = false
    end
    authorize @subtask

    respond_to do |format|

      if params[:ajax].present?
        if @subtask.save
          format.js
        end
      else
        if @subtask.update(subtask_params)
          format.html { redirect_to trip_path(@subtask.task.trip) }
        else
          format.html { redirect_to :edit }
        end
      end
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
