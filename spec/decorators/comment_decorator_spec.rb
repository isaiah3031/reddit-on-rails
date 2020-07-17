require 'rails_helper'

require './test/test_helpers/creation_helpers.rb'
require './test/test_helpers/user_auth.rb'
RSpec.describe CommentDecorator do
  include CreationHelpers
  include SignInHelper

end
