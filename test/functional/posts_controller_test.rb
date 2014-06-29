require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  setup do
    @admin_attrs = {
      email: "admin@email.com",
      password: "testing123"
    }
    @admin = create(:admin, @admin_attrs)
    login_as(@admin, scope: :admin)

    @valid_post = attributes_for(:post, title: "Post 1", content: "A test post")
    @invalid_post = attributes_for(:post, title: "Post 1", content: "bad")
  end

  context '#new' do
    should 'respond to routes' do
      assert_routing '/blog/posts/new', controller: 'posts', action: 'new'
      assert_routing new_post_path, controller: 'posts', action: 'new'
    end

    should 'sucessfully get :new and assign post' do
      get :new
      assert_response :success
      assert_template :new
      assert_not_nil assigns(:post)
    end
  end

  context '#create' do
    should 'successfully create a post' do
      post :create, post: @valid_post
    end
  end

  context '#show' do

  end

  context '#edit' do

  end

  context '#update' do

  end

  context '#destroy' do

  end
end
