require 'spec_helper'
require 'stringio'

RSpec.describe Categories do
  include_context 'Processed CSV'

  subject { described_class.new }

  it 'returns expenses iterator' do
    expect(subject.categorize).to be_a(Enumerator)
  end
end
