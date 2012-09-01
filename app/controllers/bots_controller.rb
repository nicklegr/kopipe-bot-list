class BulkNew < ActiveForm
  attr_accessor :bots
end

class BotsController < ApplicationController
  # GET /bots
  # GET /bots.json
  def index
    @bots = Bot.order('followers desc')

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

  # GET /bots/bulk_new
  # GET /bots/bulk_new.json
  def bulk_new
    @bulk_new = BulkNew.new

    respond_to do |format|
      format.html # bulk_new.html.erb
      format.json { render json: @bulk_new }
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

  # POST /bots/bulk_create
  # POST /bots/bulk_create.json
  def bulk_create
    @bulk_new = BulkNew.new(params[:bulk_new])

    respond_to do |format|
      if @bulk_new.valid?
        Bot.transaction do
          @bulk_new.bots.split.each do |e|
            bot = Bot.by_account(e)
            if bot.errors.empty?
              bot.save
            end

            bot.errors.each do |attribute, error|
              @bulk_new.errors.add(attribute, error)
            end
          end

          raise ActiveRecord::Rollback unless @bulk_new.errors.empty?
        end

        if @bulk_new.errors.empty?
          format.html { redirect_to bots_url }
          format.json { rhead :no_content }
        else
          flash[:alert] = @bulk_new.errors.map{|attribute, error| error }.join("<br/>")
          format.html { render action: "bulk_new" }
          format.json { render json: @bulk_new.errors, status: :unprocessable_entity }
        end
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

  def update_by_api
    user_ids = Bot.all.map{|e| e.user_id }

    auth_twitter()
    Twitter.users(user_ids).each do |user|
      bot = Bot.where(user_id: user.id).first
      bot.account = user.screen_name
      bot.followers = user.followers_count
      bot.name = user.name
      bot.save!
    end
  end
end
