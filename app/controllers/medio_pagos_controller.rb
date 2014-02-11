class MedioPagosController < ApplicationController
  # GET /medio_pagos
  # GET /medio_pagos.json
  def index
    @medio_pagos = MedioPago.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @medio_pagos }
    end
  end

  # GET /medio_pagos/1
  # GET /medio_pagos/1.json
  def show
    @medio_pago = MedioPago.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @medio_pago }
    end
  end

  # GET /medio_pagos/new
  # GET /medio_pagos/new.json
  def new
    @medio_pago = MedioPago.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @medio_pago }
    end
  end

  # GET /medio_pagos/1/edit
  def edit
    @medio_pago = MedioPago.find(params[:id])
  end

  # POST /medio_pagos
  # POST /medio_pagos.json
  def create
    @medio_pago = MedioPago.new({ :medio_pago => params[:medio_pago], :odontologo_id => params[:odontologo_id] })
    #@medio_pago = MedioPago.new(params[:medio_pago])

    respond_to do |format|
      if @medio_pago.save
        format.html { redirect_to @medio_pago, notice: 'Medio pago was successfully created.' }
        format.json { render json: @medio_pago, status: :created, location: @medio_pago }
      else
        format.html { render action: "new" }
        format.json { render json: @medio_pago.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /medio_pagos/1
  # PUT /medio_pagos/1.json
  def update
    @medio_pago = MedioPago.find(params[:id])

    respond_to do |format|
      if @medio_pago.update_attributes(params[:medio_pago])
        format.html { redirect_to @medio_pago, notice: 'Medio pago was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @medio_pago.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /medio_pagos/1
  # DELETE /medio_pagos/1.json
  def destroy
    @medio_pago = MedioPago.find(params[:id])
    @medio_pago.destroy

    respond_to do |format|
      format.html { redirect_to medio_pagos_url }
      format.json { head :no_content }
    end
  end
end
