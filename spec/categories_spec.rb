require 'spec_helper'
require 'stringio'

RSpec.describe Categories do
  include_context 'Processed CSV'

  subject { described_class.new(processed_csv) }

  describe '.categorize' do
    before do
      io = StringIO.new
      io.puts 'sport'
      io.puts 'sport'
      io.puts 'sport'
      io.puts 'sport'
      io.puts 'sport'
      io.puts 'sport'
      io.rewind

      $stdin = io
    end
    after { $stdin = STDIN }

    it 'adds new column' do
      expect { subject.categorize }.to change { processed_csv.headers.size }.by(1)
    end

    it 'returns a hash' do
      expect(subject.categorize).to be_a(CSV::Table)
    end

    it 'returns categorized expenses' do
      expect(subject.categorize.headers).to include('Category')
    end

    it 'sums expenses for each category' do
      expect(subject.categorize['sport']).to be_an(Array)
    end
  end
end
