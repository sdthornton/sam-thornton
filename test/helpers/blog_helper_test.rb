require 'test_helper'

class BlogHelperTest < ActionView::TestCase
  context '#render_disqus_comments' do
    should 'render disqus partial' do
      render_disqus_comments
      assert_template partial: 'shared/_disqus'
    end
  end
end
