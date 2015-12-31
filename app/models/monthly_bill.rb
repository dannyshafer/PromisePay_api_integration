class MonthlyBill < ActiveRecord::Base
  require 'securerandom'
  require 'promisepay'
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence do
    hourly.minute_of_hour(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59)
  end

  def perform
    client = Promisepay::Client.new(username: ENV['PROMISEPAY_USERNAME'], token: ENV['PROMISEPAY_TOKEN'])
    puts "this is the client.inspect "*10
    puts client.inspect
    puts "this is the client.inspect "*10
    item = client.items.create(
      id: SecureRandom.hex,
      name: self.name,
      amount: self.amount,
      payment_type: self.payment_type,
      buyer_id: self.buyer_id,
      seller_id: self.seller_id,
      description: self.description
    )
    puts "this is the class "*10
    puts item.class
    puts "this is the class "*10
    puts "this is the #inspect"*10
    puts item.inspect
    puts "this is the #inspect"*10
  end

end
