require 'plaid'

Plaid.config do |plaid|
    plaid.customer_id = '56a41f9aa4ce3935462bb66d'
    plaid.secret = '381497ea8538b7b505181976e6b2d2'
    plaid.environment_location = 'https://tartan.plaid.com/'
end

class PlaidUser
  include Plaid

  def initialize(type, user_name, password, institution)
    @type = type
    @user_name = user_name
    @password = password
    @institution = institution
    @customer_id = Plaid.customer_id
    @secret = Plaid.secret
    @environment_location = Plaid.environment_location
    @user = Plaid.add_user(type, user_name, password, institution)
  end

end
