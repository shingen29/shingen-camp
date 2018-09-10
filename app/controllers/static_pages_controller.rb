class StaticPagesController < ApplicationController
  def home
  end
  def stripe
  end
  def checkout
    require "stripe"
    Stripe.api_key = "sk_test_DC07L0Ysgzk4UpqNUuUNZYPB"
    Stripe::Charge.create(
      amount: 500,
      currency: 'jpy',
      customer: "cus_DZpTcyGFxvYTRe",
      description: "メモ"
    )
  end
end
