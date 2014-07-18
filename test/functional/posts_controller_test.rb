require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  setup do
    @admin = create(:admin)
    sign_in :admin, @admin

    @valid_post = attributes_for(:post, title: "Post 1", content: "A test post")
    @invalid_post = attributes_for(:post, title: "", content: "")
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
      assert_difference('Post.count') do
        post(:create, post: @valid_post)
      end
      assert_redirected_to post_path(assigns(:post))
      assert_equal 'Post successfully created', flash[:notice]
    end

    should 'not create post' do
      post(:create, post: @invalid_post)
      assert_equal 0, Post.count
      assert_template :new
      assert_equal 'Post was not saved. Errors are present.', flash[:error]
    end
  end

  context '#show' do
    should 'successfully get :show' do
      @post = create(:post, @valid_post)
      get :show, id: @post.id
      assert_redirected_to show_post_path(@post.url)
    end
  end

  context '#edit' do
    should 'successfully get :edit and assign post' do
      @post = create(:post, @valid_post)
      get :edit, id: @post.id
      assert_response :success
    end
  end

  context '#update' do
    should 'successfully update post and redirect to post path' do
      @post = create(:post, @valid_post)
      patch :update, id: @post.id, post: @valid_post
      assert_redirected_to show_post_path(@post.url)
    end

    should 'not update post and render post edit' do
      @post = create(:post, @valid_post)
      patch :update, id: @post.id, post: @invalid_post
      assert_template :edit
    end
  end

  context '#destroy' do
    should 'destroy post' do
      @post = create(:post, @valid_post)
      assert_difference('Post.count', -1) do
        delete :destroy, id: @post.id
      end
      assert_redirected_to blog_path
    end
  end
end
