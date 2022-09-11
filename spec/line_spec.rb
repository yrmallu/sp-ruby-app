# frozen_string_literal: true

require_relative '../lib/line'

RSpec.describe Line do
  let(:line) { Line.new('test/home/4 123.456.789.000') }

  describe 'initialize' do
    it 'should split the origional line from the log file into path and ip attributes' do
      expect(line.path).to eq('test/home/4')
      expect(line.ip).to eq('123.456.789.000')
    end
  end
end
