require 'test_helper'

class CapybraTest < ActionDispatch::IntegrationTest
  
  # fixtures :all
  
  def test_javascript
    visit "/people"
    assert page.has_no_xpath?("//*[text()='Hello World!']")
    click_link("Show")
    assert page.has_xpath?("//div[text()='Hello World!']")
  end

  def test_create_schmooky
    visit "/people/new"
    fill_in('Name', :with => "Schooky Gnu")
    fill_in('Email', :with => "schmooky@gmail.com")
    click_button('Create Person')
    assert page.has_content?('Person was successfully created')
  end
    
  def test_see_yoohoo
    # assert_equal Person.all.size, 1 # person created on the test above via the web page
    # assert_equal Person.all[0].name, "Schooky Gnu"  
    # Person.delete_all
    person = Person.new
    assert_equal Person.all.size, 0
    person.name = "Yoohoo"
    person.email = "yoohoo@gmail.com"
    assert person.save                     # passes
    assert_equal Person.all.size, 1   # passes, but the new person does not show in the test db
    assert_equal Rails.env, "test"

    visit "/people"
    assert page.has_content?('Yoohoo')              # fails, seems that the person was not found in the test db
    assert page.has_content?('yoohoo@gmail.com')
  end    
  
  def test_the_helper
    create_new_person("Moomoo Skidoo", "moomoo@gmail.com")
    visit "/people"
    assert page.has_content?('Moomoo Skidoo')
    assert page.has_content?('moomoo@gmail.com')
  end
    
end
