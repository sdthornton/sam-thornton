require 'test_helper'

class PostTest < ActiveSupport::TestCase
  fixtures :posts

  test "Post fields cannot be empty" do
    post = Post.new
    assert post.invalid?
    assert post.errors[:title].any?
    assert post.errors[:text].any?
    assert post.errors[:url].any?
  end

  test "Post must have content" do
    post = Post.new
    post.title = posts(:one).title
    assert post.invalid?
    assert_equal "can't be blank", post.errors[:text].join(', ')
  end

  test "Post must have a title" do
    post = Post.new
    post.text = posts(:one).text
    assert post.invalid?
    assert_equal "can't be blank", post.errors[:title].join(', ')
  end

  test "Post has a url created" do
    post = Post.new
    post.title = posts(:two).title
    post.text = posts(:two).text
    post.save
    assert post.url.present?
    assert post.url = post.title.parameterize.underscore.to_s
  end

  test "Post title must be unique" do
    post1 = Post.new
    post1.title = posts(:three).title
    post1.text = posts(:three).text
    post1.valid?

    post2 = Post.new
    post2.title = posts(:three).title
    post2.text = posts(:three).text
    assert post2.invalid?, "Post saved without a unique title"
    assert_equal "has already been taken", post2.errors[:title].join(', ')
  end

  test "Post must have a unique url" do
    post1 = Post.new(title: "Test Post", text: "a test post", url: "test_post")
    post1.save
    post1.valid?

    post2 = Post.new(title: "Test Post 2", text: "another test post", url: "test_post")
    post2.save
    assert post2.invalid?, "Post was saved with a non-unique url"
  end
end
