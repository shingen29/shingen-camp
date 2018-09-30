require "stripe"

class StaticPagesController < ApplicationController
  def home
  end
  def stripe
  end
  def checkout
    Stripe.api_key = "sk_test_DC07L0Ysgzk4UpqNUuUNZYPB"

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source => params[:stripeToken]
    )

    Stripe::Charge.create(
      :amount => 500,
      :currency => 'jpy',
      :customer => customer.id,
      :description => "JP_Stripesデモ用"
    )
  end
end
