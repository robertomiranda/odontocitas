class PrepagadasController < ApplicationController
  # GET /prepagadas
  # GET /prepagadas.json
  def index
    @prepagadas = Prepagada.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @prepagadas }
    end
  end

  # GET /prepagadas/1
  # GET /prepagadas/1.json
  def show
    @prepagada = Prepagada.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @prepagada }
    end
  end

  # GET /prepagadas/new
  # GET /prepagadas/new.json
  def new
    @prepagada = Prepagada.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @prepagada }
    end
  end

  # GET /prepagadas/1/edit
  def edit
    @prepagada = Prepagada.find(params[:id])
  end

  # POST /prepagadas
  # POST /prepagadas.json
  def create

    @prepagada = Prepagada.new({ :prepagada => params[:prepagada], :odontologo_id => params[:odontologo_id] })

    respond_to do |format|
      if @prepagada.save
        format.html { redirect_to @prepagada, notice: 'Prepagada was successfully created.' }
        format.json { render json: @prepagada, status: :created, location: @prepagada }
      else
        format.html { render action: "new" }
        format.json { render json: @prepagada.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /prepagadas/1
  # PUT /prepagadas/1.json
  def update
    @prepagada = Prepagada.find(params[:id])

    respond_to do |format|
      if @prepagada.update_attributes(params[:prepagada])
        format.html { redirect_to @prepagada, notice: 'Prepagada was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @prepagada.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /prepagadas/1
  # DELETE /prepagadas/1.json
  def destroy
    @prepagada = Prepagada.find(params[:id])
    @prepagada.destroy

    respond_to do |format|
      format.html { redirect_to prepagadas_url }
      format.json { head :no_content }
    end
  end
end
