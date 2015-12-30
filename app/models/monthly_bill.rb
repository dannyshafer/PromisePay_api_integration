class MonthlyBill < ActiveRecord::Base
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence do
    hourly.minute_of_hour(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59)
  end

  def perform
    puts "hi from the model "*30
    # Item.monthly_bill(self.name, self.amount, self.payment_type, self.buyer_id, self.seller_id, self.payment_account, self.description)
  end
end
