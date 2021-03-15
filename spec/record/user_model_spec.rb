require "rails_helper"

RSpec.describe User, type: :model do
  describe User do
    it do
        should have_many(:microposts)
    end
  end
end

# Test using Shoulda Context
# require 'test_helper'

# class PersonTest < ActiveSupport::TestCase
#   should have_many(:acquaintances).
#     through(:friends).
#     class_name('Person')
# end
