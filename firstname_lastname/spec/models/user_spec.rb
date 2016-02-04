require 'rails_helper'
require 'byebug'

RSpec.describe "User", :type => :model do
  describe "password encryption" do
    it "does not save passwords to the database" do
      User.create!(username: "jack_bruce", password: "abcdef")
      user = User.find_by_username("jack_bruce")
      expect(user.attributes.values).not_to include("abcdef")
    end

    it "encrypts the password using BCrypt" do
      expect(BCrypt::Password).to receive(:create)
      User.new(username: "jack_bruce", password: "abcdef")
    end
  end

  let!(:jill_bruce) do
    User.create!({username: "jill_bruce", password: "unicorn"})
  end

  describe "#is_password?" do

    it "should return true for the correct password" do
      expect(jill_bruce.is_password?('unicorn')).to be true
    end


    it "should return false for incorrect passwords" do
      expect(jill_bruce.is_password?('potatofish')).to be false
    end
  end

  describe "#reset_token!" do

    it "should assign a new session token" do
      initial_session_token = jill_bruce.session_token
      jill_bruce.reset_token!

      jill_bruce.reload

      expect(jill_bruce.session_token).not_to eq initial_session_token
    end
  end

end
