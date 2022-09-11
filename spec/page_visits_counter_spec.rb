# frozen_string_literal: true

require_relative '../lib/line'
require_relative '../lib/page_visits_counter'

RSpec.describe PageVisitsCounter do
  describe 'add somthing to the hash' do
    let(:subject) { described_class.new }

    # create some test lines
    let(:help_page_1_line_split) { Line.new('/help_page/1 722.247.931.582') }
    let(:about_line_split) { Line.new('/about/2 200.017.277.774') }
    let(:home_line_split) { Line.new('/home 722.247.931.582') }
    let(:contact_line_split) { Line.new('/contact 444.701.448.104') }
    let(:index_line_split) { Line.new('/index 200.017.277.774') }

    # fill up the page_counts hash in subject
    before do
      2.times { subject.add(help_page_1_line_split) }
      4.times { subject.add(about_line_split) }
      subject.add(home_line_split)
      3.times { subject.add(contact_line_split) }
    end

    context 'the path does not already exist in the hash' do
      it 'adds the path /help_page/1 to the hash page_counts' do
        # add index page ( not already in hash)
        subject.add(index_line_split)
        expect(subject.results).to eq(['/about/2 4 visits', '/contact 3 visits', '/help_page/1 2 visits',
                                       '/home 1 visits', '/index 1 visits'])
      end
    end

    context 'the path already exist in the hash' do
      it 'increments the value associated with the path key' do
        subject.add(contact_line_split)
        expect(subject.results).to eq(['/about/2 4 visits', '/contact 4 visits', '/help_page/1 2 visits',
                                       '/home 1 visits'])
      end
    end

    it 'prints the pages out in descending count order' do
      5.times { subject.add(index_line_split) }

      expect(subject.results).to eq(['/index 5 visits', '/about/2 4 visits', '/contact 3 visits',
                                     '/help_page/1 2 visits', '/home 1 visits'])
    end
  end
end
