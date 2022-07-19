class User < ApplicationRecord
  has_secure_password

  validates :email, uniqueness: { case_sensitive: false }
  validates :stripe_id, presence: true, uniqueness: true

 before_validation :create_stripe_reference, on: :create
 
  def create_stripe_reference
    response = Stripe::Customer.create(email: email)
    self.stripe_id = response.id
  end

  def retrieve_stripe_reference
    Stripe::Customer.retrieve(stripe_id)
  end
end

