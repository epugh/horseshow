require "selenium"
require "test/unit"

class CreatingOwner < Test::Unit::TestCase
  def setup
    @verification_errors = []
    if $selenium
      @selenium = $selenium
    else
      @selenium = Selenium::SeleneseInterpreter.new("localhost", 4444, "*firefox", "http://localhost:4444", 10000);
      @selenium.start
    end
    @selenium.set_context("test_creating_owner", "info")
  end
  
  def teardown
    @selenium.stop unless $selenium
    assert_equal [], @verification_errors
  end
  
  def test_creating_owner
    unique = @selenium.get_eval("Math.floor(Math.random()*100000)")
    owner_name = "BobbyBrown"
    owner_name = owner_name + "-" + unique
    @selenium.open "/"
    assert_equal "Horse Show Registration", @selenium.get_title
    @selenium.click "link=Create New"
    assert !60.times{ break if (@selenium.is_text_present("Create Owner") rescue false); sleep 1 }
    @selenium.type "owner_name", owner_name
    @selenium.type "owner_street1", "10 Maple Street"
    @selenium.type "owner_city", "Smallville"
    @selenium.type "owner_city", "Charlottesville"
    @selenium.type "owner_state", "VA"
    @selenium.type "owner_zip", "22903"
    @selenium.type "owner_phone", "434-466-1467"
    @selenium.type "owner_email", "somebody@somewhere.com"
    @selenium.type "owner_stable", "Brown Stables"
    @selenium.type "owner_amount_paid", "10"
    @selenium.click "owner_payment_type_id"
    @selenium.select "owner_payment_type_id", "label=Check"
    @selenium.click "//option[@value='2']"
    @selenium.click "owner_check_number"
    @selenium.type "owner_check_number", "056"
    @selenium.click "commit"
    assert !60.times{ break unless (@selenium.is_text_present("Create Owner") rescue true); sleep 1 }
    @selenium.open "/selenium_tester/owner_name_to_id/" + owner_name
    owner_id = @selenium.get_value("owner_id")
    @selenium.open "/"
    @selenium.answer_on_next_prompt "true"
    @selenium.click "//a[@id='owner_delete_" + owner_id + "']"
    assert !60.times{ break unless (@selenium.is_text_present(owner_name) rescue true); sleep 1 }
    assert !@selenium.is_text_present(owner_name)
  end
end
