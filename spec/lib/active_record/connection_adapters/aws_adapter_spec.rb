require 'spec_helper'

module ActiveRecord
  module ConnectionAdapters
    describe AwsAdapter do
      let(:connection) { nil }
      let(:aws_adapter) { AwsAdapter.new(connection) }
      subject { aws_adapter }

      it { should be_kind_of AbstractAdapter }
    end
  end
end
