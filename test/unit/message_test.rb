require 'test_helper'

class MessageTest < ActiveSupport::TestCase

  context '#deliver' do
    should 'be a valid message' do
      @message = build(:message)
      assert @message.valid?
    end

    should 'be invalid when name is not present' do
      @message = build(:message, name: '')
      assert_equal false, @message.valid?
    end

    should 'be invalid when email is not present' do
      @message = build(:message, email: '')
      assert_equal false, @message.valid?
    end

    should 'be invalid when email does not match format' do
      @message = build(:message, email: 'sam')
      assert_equal false, @message.valid?
    end

    should 'be invalid when subject is not present' do
      @message = build(:message, subject: '')
      assert_equal false, @message.valid?
    end

    should 'be invalid when body is not present' do
      @message = build(:message, body: '')
      assert_equal false, @message.valid?
    end

    should 'be invalid when body is less than 10 characters' do
      @message = build(:message, body: 'not long')
      assert_equal false, @message.valid?
    end
  end
end
