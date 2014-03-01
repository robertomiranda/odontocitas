class ConsultoriosController < ApplicationController
  # GET /consultorios
  # GET /consultorios.json
  def index
    @consultorios = Consultorio.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @consultorios }
    end
  end

  # GET /consultorios/1
  # GET /consultorios/1.json
  def show
    @consultorio = Consultorio.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @consultorio }
    end
  end

  # GET /consultorios/new
  # GET /consultorios/new.json
  def new
    @consultorio = Consultorio.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @consultorio }
    end
  end

  # GET /consultorios/1/edit
  def edit
    @consultorio = Consultorio.find(params[:id])
  end

  # POST /consultorios
  # POST /consultorios.json
  def create
    @consultorio = Consultorio.new(params[:consultorio])


    id_odontologo = params[:consultorio][:odontologo_id]
    username = params[:username]
    odonto = Odontologo.find(id_odontologo)
    odonto.autorizado = "si"
    odonto.usuario = username
    odonto.save

    respond_to do |format|
      if @consultorio.save
        format.html { redirect_to "/administrador/odontologos" }
        format.json { render json: @consultorio, status: :created, location: @consultorio }
      else
        format.html { render action: "new" }
        format.json { render json: @consultorio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /consultorios/1
  # PUT /consultorios/1.json
  def update
    @consultorio = Consultorio.find(params[:id])

    respond_to do |format|
      if @consultorio.update_attributes(params[:consultorio])
        format.html { redirect_to "/administrador/odontologos" }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @consultorio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /consultorios/1
  # DELETE /consultorios/1.json
  def destroy
    @consultorio = Consultorio.find(params[:id])
    @consultorio.destroy

    respond_to do |format|
      format.html { redirect_to consultorios_url }
      format.json { head :no_content }
    end
  end
end
