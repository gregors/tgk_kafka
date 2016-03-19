require 'spec_helper'
require 'tempfile'

module TGK
  module Kafka
    describe Server do
      describe '.new' do
        it 'returns a new server instance' do
          expect(Server.new).to be
        end
      end

      describe '#run' do
        it 'starts zookeeper' do
          expect(subject.run).to_not be_nil
        end
      end
    end
  end
end
