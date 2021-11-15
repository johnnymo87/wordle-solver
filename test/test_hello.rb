# frozen_string_literal: true

require 'minitest/autorun'
require 'hello'

describe Hello do
  describe '.hello' do
    it 'should return the string "world"' do
      _(Hello.world).must_equal('world')
    end
  end
end
