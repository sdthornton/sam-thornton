require 'test_helper'

class SlugTest < ActiveSupport::TestCase
  test "slug should have a url" do
    post = Post.create(title: "Test Post", content: "Test post content")

    slug = Slug.new
    slug.post = Post.find_by(url: "test_post")

    assert_not slug.save, "Slug saved without a url"
  end

  test "slug should belong to a post" do
    post = Post.create(title: "Test Post", content: "Test post content")

    slug = Slug.new
    slug.url = "a_test_slug"

    assert_not slug.save, "Slug saved without an associated Post"
  end
end
