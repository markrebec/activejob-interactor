require 'active_job/interactor/job_failure'

module ActiveJob
  module Interactor
    class Job < ActiveJob::Base
      queue_as :default

      def perform(*args, **context)
        result = interactor.call(**context)
        raise ActiveJob::Interactor::JobFailure, result.error if result.failure?
      end

      def interactor
        if self.class == ActiveJob::Interactor::Job
          begin
            arguments.first.try(:constantize)
          rescue NameError => e
            raise ArgumentError, "Invalid argument: '#{arguments.first.to_s}' is not a valid interactor"
          end
        else
          begin
            self.class.name.gsub(/Job\Z/, '').constantize
          rescue NameError => e
            raise NameError, "Interactor class '#{self.class.name.gsub(/Job\Z/, '')}' does not exist"
          end
        end
      end
    end
  end
end
