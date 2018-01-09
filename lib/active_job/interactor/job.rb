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
          arguments.first.try(:constantize)
        else
          self.class.name.gsub(/Job\Z/, '').constantize
        end
      rescue NameError => e
        raise NameError, "Interactor class does not exist: #{self.class.name.gsub(/Job\Z/, '')}"
      end
    end
  end
end
