require 'test_helper'

class PostTest < ActiveSupport::TestCase
  fixtures :posts

  test "post should only save if title and content aren't blank" do
    post = Post.new
    assert_not post.save, "Post saved even though title and content were blank."

    post.title = "Test Post"
    assert_not post.save, "Post saved even though content is blank."

    post.title = ""
    post.content = "<p>This is a nice test post.</p><p>I hope you've enjoyed it.</p>"
    assert_not post.save, "Post saved even though title is blank."

    post.title = "Test Post"
    assert post.save, "Post didn't save even though title and content weren't blank."
  end

  test "post should have a unique title" do
    post = Post.new
    post.title = "Test Post"
    post.content = "Test post content"
    post.save

    post2 = Post.new
    post2.title = "Test Post"
    post2.content = "Test post content"
    assert_not post2.save, "Post saved even though title is not unique."
  end

  test "post url should be underscore version of post title" do
    post = Post.new
    post.title = "A Nice Test Post"
    post.content = "<p>This is a test post.</p>"
    post.save
    assert post.url == "a_nice_test_post", "Post url didn't match the underscored title."
  end

  test "post should have slugs" do
    post = Post.new
    post.title = "A Slug Test"
    post.content = "<p>Slug test post.</p>"
    post.save
    assert post.slugs.first.url == "a_slug_test", "A slug should be present after post creation"

    post.title = "Updated Slug Test"
    post.url = "updated_slug_test"
    post.save
    assert post.slugs.second.url == "updated_slug_test", "A slug should be present after post update"
  end

  test "deleting a post should delete its slugs" do
    post = Post.new
    post.title = "A Slug Test"
    post.content = "<p>Slug test post.</p>"
    post.save

    post.title = "Updated Slug Test"
    post.url = "updated_slug_test"
    post.save

    assert Slug.find_by(url: "a_slug_test").present?, "A slug should be present that matches post creation"
    assert Slug.find_by(url: "updated_slug_test").present?, "A slug should be present that matches post update"

    post.destroy

    assert Slug.find_by(url: "a_slug_test").nil?, "Slugs attached to post should have been destroyed after post destroy"
    assert Slug.find_by(url: "updated_slug_test").nil?, "Slugs attached to post should have been destroyed after post destroy"
  end
end
