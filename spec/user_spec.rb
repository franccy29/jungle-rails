require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    it 'should create a new user if all the fields are present' do
      @user = User.new(
        first_name: 'test',
        last_name: 'testu',
        email: 'test@gmail.com',
        password: 'testjungleproj',
        password_confirmation: 'testjungleproj',
      )
      expect(@user.valid?).to be(true)
    end

    it 'should not create a new user if the first name is not present' do
      @user = User.new(
        first_name: nil,
        last_name: 'testu',
        email: 'test@gmail.com',
        password: 'testjungleproj',
        password_confirmation: 'testjungleproj',
      )
      @user.errors.full_messages
    end

    it 'should not create a new user if the last name is not present' do
      @user = User.new(
        first_name: 'test',
        last_name: nil,
        email: 'test@gmail.com',
        password: 'testjungleproj',
        password_confirmation: 'testjungleproj',
      )
      @user.errors.full_messages
    end

    it 'should not create a new user if the email is not present' do
      @user = User.new(
        first_name: 'test',
        last_name: 'testu',
        email: nil,
        password: 'testjungleproj',
        password_confirmation: 'testjungleproj',
      )
      @user.errors.full_messages
    end

    it 'should not create a new user if the password is not present' do
      @user = User.new(
        first_name: 'test',
        last_name: 'testu',
        email: 'test@gmail.com',
        password: nil,
        password_confirmation: 'testjungleproj',
      )
      @user.errors.full_messages
    end

    it 'should not create a new user if the password confirmation is not present' do
      @user = User.new(
        first_name: 'test',
        last_name: 'testu',
        email: 'test@gmail.com',
        password: 'testjungleproj',
        password_confirmation: nil
      )
      @user.errors.full_messages
    end

    it 'should not create a new user if the password confirmation does not match the password' do
      @user = User.new(
        first_name: 'test',
        last_name: 'testu',
        email: 'test@gmail.com',
        password: 'testjungleproj',
        password_confirmation: 'testjungleproj1',
      )
      @user.errors.full_messages
    end
    
    it 'should not create a new user if the email is a duplicate' do
      @user = User.new(
        first_name: 'test',
        last_name: 'testu',
        email: 'test@gmail.com',
        password: 'testjungleproj',
        password_confirmation: 'testjungleproj',
      )
      @user.save
      @user_duplicate = User.new(
        first_name: 'test',
        last_name: 'testu',
        email: 'test@gmail.com',
        password: 'testjungleproj1',
        password_confirmation: 'testjungleproj1',
      )      
      expect(@user.valid?).to be(true)
      expect(@user_duplicate.valid?).to be(false)
    end
    
    it 'should not create a new user if the password is less than 10 characters long' do
      @user = User.new(
        first_name: 'test',
        last_name: 'testu',
        email: 'test@gmail.com',
        password: 'test',
        password_confirmation: 'test',
        )
        @user.errors.full_messages
      end
  
  end
    
  describe '.authenticate_with_credentials' do
    
    it 'should log the user in if they are registered and the password is correct' do
      @user = User.new(
        first_name: 'test',
        last_name: 'testu',
        email: 'test@gmail.com',
        password: 'testjungleproj',
        password_confirmation: 'testjungleproj'
      )
      @user.save!
      expect(User.authenticate_with_credentials('test@gmail.com', 'testjungleproj')).to be_truthy
    end
  
    it 'should not log the user in if the password is incorrect' do
      @user = User.new(
        first_name: 'test',
        last_name: 'testu',
        email: 'test@gmail.com',
        password: 'testjungleproj',
        password_confirmation: 'testjungleproj'
      )
      @user.save!
      expect(User.authenticate_with_credentials('test@gmail.com', 'wrong')).to be(nil)
    end
  
    it 'should log the user in if the email includes spaces before or after' do
      @user = User.new(
        first_name: 'test',
        last_name: 'testu',
        email: 'test@gmail.com',
        password: 'testjungleproj',
        password_confirmation: 'testjungleproj'
      )
      @user.save!
      expect(User.authenticate_with_credentials(' test@gmail.com ', 'testjungleproj')).to be_truthy
    end
          
    it 'should log the user in if the email includes incorrectly cased characters' do
      @user = User.new(
        first_name: 'test',
        last_name: 'testu',
        email: 'test@gmail.com',
        password: 'testjungleproj',
        password_confirmation: 'testjungleproj'
      )
      @user.save!
      expect(User.authenticate_with_credentials('TEST@gmail.com', 'testjungleproj')).to be_truthy
    end
  end
end