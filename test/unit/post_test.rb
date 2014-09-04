require 'test_helper'

class PostTest < ActiveSupport::TestCase

  context 'associations' do
    should have_many(:slugs)
  end

  context 'title' do
    setup do
      @post = build(:post, title: 'Test Post')
    end

    should 'save with a valid title' do
      assert @post.save,
        "Post didn't save with a valid title"
    end

    should 'not save when title is blank' do
      @post.title = ""
      assert !@post.save,
        "Post saved even though title was blank."
    end

    should 'not save when title is not unique' do
      @post.save
      @invalid_post = build(:post, title: "Test Post")
      assert !@invalid_post.save,
        "Post saved even though title wasn't unique"
    end
  end

  context 'content' do
    setup do
      @post = build(:post)
    end

    should 'save with valid content' do
      assert @post.save,
        "Post didn't save with valid content"
    end

    should 'not save when content is blank' do
      @post.content = ""
      assert !@post.save,
        "Post saved even though content was blank"
    end
  end

  context 'url' do
    should 'save a post with an underscored version of title' do
      @post = create(:post, title: "Foo Bar Baz")
      assert_equal "foo-bar-baz", @post.url,
        "Post url didn't match the underscored title"
    end
  end

  context 'slugs' do
    setup do
      @post = create(:post, title: "A Slug Test")
    end

    should 'create a slug when a post is created' do
      assert_equal 'a-slug-test', @post.slugs.first.url,
        "A slug should be created after creating a post"
    end

    should 'create slugs when post title or url is updated' do
      @post.title = "Updated Slug Test"
      @post.save
      assert_equal 'updated-slug-test', @post.slugs.second.url,
        "A slug should be created after updating a post's title"

      @post.url = "updating-the-slug-again"
      @post.save
      assert_equal 'updating-the-slug-again', @post.slugs.third.url,
        "A slug should be created after updating a post's url"
    end

    should 'not create slugs when title or url is not changed' do
      @post.content = "Updating content"
      @post.save
      assert_equal 1, @post.slugs.count,
        "A slug was created even though post url didn't change"
      assert_equal "a-slug-test", @post.slugs.first.url,
        "The slug url changed even though the post url didn't change"
    end

    should 'delete associated slugs when post is destroyed' do
      assert_equal 1, Slug.where(url: "a-slug-test").count,
        'There was no slug associated with the post'

      @post.destroy
      assert_equal 0, Slug.where(url: "a-slug-test").count,
        'The slug was not deleted when the post was destroyed'
    end
  end
end
