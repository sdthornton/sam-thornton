require 'test_helper'

class ContactControllerTest < ActionController::TestCase
  setup do
    Pony.stubs(:deliver).returns(true)
  end

  context '#new' do
    should 'respond to routes' do
      assert_routing '/contact', controller: 'contact', action: 'new'
      assert_routing contact_path, controller: 'contact', action: 'new'
    end

    should 'successfuly get :new and assign @message' do
      get :new
      assert_response :success
      assert_template :new
      assert_not_nil assigns(:message)
    end
  end

  context '#create' do
    setup do
      @invalid_message = attributes_for(:message, email: "test", body: "message")
      @valid_message = attributes_for(:message)
    end

    should 'not create a contact message with an invalid email' do
      post :create, message: @invalid_message
      assert_response :success
      assert_not_nil assigns(:message)
      assert_template :new
      assert_equal 'Something went wrong', flash[:alert]
    end

    should 'create a contact message' do
      post :create, message: @valid_message
      assert_not_nil assigns(:message)
      assert_response :redirect
      assert_redirected_to contact_path
      assert_equal 'Hooray!', flash[:success]
    end
  end
end
