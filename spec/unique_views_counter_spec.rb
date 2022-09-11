# frozen_string_literal: true

require_relative '../lib/line'
require_relative '../lib/unique_views_counter'

RSpec.describe UniqueViewsCounter do
  describe 'add somthing to the hash' do
    let(:subject) { described_class.new }

    # create some test lines
    let(:home_line_split) { Line.new('/home 722.247.931.582') }
    let(:home_2_line_split) { Line.new('/home 200.017.277.774') }
    let(:home_3_line_split) { Line.new('/home 722.247.931.582') }
    let(:contact_line_split) { Line.new('/contact 444.701.448.104') }
    let(:index_line_split) { Line.new('/index 200.017.277.774') }
    let(:contact_2_line_split) { Line.new('/contact 451.106.204.921') }

    # fill up the page_counts hash in test_page_visits_counter
    before do
      subject.add(home_line_split)
      subject.add(home_2_line_split)
      subject.add(home_3_line_split)
      subject.add(contact_line_split)
    end

    it 'prints the pages out in decending count order' do
      expect(subject.results).to eq(['/home 2 unique views', '/contact 1 unique views'])
    end
    context 'the path does not already exist in the hash' do
      it 'adds the path to the hash page_counts' do
        # add index page ( not already in hash)
        subject.add(index_line_split)
        expect(subject.results).to eq(['/home 2 unique views', '/contact 1 unique views', '/index 1 unique views'])
      end
    end

    context 'the path already exist in the hash but its a unique ip' do
      it 'increments the value associated with the path key' do
        subject.add(contact_2_line_split)
        expect(subject.results).to eq(['/home 2 unique views', '/contact 2 unique views'])
      end
    end
    context 'the path already exist in the hash and the ip is not unique' do
      it 'increments the value associated with the path key' do
        subject.add(contact_line_split)
        expect(subject.results).to eq(['/home 2 unique views', '/contact 1 unique views'])
      end
    end
  end
end
