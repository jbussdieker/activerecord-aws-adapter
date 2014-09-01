require 'arel/visitors/reduce'

module Arel
  module Visitors
    class Aws < Arel::Visitors::Reduce
      def initialize(object)
        @object = object
      end
    end
  end
end

