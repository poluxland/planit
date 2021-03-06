class SubtasksController < ApplicationController
   def new           # GET /restaurants/new
    @subtask = Subtask.new
    authorize @subtask
    @task = Task.find(params[:task_id])
    @trip = @task.trip
  end

  def create        # POST /restaurants
    @subtask = Subtask.new(subtask_params)
    authorize @subtask
    @task = Task.find(params[:task_id])
    @subtask.task = @task
    @trip = @task.trip
    if @subtask.save!
      respond_to do |format|
        format.js
        format.html { redirect_to trip_path(@trip) }
      end
    else
      respond_to do |format|
        format.js
        format.html { redirect_to :new }
      end
    end
    @task.status = @task.number_of_subtasks_to_do.zero? ? true : false
    @task.save
  end

  def edit
    @subtask = Subtask.find(params[:id])
    @task = @subtask.task
    authorize @subtask
  end

  def update        # PATCH /restaurants/:id
    @subtask = Subtask.find(params[:id])
    @task = @subtask.task

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
    @task.status = @task.number_of_subtasks_to_do.zero? ? true : false
    @task.save
  end

  def destroy       # DELETE /restaurants/:id
    @subtask = Subtask.find(params[:id])
    @task = @subtask.task
    @trip = @task.trip
    authorize @subtask

    if @subtask.destroy
      respond_to do |format|
        format.html { redirect_to trip_path(@subtask.task.trip) }
        format.js
      end
    end
  end

  private

  def subtask_params
    params.require(:subtask).permit(:name, :description, :status)
  end
end
