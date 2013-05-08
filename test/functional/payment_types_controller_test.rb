require File.dirname(__FILE__) + '/../test_helper'
require 'payment_types_controller'

# Re-raise errors caught by the controller.
class PaymentTypesController; def rescue_action(e) raise e end; end

class PaymentTypesControllerTest < Test::Unit::TestCase
  fixtures :payment_types

  def setup
    @controller = PaymentTypesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_something
    assert true
  end
  # A better generator might actually keep updated tests in here, until then its probably better to have nothing than something broken

end
