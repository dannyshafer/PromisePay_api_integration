class TransactionsController < ApplicationController
  require 'securerandom'

  def index
  end

  def new
    auth = {:username => ENV['PROMISEPAY_USERNAME'], :password => ENV['PROMISEPAY_TOKEN']}
    transaction_info = {
      "current_user_id" => "1",
      "payment_type_id" => "3",
      "fee_ids" => "",
      "item_name" => "Scooter",
      "external_item_id" => SecureRandom.hex(7).to_s,
      "amount" => "25000",
      "seller_firstname" => "Becky",
      "seller_lastname" => "McPheeters",
      "seller_email" => "becky@becky.org",
      "seller_country" => "USA",
      "external_seller_id" => "1",
      "buyer_firstname" => "Daniel",
      "buyer_lastname" => "Shafer",
      "buyer_country" => "USA",
      "buyer_email" => "daniel@daniel.com",
      "external_buyer_id" => "2"
    }

    @request_url = ["https://test.api.promisepay.com/request_session_token?current_user_id=", transaction_info["current_user_id"], "&item_name=", transaction_info["item_name"], "&amount=", transaction_info["amount"], "&seller_lastname=", transaction_info["seller_lastname"], "&seller_firstname=", transaction_info["seller_firstname"], "&buyer_lastname=", transaction_info["buyer_lastname"], "&buyer_firstname=", transaction_info["buyer_firstname"], "&seller_email=", transaction_info["seller_email"], "&buyer_email=", transaction_info["buyer_email"], "&external_item_id=", transaction_info["external_item_id"], "&external_seller_id=", transaction_info["external_seller_id"], "&external_buyer_id=", transaction_info["external_buyer_id"], "&payment_type_id=", transaction_info["payment_type_id"], "&buyer_country=", transaction_info["buyer_country"], "&seller_country=", transaction_info["seller_country"], "&fee_ids=", transaction_info["fee_ids"]].join("").to_s

    @session = HTTParty.get(@request_url, :basic_auth => auth)
    @token = @session["token"]
  end

  def create

  end
end
