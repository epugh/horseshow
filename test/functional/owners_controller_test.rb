require File.dirname(__FILE__) + '/../test_helper'
require 'owners_controller'

# Re-raise errors caught by the controller.
class OwnersController; def rescue_action(e) raise e end; end

class OwnersControllerTest < Test::Unit::TestCase
  fixtures :owners

  def setup
    @controller = OwnersController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end
  
  def test_something
    assert true
  end
  # A better generator might actually keep updated tests in here, until then its probably better to have nothing than something broken

end
