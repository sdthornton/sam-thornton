require 'test_helper'

class BlogControllerTest < ActionController::TestCase

  setup do
    @post_1 = create(:post, title: "Post 1", content: "A test post")
    @post_2 = create(:post, title: "Post 2", content: "Another test post")
  end

  context '#index' do
    should 'respond to routes' do
      assert_routing '/blog', controller: 'blog', action: 'index'
      assert_routing blog_path, controller: 'blog', action: 'index'
    end

    should 'successfully get :index' do
      get :index
      assert_response :success
      assert_template :index
    end

    should 'assign @posts' do
      get :index
      assert_not_nil assigns(:posts)
    end
  end

  context '#show' do
    should 'respond to /blog/a_test_post and show_post_path' do
      assert_routing "/blog/post-1", controller: 'blog', action: 'show', url: @post_1.url
      assert_routing show_post_path(@post_1.url), controller: 'blog', action: 'show', url: @post_1.url
    end

    should  'successfully get :show' do
      get :show, { url: @post_1.url }
      assert_response :success
      assert_template :show
      assert_template layout: "layouts/application"
    end

    should 'assign @post' do
      get :show, { url: @post_1.url }
      assert_not_nil assigns(:post)
      assert_equal @post_1, @controller.instance_variable_get('@post'),
        "@post should contain @post_1"
    end
  end

end
