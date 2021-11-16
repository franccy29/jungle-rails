require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it "should validate" do
      @category = Category.new(name: 'Apparel')
      @product = Product.new(name: "goodName", price: 13, quantity: 12, category: @category)
      expect(@product). to be_present
    end

    it "should not validate cause there's no name" do
      @category = Category.new(name: 'Apparel')
      @product = Product.new(name: nil, price: 13, quantity: 12, category: @category)
      @product.errors.full_messages
    end

    it "should not validate cause there's no price" do
      @category = Category.new(name: 'Apparel')
      @product = Product.new(name: "goodName", price: nil, quantity: 12, category: @category)
      @product.errors.full_messages
    end

    it "should not validate cause there's no quantity" do
      @category = Category.new(name: 'Apparel')
      @product = Product.new(name: "goodName", price: 13, quantity: nil, category: @category)
      @product.errors.full_messages
    end

    it "should not validate cause there's no category" do
      @product = Product.new(name: "goodName", price: 13, quantity: 12, category: nil)
      @product.errors.full_messages
    end

  end
end