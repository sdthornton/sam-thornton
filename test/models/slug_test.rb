require 'test_helper'

class SlugTest < ActiveSupport::TestCase
  context 'slug validation' do
    should 'have a url' do
      @slug = build(:slug, url: "")
      assert !@slug.save,
        "Slug saved without a url"
    end
  end

  context 'associations' do
    should belong_to(:post)
  end
end
