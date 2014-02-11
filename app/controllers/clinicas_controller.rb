class ClinicasController < ApplicationController
  # GET /clinicas
  # GET /clinicas.json
  def index
    @clinicas = Clinica.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @clinicas }
    end
  end

  # GET /clinicas/1
  # GET /clinicas/1.json
  def show
    @clinica = Clinica.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @clinica }
    end
  end

  def mostrar
    @clinica = Clinica.find(params[:id])

    respond_to do |format|
      format.html # mostrar.html.erb
      format.json { render json: @clinica }
    end
  end

  # GET /clinicas/new
  # GET /clinicas/new.json
  def new
    @clinica = Clinica.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @clinica }
    end
  end

  # GET /clinicas/1/edit
  def edit
    @clinica = Clinica.find(params[:id])
  end

  # POST /clinicas
  # POST /clinicas.json
  def create
    @clinica = Clinica.new(params[:clinica])




    respond_to do |format|
      if @clinica.save

        @cxo = Clinicaxodontologo.new(clinica_id: @clinica.id , odontologo_id: 1)
        @cxo.save

        format.html { redirect_to @clinica, notice: 'Clinica was successfully created.' }
        format.json { render json: @clinica, status: :created, location: @clinica }
      else
        format.html { render action: "new" }
        format.json { render json: @clinica.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /clinicas/1
  # PUT /clinicas/1.json
  def update
    @clinica = Clinica.find(params[:id])

    respond_to do |format|
      if @clinica.update_attributes(params[:clinica])
        format.html { redirect_to @clinica, notice: 'Clinica was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @clinica.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clinicas/1
  # DELETE /clinicas/1.json
  def destroy
    @clinica = Clinica.find(params[:id])
    @clinica.destroy

    respond_to do |format|
      format.html { redirect_to clinicas_url }
      format.json { head :no_content }
    end
  end
end
