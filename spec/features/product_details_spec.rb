require 'rails_helper'

RSpec.feature "User navigates from home page to product detail page", type: :feature, js: true do

  # Setup
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They see the product details" do
   
    visit root_path

    expect(page).to have_no_css('.product-detail')

    find('.product .pull-right', match: :first).click
    find('.product .fa-shopping-cart', match: :first).click
   
    save_screenshot

   
    expect(page).to have_css('.product-detail')
  end

end