require 'spec_helper'
require 'stringio'

RSpec.describe Printer do
  include_context 'Processed CSV'

  let(:headers) { ['Kwota', 'Data waluty'] }

  subject { described_class.new }

  describe '.print_row' do
    it 'prints given row to stdout' do
      expect { subject.print_row(processed_csv[1], headers) }.to output.to_stdout
    end
  end

  describe '.prompt_until' do
    before do
      io = StringIO.new
      io.puts 'sport'
      io.rewind

      $stdin = io
    end

    after { $stdin = STDIN }

    let(:valid_values) { %w[sport rozrywka] }

    it 'returns prompted value' do
      expect(subject.prompt_until(valid_values)).to eq('sport')
    end
  end
end
