
class ActiveSupport::TestCase
   
  
  def create_new_person(name, email)
    visit "/people/new"
    fill_in('Name', :with => name)
    fill_in('Email', :with => email)
    click_button('Create Person')
    assert page.has_content?('Person was successfully created')
  end
  
  
end

