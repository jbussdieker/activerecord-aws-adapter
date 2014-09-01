require 'active_record'

module ActiveRecord
  class Base
    def self.aws_connection(config)
      ConnectionAdapters::AwsAdapter.new(config)
    end
  end

  module ConnectionAdapters
    class AwsAdapter < AbstractAdapter
    end
  end
end
