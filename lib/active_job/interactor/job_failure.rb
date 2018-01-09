module ActiveJob
  module Interactor
    class JobFailure < ::StandardError
      attr_reader :original_error

      def initialize(error)
        super("#{error.class.name}: #{error.message}")
        set_backtrace(error.backtrace)
        @original_error = error
      end
    end
  end
end
