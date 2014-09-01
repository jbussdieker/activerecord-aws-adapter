require 'active_record'
require 'aws-sdk'
#require 'arel/visitors/aws'

module ActiveRecord
  class Base
    def self.aws_connection(config)
      ConnectionAdapters::AwsAdapter.new(config, logger)
    end
  end

  module ConnectionAdapters
    class AwsAdapter < AbstractAdapter
      def select_all(arel, name = nil, binds = [])
        pp arel
        pp name
        pp binds

        result = nil

        AWS.memoize do
          if name =~ /Region/
            result = ActiveRecord::Result.new(["region_name", "region_endpoint"],
              AWS::EC2.new.regions.collect { |r| [r.name, r.endpoint] }
            )
          elsif name =~ /Instance/
            result = ActiveRecord::Result.new(["instance_id", "instance_type"],
              AWS::EC2.new.regions.first.instances.collect { |i| [i.instance_id, i.instance_type] }
            )
          end
        end

        result
      end

      # Array<String> table names
      def tables
        ["regions", "instances"]
      end

      # Array<String> table names
      def columns(table)
        {
          "regions" => [
            Column.new("region_name", nil),
            Column.new("region_endpoint", nil),
          ],
          "instances" => [
            Column.new("instance_id", nil),
            Column.new("instance_type", nil),
          ]
        }[table]
      end

      # Can this adapter determine the primary key for tables not attached
      # to an Active Record class, such as join tables?
      def supports_primary_key?
        true
      end

      def primary_key(table)
        {
          "regions" => "region_name",
        }[table]
      end
    end
  end
end
