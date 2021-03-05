require 'spec_helper'

RSpec.describe Balance do
  include_context 'Processed CSV'

  subject { described_class.new(processed_csv).calculate }

  describe '.calculate' do
    it 'calculates total income' do
      expect(subject[:income]).to eq(110)
    end

    it 'calculates total expense' do
      expect(subject[:expense]).to eq(-106.5)
    end
  end
end
