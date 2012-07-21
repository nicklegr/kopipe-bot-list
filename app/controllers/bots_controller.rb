class BotsController < ApplicationController
  # GET /bots
  # GET /bots.json
  def index
    @bots = Bot.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bots }
    end
  end

  # GET /bots/1
  # GET /bots/1.json
  def show
    @bot = Bot.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bot }
    end
  end

  # GET /bots/new
  # GET /bots/new.json
  def new
    @bot = Bot.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bot }
    end
  end

  # GET /bots/1/edit
  def edit
    @bot = Bot.find(params[:id])
  end

  # POST /bots
  # POST /bots.json
  def create
    @bot = Bot.new(params[:bot])

    respond_to do |format|
      if @bot.save
        format.html { redirect_to @bot, notice: 'Bot was successfully created.' }
        format.json { render json: @bot, status: :created, location: @bot }
      else
        format.html { render action: "new" }
        format.json { render json: @bot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /bots/1
  # PUT /bots/1.json
  def update
    @bot = Bot.find(params[:id])

    respond_to do |format|
      if @bot.update_attributes(params[:bot])
        format.html { redirect_to @bot, notice: 'Bot was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @bot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bots/1
  # DELETE /bots/1.json
  def destroy
    @bot = Bot.find(params[:id])
    @bot.destroy

    respond_to do |format|
      format.html { redirect_to bots_url }
      format.json { head :no_content }
    end
  end
end
