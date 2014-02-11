class ConsultaController < ApplicationController
  # GET /consulta
  # GET /consulta.json
  def index
    @consulta = Consultum.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @consulta }
    end
  end

  # GET /consulta/1
  # GET /consulta/1.json
  def show
    @consultum = Consultum.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @consultum }
    end
  end

  # GET /consulta/new
  # GET /consulta/new.json
  def new
    @consultum = Consultum.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @consultum }
    end
  end

  # GET /consulta/1/edit
  def edit
    @consultum = Consultum.find(params[:id])
  end

  # POST /consulta
  # POST /consulta.json
  def create
    @consultum = Consultum.new(params[:consultum])

    respond_to do |format|
      if @consultum.save
        format.html { redirect_to @consultum, notice: 'Consultum was successfully created.' }
        format.json { render json: @consultum, status: :created, location: @consultum }
      else
        format.html { render action: "new" }
        format.json { render json: @consultum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /consulta/1
  # PUT /consulta/1.json
  def update
    @consultum = Consultum.find(params[:id])

    respond_to do |format|
      if @consultum.update_attributes(params[:consultum])
        format.html { redirect_to @consultum, notice: 'Consultum was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @consultum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /consulta/1
  # DELETE /consulta/1.json
  def destroy
    @consultum = Consultum.find(params[:id])
    @consultum.destroy

    respond_to do |format|
      format.html { redirect_to consulta_url }
      format.json { head :no_content }
    end
  end
end
