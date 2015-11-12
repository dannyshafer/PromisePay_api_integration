class TransactionsController < ApplicationController
  def index
    return "nothing to see here"
  end

  def new
    auth = {:username => ENV['PROMISEPAY_USERNAME'], :password => ENV['PROMISEPAY_TOKEN']}
    @session = HTTParty.get("https://test.api.promisepay.com/request_session_token?current_user_id=1&item_name=Sample+Item&amount=25000&seller_lastname=Seller&seller_firstname=Sally&buyer_lastname=Buyer&buyer_firstname=Bobby&seller_email=sally.seller@promisepay.com&buyer_email=bobby.buyer@promisepay.com&external_item_id=1&external_seller_id=1&external_buyer_id=2&payment_type_id=1&buyer_country=USA&seller_country=USA&fee_ids=", :basic_auth => auth)
    @token = @session["token"]
  end

  def create

  end
end
