class MinersController < ApplicationController
  skip_before_action :set_miner, :only => [:lease, :post]
  before_action :set_miner, only: [:show, :edit, :update, :destroy]
  
  after_action :change_state, only: [:edit]
  
  helper_method :set
  
  # GET /miners
  # GET /miners.json
  def index
    @miners = Miner.all
  end
  
  def lease
    @miners = Miner.all
  end
  
  # def set
  #   @miner.user = current_user
  # end

  # GET /miners/1
  # GET /miners/1.json
  def show
  end

  # GET /miners/new
  def new
    @miner = Miner.new
    @pools = Pool.all
    unless current_user.admin?
      @pools = @pools.select{|t| t.user == current_user}
    end
  end

  # GET /miners/1/edit
  def edit
    @pools = Pool.all
    unless current_user.admin?
      @pools = @pools.select{|t| t.user == current_user}
    end
  end
  
  # def assign
  #  @pools = Pool.all
  # end

  # POST /miners
  # POST /miners.json
  def create
    @miner = Miner.new(miner_params)
    
#    @something = Pool.find(params[:user_id])
#on the page, define :user_id as current_user.id
#I guess, first, I should just try to display any pools

    respond_to do |format|
      if @miner.save
        format.html { redirect_to @miner, notice: 'Miner was successfully created.' }
        format.json { render :show, status: :created, location: @miner }
      else
        format.html { render :new }
        format.json { render json: @miner.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /miners/1
  # PATCH/PUT /miners/1.json
  def update
    @pools = Pool.all
    unless current_user.admin?
      @pools = @pools.select{|t| t.user == current_user}
    end
    if current_user.admin?
      #do nothing
      @miner.update_attribute(:state, 0)
    else
      @miner.user = current_user
      @miner.update_attribute(:state, 1)
    end
    
    
    
    respond_to do |format|
      if @miner.update(miner_params)
        format.html { redirect_to @miner, notice: 'Miner was successfully updated.' }
        format.json { render :show, status: :ok, location: @miner }
      else
        format.html { render :edit }
        format.json { render json: @miner.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /miners/1
  # DELETE /miners/1.json
  def destroy
    @miner.destroy
    respond_to do |format|
      format.html { redirect_to miners_url, notice: 'Miner was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_miner
      @miner = Miner.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def miner_params
      params.require(:miner).permit(:name, :ip, :state, :pool_id)
    end
    
    def change_state
      @miner = Miner.find(params[:id])
      @miner.state = "1"
    end
end
