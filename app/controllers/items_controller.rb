class ItemsController < ApplicationController
  require 'securerandom'
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
    @items = Item.all
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)
    client = Promisepay::Client.new(username: ENV['PROMISEPAY_USERNAME'], token: ENV['PROMISEPAY_TOKEN'])
    respond_to do |format|
      if @item.save
        item = client.items.create(
          id: SecureRandom.hex,
          name: @item.name,
          amount: @item.amount,
          payment_type: @item.payment_type,
          buyer_id: @item.buyer_id,
          seller_id: @item.seller_id,
          description: @item.description
        )
        payment_account = client.users.find(@item.buyer_id).card_accounts.first
        subscription = MonthlyBill.create(name: @item.name, payment_type: "2", amount: @item.amount, buyer_id: @item.buyer_id, payment_account: payment_account, seller_id: @item.seller_id, description: @item.description)
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def pay
    @item = Item.find_by
    redirect_to items_url
  end

  def monthly_bill(name, amount, payment_type, buyer_id, payment_account, seller_id, description)
    client = Promisepay::Client.new(username: ENV['PROMISEPAY_USERNAME'], token: ENV['PROMISEPAY_TOKEN'])
    item = client.items.new(
      id: SecureRandom.hex,
      name: name,
      amount: amount,
      payment_type: payment_type,
      buyer_id: buyer_id,
      seller_id: seller_id,
      description: description
    )
    if item.save
      item.make_payment(account_id: "a8c31df8-38e5-4d2d-bd72-0107c23f191e")
    else
      puts ":( "*100
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:name, :amount, :buyer_id, :seller_id, :description, :payment_type)
    end
end
