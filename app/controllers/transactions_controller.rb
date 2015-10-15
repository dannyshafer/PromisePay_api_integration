class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]

  # GET /transactions
  # GET /transactions.json
  def index
    @transactions = Transaction.all
  end

  # GET /transactions/1
  # GET /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
    client = Promisepay::Client.new(username: ENV['PROMISEPAY_USERNAME'], token: ENV['PROMISEPAY_TOKEN'])
    token = client.tokens.create(:session, {
      #In this instance, Daniel is the "buyer" and Ben is the "seller" as Daniel is sending money to Ben.
      current_user_id: '1',
      item_name: 'Test Item',
      amount: '100',
      seller_lastname: 'Harberts',
      seller_firstname: 'Ben',
      buyer_lastname: 'Shafer',
      buyer_firstname: 'Daniel',
      buyer_country: 'USA',
      seller_country: 'USA',
      seller_email: 'd4n@danielshafer.com',
      buyer_email: 'ben@harberts.com',
      external_item_id: '1',
      external_seller_id: '2',
      external_buyer_id: '1',
      fee_ids: [],
      payment_type_id: 2
    })['token']
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions
  # POST /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to @transaction, notice: 'Transaction was successfully created.' }
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1
  # PATCH/PUT /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to @transaction, notice: 'Transaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to transactions_url, notice: 'Transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
      params[:transaction]
    end
end
